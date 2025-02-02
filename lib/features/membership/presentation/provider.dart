import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:ukhsc_mobile_app/components/lib.dart';

import 'package:ukhsc_mobile_app/core/api/lib.dart';
import 'package:ukhsc_mobile_app/core/logger.dart';
import 'package:ukhsc_mobile_app/core/services/network_state_service.dart';
import 'package:ukhsc_mobile_app/core/services/storage_service.dart';
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
      final member = await repo.updateCacheData(authCredential.accessToken,
          cancelToken: ref.cancelToken);

      return member;
    }

    _logger.warning(
        'No network or no auth credential, skipping update and using cache');
    return repo.getCacheData();
  }

  Future<void> editSettings(MemberSettings settings) async {
    state = AsyncValue.loading();

    state = await AsyncValue.guard(() async {
      final repo = ref.read(memberRepositoryProvider);
      final authCredential =
          await ref.read(authRepositoryProvider).getCredential();

      if (authCredential != null) {
        await repo.editMemberSettings(
          settings,
          accessToken: authCredential.accessToken,
          cancelToken: ref.cancelToken,
        );
        ref.invalidateSelf();
        return;
      }

      OverlayMessage.show('因未知原因，無法更新發票共通性載具資訊，請稍後再試');
    });
  }
}
