import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'package:ukhsc_mobile_app/core/api/lib.dart';

import '../models/school.dart';
import '../models/member.dart';

part 'auth_repository.g.dart';

abstract class AuthRepository {
  FutureOr<List<PartnerSchool>> getPartnerSchools({CancelToken? cancelToken});

  Future<(String accessToken, String refreshToken)> registerMember({
    required int schoolAttendanceId,
    required String authorizationCode,
    required String redirectUri,
    CancelToken? cancelToken,
  });

  Future<void> saveCredentials({
    required String accessToken,
    required String refreshToken,
  });
}

class AuthRepositoryImpl implements AuthRepository {
  final ApiClient api;
  final FlutterSecureStorage secureStorage;

  AuthRepositoryImpl({required this.api, required this.secureStorage});

  @override
  FutureOr<List<PartnerSchool>> getPartnerSchools({
    CancelToken? cancelToken,
  }) async {
    final response = await api.request<List>(HttpMethod.get, '/school',
        cancelToken: cancelToken);

    switch (response) {
      case ApiResponseData(:final data):
        return data
            .map((e) => PartnerSchool.fromJson(e))
            .toList()
            .cast<PartnerSchool>();
      case ApiResponseError():
        throw Exception('Failed to fetch partner schools');
    }
  }

  @override
  Future<(String, String)> registerMember(
      {required int schoolAttendanceId,
      required String authorizationCode,
      required String redirectUri,
      CancelToken? cancelToken}) async {
    final response = await api.request<Map<String, dynamic>>(
      HttpMethod.post,
      '/member',
      data: {
        'school_attended_id': schoolAttendanceId,
        'google_workspace': {
          'flow': 'authorization_code',
          'grant_value': authorizationCode,
          'redirect_uri': redirectUri,
        }
      },
    );

    switch (response) {
      case ApiResponseData(:final data):
        final accessToken = data['access_token'] as String;
        final refreshToken = data['refresh_token'] as String;

        return (accessToken, refreshToken);
      case ApiResponseError():
        // TODO: handle various error cases
        throw Exception('Failed to register member');
    }
  }

  @override
  Future<void> saveCredentials(
      {required String accessToken, required String refreshToken}) async {
    await secureStorage.write(key: 'access_token', value: accessToken);
    await secureStorage.write(key: 'refresh_token', value: refreshToken);

    final response = await api.request<Map<String, dynamic>>(
      HttpMethod.get,
      '/member/me',
      token: accessToken,
    );

    switch (response) {
      case ApiResponseData(:final data):
        print(data);
        final member = StudentMember.fromJson(data);
        await secureStorage.write(
            key: 'member_cache', value: jsonEncode(member.toJson()));
      case ApiResponseError(:final statusCode):
        // TODO: handle various error cases
        throw Exception('Failed to fetch member data');
    }
  }
}

@riverpod
AuthRepository authRepository(Ref ref) {
  return AuthRepositoryImpl(
    api: ref.read(apiClientProvider),
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

  final tokens = await repository.registerMember(
    schoolAttendanceId: schoolAttendanceId,
    authorizationCode: authorizationCode,
    redirectUri: redirectUri,
    cancelToken: ref.cancelToken,
  );
  await repository.saveCredentials(
      accessToken: tokens.$1, refreshToken: tokens.$2);
}
