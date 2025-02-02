import 'package:flutter/material.dart' show InkWell, showModalBottomSheet;
import 'package:flutter/widgets.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:ukhsc_mobile_app/core/style/lib.dart';
import 'package:ukhsc_mobile_app/features/auth/lib.dart';

import 'card_sheet.dart';

class MembershipCardButton extends HookConsumerWidget {
  const MembershipCardButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = useTheme();
    final autoOpened = useState(false);

    final state = ref.watch(userStateNotifierProvider);
    final enabled =
        state.valueOrNull?.roles.contains(UserRole.studentMember) ?? false;

    if (enabled && !autoOpened.value) {
      // TODO: In the 1.0 release, we will disable auto-open the card sheet.
      WidgetsBinding.instance.addPostFrameCallback((_) {
        autoOpened.value = true;
        openCardSheet(context);
      });
    }

    return Column(
      spacing: theme.spaces.xs,
      children: [
        _wrapAnimation(
          InkWell(
            onTap: () {
              if (!enabled) return;
              openCardSheet(context);
            },
            borderRadius: BorderRadius.all(theme.radii.extraLarge),
            child: _buildIcon(enabled),
          ),
        ),
        Text(
          '數位會員卡',
          style: theme.text.common.bodyMedium.copyWith(
            color: theme.colors.iconColor,
          ),
        ),
      ],
    );
  }

  Widget _wrapAnimation(Widget child) {
    return HookBuilder(builder: (context) {
      final isPressed = useState(false);

      return GestureDetector(
        onTapDown: (_) => isPressed.value = true,
        onTapUp: (_) => isPressed.value = false,
        onTapCancel: () => isPressed.value = false,
        child: AnimatedScale(
          scale: isPressed.value ? 0.95 : 1.0,
          duration: const Duration(milliseconds: 100),
          child: child,
        ),
      );
    });
  }

  Widget _buildIcon(bool enabled) {
    final theme = useTheme();

    return Container(
      padding: EdgeInsets.all(theme.spaces.md),
      decoration: BoxDecoration(
        color: theme.colors.primary,
        borderRadius: BorderRadius.all(theme.radii.extraLarge),
        boxShadow: [
          BoxShadow(
            color: theme.colors.primary.withValues(alpha: 0.2),
            blurRadius: 8,
            offset: Offset(0, 4),
            spreadRadius: 2,
          ),
        ],
      ),
      child: Icon(
        Icons.credit_card_rounded,
        size: theme.spaces.xl,
        color:
            enabled ? theme.colors.primaryBackground : theme.colors.iconColor,
      ),
    );
  }

  Future<void> openCardSheet(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      showDragHandle: false,
      builder: (context) => MembershipCardSheet(),
    );
  }
}
