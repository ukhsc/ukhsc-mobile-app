import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:logging/logging.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:ukhsc_mobile_app/core/api/lib.dart';
import 'package:ukhsc_mobile_app/core/logger.dart';

import '../models/school.dart';
import '../models/user.dart';
import '../models/server_status.dart';
import 'auth_data_source.dart';
import 'auth_repository.dart';

part 'provider.g.dart';

@riverpod
AuthRepository authRepository(Ref ref) {
  return AuthRepositoryImpl(
    dataSource: AuthDataSource(api: ref.read(apiClientProvider)),
    secureStorage: FlutterSecureStorage(),
  );
}

@riverpod
Future<List<PartnerSchool>> partnerSchools(Ref ref) async {
  final repository = ref.read(authRepositoryProvider);
  final schools =
      await repository.getPartnerSchools(cancelToken: ref.cancelToken);
  schools.shuffle();

  return schools;
}

@riverpod
Future<void> registerMember(
  Ref ref, {
  required int schoolAttendanceId,
  required String authorizationCode,
  required String redirectUri,
}) async {
  final repository = ref.read(authRepositoryProvider);
  final credential = await repository.registerMember(
    schoolAttendanceId: schoolAttendanceId,
    authorizationCode: authorizationCode,
    redirectUri: redirectUri,
    cancelToken: ref.cancelToken,
  );

  final notifier = ref.read(userStateNotifierProvider.notifier);
  await notifier.login(credential);
}

class UserState {
  final User? user;
  final bool isOffline;

  const UserState({this.user, required this.isOffline});
}

@Riverpod(keepAlive: true)
class UserStateNotifier extends _$UserStateNotifier {
  final Logger _logger = AppLogger.getLogger('user_state');

  @override
  FutureOr<UserState?> build() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() => _fetchState());
    return state.value;
  }

  Future<void> login(AuthCredential credential) async {
    state = const AsyncValue.loading();

    state = await AsyncValue.guard(() async {
      final repository = ref.read(authRepositoryProvider);
      await repository.saveCredential(credential);
      return _fetchState();
    });
  }

  Future<UserState> _fetchState() async {
    await Future.delayed(const Duration(seconds: 1));
    bool offlineMode;
    try {
      offlineMode = !await _hasNetwork().timeout(Duration(seconds: 5));
    } on TimeoutException catch (_) {
      _logger.warning('Network check timeout, switching to offline mode');
      offlineMode = true;
    }

    final repository = ref.read(authRepositoryProvider);
    final user = await repository.getCredentialUser(isOffline: offlineMode);

    return UserState(user: user, isOffline: offlineMode);
  }

  Future<bool> _hasNetwork() async {
    _logger.fine('Checking network connectivity');
    final connectivity = await Connectivity().checkConnectivity();
    if (connectivity.contains(ConnectivityResult.none)) {
      return false;
    }
    if (connectivity.contains(ConnectivityResult.bluetooth) &&
        connectivity.length == 1) {
      return false;
    }

    final repository = ref.read(authRepositoryProvider);
    try {
      _logger.fine('Checking service status');
      final status =
          await repository.getServiceStatus(cancelToken: ref.cancelToken);
      if (status != ServiceStatus.normal) {
        _logger.warning('Service status is not normal: $status');
        return false;
      }
    } catch (err, stackTrace) {
      _logger.warning('Failed to check service status', err, stackTrace);
      return false;
    }

    return true;
  }
}
