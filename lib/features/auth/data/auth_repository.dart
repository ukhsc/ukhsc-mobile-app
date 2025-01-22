import 'package:dio/dio.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:ukhsc_mobile_app/core/api/lib.dart';

import '../models/school.dart';

part 'auth_repository.g.dart';

abstract class AuthRepository {
  Future<List<PartnerSchool>> getPartnerSchools({CancelToken? cancelToken});
}

class AuthRepositoryImpl implements AuthRepository {
  final ApiClient api;

  AuthRepositoryImpl({required this.api});

  @override
  Future<List<PartnerSchool>> getPartnerSchools({
    CancelToken? cancelToken,
  }) async {
    final response = await api.get<List>('/school', cancelToken: cancelToken);

    return response.data
        .map((e) => PartnerSchool.fromJson(e))
        .toList()
        .cast<PartnerSchool>();
  }
}

@riverpod
AuthRepository authRepository(Ref ref) {
  return AuthRepositoryImpl(api: ref.read(apiClientProvider));
}

@riverpod
Future<List<PartnerSchool>> partnerSchools(Ref ref) async {
  final repository = ref.read(authRepositoryProvider);
  final schools =
      await repository.getPartnerSchools(cancelToken: ref.cancelToken);
  schools.shuffle();

  return schools;
}
