import 'package:flutter/widgets.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';

import 'package:ukhsc_mobile_app/core/style/lib.dart';
import 'package:ukhsc_mobile_app/components/lib.dart';

class MembershipCardSheet extends HookWidget {
  const MembershipCardSheet({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = useTheme();

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
                style: PlainStyle(foregroundColor: theme.colors.primary),
                content: Text('完成').asButtonContent,
              ),
              Container(
                padding: EdgeInsets.all(theme.spaces.sm),
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
                    ),
                    Text('帳號生效中', style: theme.text.common.bodyMedium),
                  ],
                ),
              )
            ],
          ),
          SingleChildScrollView(
            child: Column(
              spacing: theme.spaces.md,
              children: [
                _buildBlock(
                  Stack(
                    children: [
                      Row(
                        children: [],
                      ),
                      _buildYearText()
                    ],
                  ),
                ),
                Column(
                  children: [
                    Text('行動載具'),
                    _buildBlock(
                      Row(children: []),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Align _buildYearText() {
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
}
