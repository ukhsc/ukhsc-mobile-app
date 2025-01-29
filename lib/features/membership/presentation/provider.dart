import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:ukhsc_mobile_app/core/logger.dart';
import 'package:ukhsc_mobile_app/features/auth/lib.dart';

part 'provider.g.dart';

@riverpod
class MembershipController extends _$MembershipController {
  final _logger = AppLogger.getLogger('membership');

  @override
  FutureOr<({bool permission, StudentMember? member})> build() async {
    try {
      final permission = await _checkPermission();
      return (permission: permission, member: null);
    } catch (error, stackTrace) {
      _logger.warning('Failed to check permission', error, stackTrace);
      rethrow;
    }
  }

  Future<bool> _checkPermission() async {
    final userState = await ref.read(userStateNotifierProvider.future);
    final user = userState?.user;

    if (user == null) return false;
    if (!user.roles.contains(UserRole.studentMember)) return false;

    return true;
  }
}
