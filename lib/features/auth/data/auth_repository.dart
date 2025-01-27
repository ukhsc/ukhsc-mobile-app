import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:logging/logging.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'package:ukhsc_mobile_app/features/auth/data/auth_data_source.dart';
import 'package:ukhsc_mobile_app/features/auth/models/auth.dart';
import 'package:ukhsc_mobile_app/features/auth/models/server_status.dart';

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
  FutureOr<List<PartnerSchool>> getPartnerSchools({CancelToken? cancelToken});

  Future<AuthCredential> registerMember({
    required int schoolAttendanceId,
    required String authorizationCode,
    required String redirectUri,
    CancelToken? cancelToken,
  });

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
  final FlutterSecureStorage secureStorage;
  final _storageSchemaVersion = 1;

  final _logger = Logger('AuthRepositoryImpl');

  AuthRepositoryImpl({required this.dataSource, required this.secureStorage});

  @override
  FutureOr<List<PartnerSchool>> getPartnerSchools({CancelToken? cancelToken}) {
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
    await migrateSchema();
    await secureStorage.write(
        key: 'access_token', value: credential.accessToken);
    await secureStorage.write(
        key: 'refresh_token', value: credential.refreshToken);

    final user =
        await dataSource.fetchUserData(accessToken: credential.accessToken);
    await secureStorage.write(
        key: 'user_cache', value: jsonEncode(user.toJson()));

    final roles = credential.payload.roles;
    if (roles.contains(UserRole.studentMember)) {
      _logger.fine('Fetching member data...');
      final member =
          await dataSource.fetchMemberData(accessToken: credential.accessToken);
      await secureStorage.write(
          key: 'member_cache', value: jsonEncode(member.toJson()));
    }
    _logger.fine('Credential saved');
  }

  @override
  Future<bool> hasCredential() async {
    await migrateSchema();
    final credentials = await _getCredentials();
    return credentials != null;
  }

  @override
  Future<User?> getCredentialUser(
      {required bool isOffline, CancelToken? cancelToken}) async {
    await migrateSchema();
    final credentials = await _getCredentials();
    if (credentials == null) return null;

    if (credentials.isExpired) {
      _logger.warning('Access token is expired');
      throw UnimplementedError();
    }

    if (!isOffline && credentials.isRefreshable) {
      final newCredentials = await dataSource.refreshToken(
        refreshToken: credentials.refreshToken,
        cancelToken: cancelToken,
      );
      await saveCredential(newCredentials);
    }

    final rawCache = await secureStorage.read(key: 'user_cache');
    if (rawCache == null) return null;

    return User.fromJson(jsonDecode(rawCache));
  }

  Future<void> migrateSchema() async {
    final hasSchemaVersion =
        await secureStorage.containsKey(key: 'schema_version');
    if (!hasSchemaVersion) {
      _logger.warning('Schema version not found, trying to migrate...');
      final all = await secureStorage.readAll();
      if (all.isEmpty) {
        _logger.warning('No data found, skipping migration...');
        await _saveSchemaVersion();
        return;
      }
    }

    if (await _isSchemaOutdated()) {
      _logger.warning('Schema version is outdated, trying to migrate...');
      // TODO: in the future, we can implement a migration strategy (if we have version 2)
      await secureStorage.deleteAll();
      await _saveSchemaVersion();
      _logger.warning('Schema version migrated to $_storageSchemaVersion');
    }

    _logger.fine('Schema version is up-to-date');
  }

  Future<AuthCredential?> _getCredentials() async {
    final accessToken = await secureStorage.read(key: 'access_token');
    final refreshToken = await secureStorage.read(key: 'refresh_token');

    if (accessToken == null || refreshToken == null) {
      return null;
    }

    return AuthCredential(accessToken: accessToken, refreshToken: refreshToken);
  }

  Future<void> _saveSchemaVersion() async {
    await secureStorage.write(
        key: 'schema_version', value: _storageSchemaVersion.toString());
  }

  Future<bool> _isSchemaOutdated() async {
    final schemaVersion = await secureStorage.read(key: 'schema_version');
    _logger.fine('Current schema version: $schemaVersion');
    return schemaVersion != _storageSchemaVersion.toString();
  }
}
