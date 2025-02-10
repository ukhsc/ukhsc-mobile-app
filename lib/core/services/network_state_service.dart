import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:ukhsc_mobile_app/core/config/network_config.dart';
import 'package:ukhsc_mobile_app/core/error/lib.dart';
import 'package:ukhsc_mobile_app/core/logger.dart';
import 'package:ukhsc_mobile_app/features/auth/lib.dart';

part 'network_state_service.g.dart';

class NetworkStateService with WidgetsBindingObserver {
  static final _logger = AppLogger.getLogger('network_state');
  
  bool _isInForeground = true;
  DateTime? _lastCheckTime;
  
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    _isInForeground = state == AppLifecycleState.resumed;
    _logger.fine('App lifecycle state changed to: $state');
  }
}

@Riverpod(keepAlive: true)
Stream<bool> networkConnectivity(Ref ref) async* {
  final logger = NetworkStateService._logger;
  logger.fine('Initializing network connectivity monitoring...');
  
  // Initialize lifecycle observer
  final service = NetworkStateService();
  WidgetsBinding.instance.addObserver(service);
  
  // Clean up on dispose
  ref.onDispose(() {
    logger.fine('Disposing network connectivity monitoring...');
    WidgetsBinding.instance.removeObserver(service);
  });

  final controller = StreamController<bool>();
  
  // Debounce network state changes
  DateTime? lastNetworkEvent;
  bool shouldProcessEvent() {
    final now = DateTime.now();
    if (lastNetworkEvent != null &&
        now.difference(lastNetworkEvent!) < NetworkConfig.networkStateChangeDelay) {
      return false;
    }
    lastNetworkEvent = now;
    return true;
  }

  final initState = await onConnectivityChanged(
      await Connectivity().checkConnectivity(), ref);
  yield initState;


  final stream = Connectivity().onConnectivityChanged;
  final subscription = stream.listen((_) async {
    if (!shouldProcessEvent()) {
      logger.fine('Skipping network event due to debounce');
      return;
    }

    final results = await Connectivity().checkConnectivity();
    final state = await onConnectivityChanged(results, ref,
        checkImmediate: service._isInForeground);
    controller.add(state);
  });


  ref.onDispose(() {
    _logger.fine('Disposing network connectivity subscription...');
    subscription.cancel();
    controller.close();
  });

  yield* controller.stream;
}

Future<bool> onConnectivityChanged(
    List<ConnectivityResult> results,
    Ref ref, {
    bool checkImmediate = true
}) async {
  final isNoConnection = results.contains(ConnectivityResult.none) ||
      (results.contains(ConnectivityResult.bluetooth) && results.length == 1);


  if (isNoConnection) {
    _logger.warning(
        'No network connection detected, switching to offline mode...');
    return false;
  }

  if (!checkImmediate) {
    NetworkStateService._logger.fine(
      'Delaying service check due to background state'
    );
    await Future.delayed(NetworkConfig.backgroundCheckDelay);
  }

  final repo = ref.read(authRepositoryProvider);
  try {
    NetworkStateService._logger.fine('Checking service status');
    
    int retryCount = 0;
    while (retryCount < NetworkConfig.maxRetryAttempts) {
      final status = await repo.getServiceStatus();
      if (status == ServiceStatus.normal) {
        return true;
      }
      retryCount++;
      await Future.delayed(NetworkConfig.getRetryDelay(retryCount));
      return false;
    }
  } catch (err, stackTrace) {
    final notifier = ref.read(errorServiceProvider.notifier);
    notifier.handleError(
        AppErrorEvent(severity: ErrorSeverity.warning, message: '檢查服務狀態失敗'),
        originalError: err,
        stackTrace: stackTrace);
    _logger.warning('Failed to check service status', err, stackTrace);
    return false;
  }

  return true;
}
