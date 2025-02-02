import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:ukhsc_mobile_app/core/style/lib.dart';
import 'package:ukhsc_mobile_app/components/lib.dart';
import 'package:ukhsc_mobile_app/gen/assets.gen.dart';

import 'data_view.dart';
import 'barcode_block.dart';
import '../provider.dart';
import '../../model/student_member.dart';

class MembershipCardSheet extends HookConsumerWidget {
  const MembershipCardSheet({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = useTheme();
    final controller = ref.watch(membershipControllerProvider);
    final member = controller.value;

    return Container(
      constraints: BoxConstraints.expand(
          height: MediaQuery.of(context).size.height * 0.85),
      decoration: BoxDecoration(
        color: theme.colors.secondaryBackground,
        borderRadius: BorderRadius.only(
          topLeft: theme.radii.large,
          topRight: theme.radii.large,
        ),
      ),
      padding: EdgeInsets.symmetric(
          horizontal: theme.spaces.lg, vertical: theme.spaces.md),
      child: Column(
        spacing: theme.spaces.lg,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ComposableButton(
                onPressed: () {
                  context.pop();
                },
                style: PlainStyle(
                  foregroundColor: theme.colors.primary,
                  overlayColor: theme.colors.primary,
                ),
                content: Text('關閉').asButtonContent,
              ),
              if (member != null) _buildBadge()
            ],
          ),
          if (member != null)
            SingleChildScrollView(
              child: _buildContent(member),
            ),
          if (member == null)
            Flexible(
              child: Center(
                child: CircularProgressIndicator(),
              ),
            ),
        ],
      ),
    );
  }

  Column _buildContent(StudentMember member) {
    final theme = useTheme();

    return Column(
      spacing: theme.spaces.lg,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildBlock(_buildUserCard(member)),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(bottom: theme.spaces.xs)
                  .add(EdgeInsets.symmetric(horizontal: theme.spaces.sm)),
              child: Text('發票載具（手機條碼）', style: theme.text.common.titleSmall),
            ),
            _buildBlock(
                BarcodeBlock(barcode: member.settings?.eInvoiceBarcode)),
          ],
        ),
        MembershipDataView(member: member),
      ],
    );
  }

  Stack _buildUserCard(StudentMember member) {
    final theme = useTheme();

    return Stack(
      children: [
        Padding(
          padding: EdgeInsets.only(left: theme.spaces.sm),
          child: Row(
            spacing: theme.spaces.lg,
            children: [
              _buildDefaultAvatar(),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('${member.schoolAttended.shortName}#${member.userId}',
                      style: theme.text.common.bodyMedium.copyWith(
                          color: theme.colors.primary,
                          fontVariations: AppFontWeight.semiBold.variations)),
                  Text(member.settings?.nickname ?? '學生會員',
                      style: theme.text.common.displaySmall
                          .copyWith(color: theme.colors.accentText)),
                ],
              )
            ],
          ),
        ),
        _buildYearText()
      ],
    );
  }

  Container _buildBadge() {
    final theme = useTheme();
    final color = Colors.white;

    return Container(
      padding: EdgeInsets.symmetric(
          horizontal: theme.spaces.md, vertical: theme.spaces.sm),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xff75A692), Color(0xff7FC8AB)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.all(theme.radii.small),
      ),
      child: Row(
        spacing: theme.spaces.xxs,
        children: [
          Icon(
            Icons.check_circle_outline,
            size: 16,
            color: color,
          ),
          Text(
            '帳號生效中',
            style: theme.text.common.bodySmall.copyWith(
              fontVariations: AppFontWeight.bold.variations,
              color: color,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildYearText() {
    final theme = useTheme();
    final style = theme.text.membershipCardYear;

    return Align(
      alignment: Alignment.centerRight,
      child: RotatedBox(
        quarterTurns: -1,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('UKHSC', style: style.copyWith(height: 0.8)),
            Text('2025', style: style.copyWith(letterSpacing: 3)),
          ],
        ),
      ),
    );
  }

  Widget _buildBlock(Widget child) {
    final theme = useTheme();

    return Container(
      padding: EdgeInsets.symmetric(
          vertical: theme.spaces.lg, horizontal: theme.spaces.md),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.white,
            theme.colors.lightGradient,
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.15),
            offset: Offset(0, 3),
            blurRadius: 7,
          ),
        ],
        borderRadius: BorderRadius.all(theme.radii.small),
      ),
      child: child,
    );
  }

  Widget _buildDefaultAvatar() {
    final theme = useTheme();

    return Container(
      width: 70,
      height: 70,
      decoration: BoxDecoration(
        color: theme.colors.tintGradient,
        borderRadius: BorderRadius.all(theme.radii.extraLarge),
        image: DecorationImage(
          image: AssetImage(Assets.images.onboardingHamburgerMascot.path),
          fit: BoxFit.none,
          scale: 4.8,
          alignment: Alignment.bottomCenter,
        ),
      ),
    );
  }
}
