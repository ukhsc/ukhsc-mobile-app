import 'package:flutter/material.dart'
    show Dialog, Divider, showModalBottomSheet;
import 'package:flutter/widgets.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import 'package:ukhsc_mobile_app/core/style/lib.dart';
import 'package:ukhsc_mobile_app/core/error/lib.dart';

import 'technical_support_sheet.dart';
import '../button/lib.dart';

class ErrorDialog extends HookWidget {
  final AppErrorEvent event;
  const ErrorDialog({super.key, required this.event});

  @override
  Widget build(BuildContext context) {
    final theme = useTheme();

    return Dialog(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(theme.radii.small),
      ),
      child: Padding(
        padding: EdgeInsets.all(theme.spaces.xl),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          spacing: theme.spaces.xl,
          children: [
            Text('系統通知', style: theme.text.common.headlineLarge),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: theme.spaces.xs),
              child: Column(
                spacing: theme.spaces.md,
                children: [
                  Text(
                    event.message ?? '發生異常錯誤，請再試一次。',
                    style: theme.text.common.bodyLarge,
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            Column(
              spacing: theme.spaces.xs,
              children: [
                ComposableButton(
                  onPressed: event.action,
                  style: FilledStyle.dark(),
                  content: Text(event.actionLabel ?? '確認')
                      .asButtonContent
                      .withExpanded(),
                ),
                Row(
                  spacing: theme.spaces.xs,
                  children: [
                    Expanded(child: Divider()),
                    Text('還是無法正常運作嗎？', style: theme.text.common.labelMedium),
                    Expanded(child: Divider()),
                  ],
                ),
                ComposableButton(
                  onPressed: () {
                    showModalBottomSheet(
                      context: context,
                      builder: (context) =>
                          TechnicalSupportSheet(eventId: event.sentryEventId),
                    );
                  },
                  style: OutlinedStyle.normal(),
                  content: Text('請求技術支援').asButtonContent.withExpanded(),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
