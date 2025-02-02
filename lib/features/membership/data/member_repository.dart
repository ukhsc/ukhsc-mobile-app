import 'dart:convert';

import 'package:ukhsc_mobile_app/core/logger.dart';
import 'package:ukhsc_mobile_app/core/services/storage_service.dart';
import 'package:ukhsc_mobile_app/features/lib.dart';

import 'member_data_source.dart';

abstract class MemberRepository {
  Future<StudentMember?> getCacheData();
  Future<StudentMember> updateCacheData(String accessToken);
}

class MemberRepositoryImpl implements MemberRepository {
  final MemberDataSource dataSource;
  final StorageService storage;

  MemberRepositoryImpl({required this.dataSource, required this.storage});

  final _logger = AppLogger.getLogger('membership.repo');

  @override
  Future<StudentMember?> getCacheData() async {
    await storage.migrateSchema();
    _logger.fine('Getting member data from cache...');

    final raw = await storage.read('member_cache');
    if (raw == null) return null;

    return StudentMember.fromJson(jsonDecode(raw));
  }

  @override
  Future<StudentMember> updateCacheData(String accessToken) async {
    await storage.migrateSchema();
    _logger.fine('Fetching member data...');

    final member = await dataSource.fetchMemberData(accessToken: accessToken);
    await storage.write(
        key: 'member_cache', value: jsonEncode(member.toJson()));
    _logger.fine('Member data saved');

    return member;
  }
}
