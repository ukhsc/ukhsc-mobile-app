import 'dart:async';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:ukhsc_mobile_app/core/api/lib.dart';
import 'package:ukhsc_mobile_app/core/services/network_state_service.dart';
import 'package:ukhsc_mobile_app/core/services/storage_service.dart';
import 'package:ukhsc_mobile_app/features/membership/presentation/provider.dart';

import '../models/school.dart';
import '../models/user.dart';
import '../data/auth_data_source.dart';
import '../data/auth_repository.dart';

part 'provider.g.dart';

@riverpod
AuthRepository authRepository(Ref ref) {
  return AuthRepositoryImpl(
    dataSource: AuthDataSource(api: ref.read(apiClientProvider)),
    storage: StorageService(),
  );
}

@riverpod
Future<List<SchoolWithConfig>> partnerSchools(Ref ref) async {
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

  await ref.read(userStateNotifierProvider.notifier).login(credential);
  await ref
      .read(memberRepositoryProvider)
      .updateCacheData(credential.accessToken, cancelToken: ref.cancelToken);
}

@Riverpod(keepAlive: true)
class UserStateNotifier extends _$UserStateNotifier {
  @override
  FutureOr<User?> build() {
    return _fetchState();
  }

  Future<void> login(AuthCredential credential) async {
    state = const AsyncValue.loading();

    state = await AsyncValue.guard(() async {
      await ref.read(authRepositoryProvider).saveCredential(credential);
      return _fetchState();
    });

    ref.notifyListeners();
  }

  Future<User?> _fetchState() async {
    final hasNetwork = await ref.read(networkConnectivityProvider.future);

    final user = await ref
        .read(authRepositoryProvider)
        .getCredentialUser(isOffline: !hasNetwork);

    return user;
  }
}
