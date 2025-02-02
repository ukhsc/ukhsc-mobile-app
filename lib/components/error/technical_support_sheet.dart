import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

import 'package:ukhsc_mobile_app/components/lib.dart';
import 'package:ukhsc_mobile_app/core/env.dart';
import 'package:ukhsc_mobile_app/core/style/lib.dart';
import 'package:url_launcher/url_launcher_string.dart';

class TechnicalSupportSheet extends HookWidget {
  final SentryId? eventId;
  final String? technicalMessage;

  const TechnicalSupportSheet({super.key, this.eventId, this.technicalMessage});

  @override
  Widget build(BuildContext context) {
    final theme = useTheme();

    final traceId = Sentry.getSpan()?.context.traceId;

    return Container(
      constraints: BoxConstraints.expand(height: 400),
      padding: EdgeInsets.symmetric(horizontal: theme.spaces.xl),
      child: Column(
        spacing: theme.spaces.lg,
        children: [
          Text('技術支援管道', style: theme.text.common.headlineLarge),
          Column(
            spacing: theme.spaces.sm,
            children: [
              Text(
                '請將本畫面的資訊截圖後，透過下方管道之一傳給我們，以便為您解決問題，感謝。',
                style: theme.text.common.bodyLarge,
                textAlign: TextAlign.center,
              ),
              if (traceId != null)
                Text('Trace ID: $traceId',
                    style: theme.text.common.labelMedium),
              if (eventId != null && eventId != SentryId.empty())
                Text('Event ID: $eventId',
                    style: theme.text.common.labelMedium),
              if (technicalMessage != null)
                Text(
                  'Error: $technicalMessage',
                  style: theme.text.common.labelMedium,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 3,
                ),
            ],
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: theme.spaces.md),
            child: Column(
              spacing: theme.spaces.sm,
              children: [
                ComposableButton(
                  onPressed: () {
                    launchUrlString(AppEnvironment.technicalSupportGroupLink);
                  },
                  style: OutlinedStyle.normal(),
                  content: Text('Discord 社群').asButtonContent.withExpanded(),
                ),
                ComposableButton(
                  onPressed: () {
                    launchUrlString(AppEnvironment.socialMediaLink);
                  },
                  style: OutlinedStyle.normal(),
                  content:
                      Text('官方 Instagram 帳號').asButtonContent.withExpanded(),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
