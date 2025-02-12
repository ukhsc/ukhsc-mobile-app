import 'package:dio/dio.dart';

import 'package:ukhsc_mobile_app/core/api/lib.dart';

import '../model/student_member.dart';

class MemberDataSource {
  final ApiClient api;
  MemberDataSource({required this.api});

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
      default:
        throw response;
    }
  }

  Future<void> editMemberSettings(MemberSettings settings,
      {required String accessToken, CancelToken? cancelToken}) async {
    final response = await api.request(
      HttpMethod.put,
      '/member/me/settings',
      token: accessToken,
      data: settings.toJson(),
      cancelToken: cancelToken,
    );

    return response.handle<void>(
      onData: (data) {},
      errorMapper: (code) => null,
    );
  }
}
