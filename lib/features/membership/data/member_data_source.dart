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
      case ApiResponseError():
        throw Exception('Failed to fetch member data');
    }
  }
}
