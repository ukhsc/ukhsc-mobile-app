import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:ukhsc_mobile_app/core/api/lib.dart';
import 'package:ukhsc_mobile_app/core/logger.dart';
import 'package:ukhsc_mobile_app/core/services/network_state_service.dart';
import 'package:ukhsc_mobile_app/core/storage_service.dart';
import 'package:ukhsc_mobile_app/features/auth/lib.dart';

import '../model/student_member.dart';
import '../data/member_data_source.dart';
import '../data/member_repository.dart';

part 'provider.g.dart';

@riverpod
MemberRepository memberRepository(Ref ref) {
  return MemberRepositoryImpl(
    dataSource: MemberDataSource(api: ref.read(apiClientProvider)),
    storage: StorageService(),
  );
}

@riverpod
class MembershipController extends _$MembershipController {
  final _logger = AppLogger.getLogger('membership.controller');

  @override
  FutureOr<StudentMember?> build() async {
    final repo = ref.read(memberRepositoryProvider);
    final hasNetwork = await ref.read(networkConnectivityProvider.future);
    final authCredential =
        await ref.read(authRepositoryProvider).getCredential();

    if (hasNetwork && authCredential != null) {
      final member = await repo.updateCacheData(authCredential.accessToken);

      return member;
    }

    _logger.warning(
        'No network or no auth credential, skipping update and using cache');
    return repo.getCacheData();
  }
}
