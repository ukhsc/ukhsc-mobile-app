import 'package:flutter/material.dart'
    show Scaffold, showDialog, showModalBottomSheet;
import 'package:flutter/widgets.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

import 'package:ukhsc_mobile_app/components/lib.dart';
import 'package:ukhsc_mobile_app/core/error/lib.dart';
import 'package:ukhsc_mobile_app/core/router.dart';
import 'package:ukhsc_mobile_app/core/style/lib.dart';
import 'package:ukhsc_mobile_app/gen/assets.gen.dart';

import 'technical_support_sheet.dart';

class PanicExceptionDisplay extends HookConsumerWidget {
  final FlutterErrorDetails? details;
  const PanicExceptionDisplay({super.key, this.details});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final notifier = ref.read(errorServiceProvider.notifier);
      notifier.handleError(
        AppErrorEvent(
          severity: ErrorSeverity.panic,
        ),
        originalError: details?.exception,
        stackTrace: details?.stack,
      );

      showDialog(
        context: context,
        barrierDismissible: false,
        useSafeArea: false,
        useRootNavigator: false,
        builder: (context) => HookBuilder(
          builder: (context) {
            return _buildContent();
          },
        ),
      );
    });

    return SizedBox.shrink();
  }

  Scaffold _buildContent() {
    final theme = useTheme();

    return Scaffold(
      body: Container(
        constraints: BoxConstraints.expand(),
        color: theme.colors.secondaryBackground,
        child: AppSafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: theme.spaces.xl),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Assets.images.ukhscFullBrand.svg(width: 150),
                SizedBox(height: theme.spaces.lg),
                Text('發生異常錯誤', style: theme.text.common.displaySmall),
                SizedBox(height: theme.spaces.md),
                Text(
                  '抱歉！高校特約系統發生了無法預期的錯誤，請您重新開啟應用程式再試一次。\n\n如果問題持續發生，請聯絡我們。',
                  style: theme.text.common.bodyLarge,
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: theme.spaces.lg),
                Padding(
                  padding: EdgeInsets.all(theme.spaces.md),
                  child: ComposableButton(
                    onPressed: () {
                      showModalBottomSheet(
                        context: navigatorKey.currentContext!,
                        builder: (context) => TechnicalSupportSheet(
                          eventId: Sentry.lastEventId,
                          technicalMessage: details?.exception.toString(),
                        ),
                      );
                    },
                    style: FilledStyle.dark(),
                    content: Text('請求技術支援').asButtonContent.withExpanded(),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
