import 'package:dio/dio.dart';
import 'package:ukhsc_mobile_app/core/api/lib.dart';
import 'package:ukhsc_mobile_app/features/auth/models/server_status.dart';

import '../models/school.dart';
import '../models/user.dart';
import 'auth_repository.dart';
import 'exception.dart';

class AuthDataSource {
  final ApiClient api;
  AuthDataSource({required this.api});

  Future<List<SchoolWithConfig>> fetchPartnerSchools({
    CancelToken? cancelToken,
  }) async {
    final response = await api.request<List>(HttpMethod.get, '/school',
        cancelToken: cancelToken);

    switch (response) {
      case ApiResponseData(:final data):
        return data
            .map((e) => PartnerSchool.fromJson(e))
            .toList()
            .cast<SchoolWithConfig>();
      default:
        throw response;
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
      default:
        throw response;
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

    return response.handle<User>(
      onData: (data) => User.fromJson(data),
    );
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

    return response.handle<AuthCredential>(
      onData: (data) {
        final accessToken = data['access_token'] as String;
        final refreshToken = data['refresh_token'] as String;

        return AuthCredential(
            accessToken: accessToken, refreshToken: refreshToken);
      },
      errorMapper: (code) {
        if (code == KnownErrorCode.INVALID_FEDERATED_GRANT) {
          return InvalidGrantException();
        }
        return null;
      },
    );
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

    return response.handle<AuthCredential>(
      onData: (data) {
        final accessToken = data['access_token'] as String;
        final refreshToken = data['refresh_token'] as String;

        return AuthCredential(
          accessToken: accessToken,
          refreshToken: refreshToken,
        );
      },
      errorMapper: (code) {
        switch (code) {
          case KnownErrorCode.INVALID_TOKEN:
          case KnownErrorCode.ACCESS_REVOKED:
          case KnownErrorCode.UNAUTHORIZED_DEVICE:
            return InvalidCredentialException();
          case KnownErrorCode.BANNED_USER:
            return BannedLoginException();
          default:
            return null;
        }
      },
    );
  }
}
