import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:ukhsc_mobile_app/core/error/lib.dart';

import 'package:ukhsc_mobile_app/core/logger.dart';
import 'package:ukhsc_mobile_app/features/auth/lib.dart';

part 'network_state_service.g.dart';

final _logger = AppLogger.getLogger('network_state');

@Riverpod(keepAlive: true)
Stream<bool> networkConnectivity(Ref ref) async* {
  _logger.fine('Checking network connectivity...');

  final controller = StreamController<bool>();

  final initState = await onConnectivityChanged(
      await Connectivity().checkConnectivity(), ref);
  yield initState;

  final stream = Connectivity().onConnectivityChanged;
  final subscription = stream.listen((_) async {
    // Workaround: https://github.com/fluttercommunity/plus_plugins/issues/198
    final results = await Connectivity().checkConnectivity();
    final state = await onConnectivityChanged(results, ref);
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
    List<ConnectivityResult> results, Ref ref) async {
  final isNoConnection = results.contains(ConnectivityResult.none) ||
      (results.contains(ConnectivityResult.bluetooth) && results.length == 1);

  if (isNoConnection) {
    _logger.warning(
        'No network connection detected, switching to offline mode...');
    return false;
  }

  final repo = ref.read(authRepositoryProvider);
  try {
    _logger.fine('Checking service status');
    final isServiceAvailable =
        await repo.getServiceStatus() == ServiceStatus.normal;
    if (!isServiceAvailable) {
      _logger.warning(
          'API service is not available, switching to offline mode...');
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
