import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:ukhsc_mobile_app/core/env.dart';
import 'package:ukhsc_mobile_app/core/logger.dart';
import 'package:ukhsc_mobile_app/core/services/demo_data_service.dart';
import 'package:ukhsc_mobile_app/core/services/storage_service.dart';

import 'package:ukhsc_mobile_app/features/auth/data/auth_data_source.dart';
import 'package:ukhsc_mobile_app/features/auth/models/auth.dart';
import 'package:ukhsc_mobile_app/features/auth/models/server_status.dart';

import 'exception.dart';
import '../models/school.dart';
import '../models/user.dart';

class AuthCredential {
  final String accessToken;
  final String refreshToken;

  AuthCredential({required this.accessToken, required this.refreshToken});

  bool get isExpired {
    return _isExpired(accessToken) && _isExpired(refreshToken);
  }

  bool get isRefreshable {
    return !_isExpired(refreshToken);
  }

  TokenPayload get payload {
    return TokenPayload.fromJwt(accessToken);
  }

  bool _isExpired(String token) {
    final payload = TokenPayload.fromJwt(token);

    return payload.exp.isBefore(DateTime.now());
  }
}

abstract class AuthRepository {
  Future<ServiceStatus> getServiceStatus({CancelToken? cancelToken});
  FutureOr<List<SchoolWithConfig>> getPartnerSchools(
      {CancelToken? cancelToken});

  Future<AuthCredential> registerMember({
    required int schoolAttendanceId,
    required String authorizationCode,
    required String redirectUri,
    CancelToken? cancelToken,
  });

  Future<AuthCredential?> getCredential();
  Future<void> saveCredential(AuthCredential credential);
  // Warning: This method is only for quick check, it doesn't validate the token.
  Future<bool> hasCredential();
  Future<User?> getCredentialUser({
    required bool isOffline,
    CancelToken? cancelToken,
  });
}

class AuthRepositoryImpl implements AuthRepository {
  final AuthDataSource dataSource;
  final StorageService storage;

  final _logger = AppLogger.getLogger('auth.repo');

  AuthRepositoryImpl({required this.dataSource, required this.storage});

  @override
  FutureOr<List<SchoolWithConfig>> getPartnerSchools(
      {CancelToken? cancelToken}) {
    // Return demo schools for store reviewers
    if (AppEnvironment.isStoreReviewerMode) {
      _logger.info('Store reviewer mode detected, returning demo schools');
      final demoSchools = DemoDataService.getDemoSchools();
      for (final school in demoSchools) {
        DemoDataService.validateReviewerData(school, 'getPartnerSchools');
      }
      return demoSchools;
    }
    
    return dataSource.fetchPartnerSchools(cancelToken: cancelToken);
  }

  @override
  Future<ServiceStatus> getServiceStatus({CancelToken? cancelToken}) async {
    final server = await dataSource.fetchServerStatus(cancelToken: cancelToken);
    return server.status;
  }

  @override
  Future<AuthCredential> registerMember({
    required int schoolAttendanceId,
    required String authorizationCode,
    required String redirectUri,
    CancelToken? cancelToken,
  }) {
    return dataSource.postRegisterMember(
      schoolAttendanceId: schoolAttendanceId,
      authorizationCode: authorizationCode,
      redirectUri: redirectUri,
      cancelToken: cancelToken,
    );
  }

  @override
  Future<void> saveCredential(AuthCredential credential) async {
    await storage.migrateSchema();
    await storage.write(key: 'access_token', value: credential.accessToken);
    await storage.write(key: 'refresh_token', value: credential.refreshToken);

    // For store reviewers, save demo user data instead of fetching real data
    if (_isStoreReviewerSession(credential)) {
      _logger.info('Store reviewer session detected, saving demo user data');
      final demoUser = DemoDataService.getDemoUser();
      await storage.write(key: 'user_cache', value: jsonEncode(demoUser.toJson()));
    } else {
      final user =
          await dataSource.fetchUserData(accessToken: credential.accessToken);
      await storage.write(key: 'user_cache', value: jsonEncode(user.toJson()));
    }
    
    _logger.fine('Credential saved');
  }

  @override
  Future<bool> hasCredential() async {
    final credentials = await getCredential();
    return credentials != null;
  }

  @override
  Future<User?> getCredentialUser(
      {required bool isOffline, CancelToken? cancelToken}) async {
    final credentials = await getCredential();
    if (credentials == null) return null;

    // Check if this is a store reviewer session
    if (_isStoreReviewerSession(credentials)) {
      _logger.info('Store reviewer mode detected, returning demo user data');
      final demoUser = DemoDataService.getDemoUser();
      DemoDataService.validateReviewerData(demoUser, 'getCredentialUser');
      return demoUser;
    }

    if (credentials.isExpired) {
      _logger.warning('Access and refresh token is expired');
      throw CredentialExpiredException();
    }

    if (!isOffline && credentials.isRefreshable) {
      final newCredentials = await dataSource.refreshToken(
        refreshToken: credentials.refreshToken,
        cancelToken: cancelToken,
      );
      await saveCredential(newCredentials);
    }

    final rawCache = await storage.read('user_cache');
    if (rawCache == null) return null;

    return User.fromJson(jsonDecode(rawCache));
  }

  /// Checks if the current session is a store reviewer session
  /// by comparing the refresh token with the configured reviewer token
  /// or checking for the fallback reviewer access token
  bool _isStoreReviewerSession(AuthCredential credentials) {
    return AppEnvironment.isStoreReviewerMode && 
           (credentials.refreshToken == AppEnvironment.storeReviewerRefreshToken ||
            credentials.accessToken == 'REVIEWER_ACCESS_TOKEN');
  }

  @override
  Future<AuthCredential?> getCredential() async {
    await storage.migrateSchema();
    final accessToken = await storage.read('access_token');
    final refreshToken = await storage.read('refresh_token');

    if (accessToken == null || refreshToken == null) {
      return null;
    }

    return AuthCredential(accessToken: accessToken, refreshToken: refreshToken);
  }
}
