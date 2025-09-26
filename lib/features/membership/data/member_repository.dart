import 'dart:convert';

import 'package:dio/dio.dart';

import 'package:ukhsc_mobile_app/core/env.dart';
import 'package:ukhsc_mobile_app/core/logger.dart';
import 'package:ukhsc_mobile_app/core/services/demo_data_service.dart';
import 'package:ukhsc_mobile_app/core/services/storage_service.dart';
import 'package:ukhsc_mobile_app/features/lib.dart';

import 'member_data_source.dart';

abstract class MemberRepository {
  Future<StudentMember?> getCacheData();
  Future<StudentMember> updateCacheData(String accessToken,
      {CancelToken? cancelToken});

  Future<void> editMemberSettings(MemberSettings settings,
      {required String accessToken, CancelToken? cancelToken});
}

class MemberRepositoryImpl implements MemberRepository {
  final MemberDataSource dataSource;
  final StorageService storage;

  MemberRepositoryImpl({required this.dataSource, required this.storage});

  final _logger = AppLogger.getLogger('membership.repo');

  @override
  Future<StudentMember?> getCacheData() async {
    // Return demo member data for store reviewers
    if (AppEnvironment.isStoreReviewerMode) {
      _logger.info('Store reviewer mode detected, returning demo member data');
      final demoMember = DemoDataService.getDemoStudentMember();
      DemoDataService.validateReviewerData(demoMember, 'getCacheData');
      return demoMember;
    }

    await storage.migrateSchema();
    _logger.fine('Getting member data from cache...');

    final raw = await storage.read('member_cache');
    if (raw == null) return null;

    return StudentMember.fromJson(jsonDecode(raw));
  }

  @override
  Future<StudentMember> updateCacheData(String accessToken,
      {CancelToken? cancelToken}) async {
    // Return demo member data for store reviewers
    if (AppEnvironment.isStoreReviewerMode) {
      _logger.info('Store reviewer mode detected, returning demo member data');
      final demoMember = DemoDataService.getDemoStudentMember();
      DemoDataService.validateReviewerData(demoMember, 'updateCacheData');
      return demoMember;
    }

    await storage.migrateSchema();
    _logger.fine('Fetching member data...');

    final member = await dataSource.fetchMemberData(accessToken: accessToken);
    await storage.write(
        key: 'member_cache', value: jsonEncode(member.toJson()));
    _logger.fine('Member data saved');

    return member;
  }

  @override
  Future<void> editMemberSettings(MemberSettings settings,
      {required String accessToken, CancelToken? cancelToken}) async {
    _logger.fine('Editing member data...');

    await dataSource.editMemberSettings(settings,
        accessToken: accessToken, cancelToken: cancelToken);

    _logger.fine('Member data edited');
  }
}
