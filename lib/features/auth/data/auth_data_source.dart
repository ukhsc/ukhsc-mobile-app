import 'package:dio/dio.dart';
import 'package:logging/logging.dart';
import 'package:ukhsc_mobile_app/core/api/lib.dart';
import 'package:ukhsc_mobile_app/features/auth/models/member.dart';
import 'package:ukhsc_mobile_app/features/auth/models/server_status.dart';

import '../models/school.dart';
import '../models/user.dart';
import 'auth_repository.dart';

class AuthDataSource {
  final ApiClient api;
  AuthDataSource({required this.api});

  final _logger = Logger('AuthDataSource');

  Future<List<PartnerSchool>> fetchPartnerSchools({
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

  Future<ServerStatus> fetchServerStatus({
    CancelToken? cancelToken,
  }) async {
    final response = await api.request<Map<String, dynamic>>(
      HttpMethod.get,
      '/status',
      cancelToken: cancelToken,
    );

    switch (response) {
      case ApiResponseData(:final data):
        return ServerStatus.fromJson(data);
      case ApiResponseError():
        throw Exception('Failed to fetch server status');
    }
  }

  Future<User> fetchUserData({
    required String accessToken,
    CancelToken? cancelToken,
  }) async {
    final response = await api.request<Map<String, dynamic>>(
      HttpMethod.get,
      '/user/me',
      token: accessToken,
      cancelToken: cancelToken,
    );

    switch (response) {
      case ApiResponseData(:final data):
        return User.fromJson(data);
      case ApiResponseError():
        throw Exception('Failed to fetch user data');
    }
  }

  Future<AuthCredential> postRegisterMember(
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

        return AuthCredential(
            accessToken: accessToken, refreshToken: refreshToken);
      case ApiResponseError(:final data):
        _logger.severe('Failed to register member: $data');
        // TODO: handle various error cases
        throw Exception('Failed to register member');
    }
  }

  Future<StudentMember> fetchMemberData({
    required String accessToken,
    CancelToken? cancelToken,
  }) async {
    final response = await api.request<Map<String, dynamic>>(
      HttpMethod.get,
      '/member/me',
      token: accessToken,
      cancelToken: cancelToken,
    );

    switch (response) {
      case ApiResponseData(:final data):
        return StudentMember.fromJson(data);
      case ApiResponseError():
        throw Exception('Failed to fetch member data');
    }
  }

  Future<AuthCredential> refreshToken({
    required String refreshToken,
    CancelToken? cancelToken,
  }) async {
    final response = await api.request<Map<String, dynamic>>(
      HttpMethod.post,
      '/auth/token/refresh',
      data: {'refresh_token': refreshToken},
      cancelToken: cancelToken,
    );

    switch (response) {
      case ApiResponseData(:final data):
        final accessToken = data['access_token'] as String;
        final refreshToken = data['refresh_token'] as String;

        return AuthCredential(
          accessToken: accessToken,
          refreshToken: refreshToken,
        );
      case ApiResponseError(:final data):
        throw Exception('Failed to refresh token: $data');
    }
  }
}
