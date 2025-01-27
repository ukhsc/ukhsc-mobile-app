import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart' show LinearProgressIndicator, Scaffold;
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:ukhsc_mobile_app/components/lib.dart';
import 'package:ukhsc_mobile_app/core/env.dart';
import 'package:ukhsc_mobile_app/core/style/lib.dart';
import 'package:ukhsc_mobile_app/features/lib.dart';
import 'package:ukhsc_mobile_app/gen/assets.gen.dart';
import 'package:url_launcher/url_launcher_string.dart';

class HomePage extends StatefulHookConsumerWidget {
  const HomePage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  @override
  Widget build(BuildContext context) {
    final theme = useTheme();
    final userState = ref.watch(userStateNotifierProvider);

    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: Stack(
              children: [
                Container(
                  constraints: BoxConstraints.expand(height: 250),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        theme.colors.primaryBackground,
                        theme.colors.screenBackground
                      ],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                  ),
                ),
                _buildMainContent(),
                if (userState.isLoading) LinearProgressIndicator(),
              ],
            ),
          ),
          AppSafeArea(
            top: false,
            child: NavigationBar(),
          ),
        ],
      ),
    );
  }

  Widget _buildMainContent() {
    final theme = useTheme();

    return ListView(
      // TODO: Remove when the app is ready for scrolling
      physics: const NeverScrollableScrollPhysics(),
      children: [
        AppBar(),
        SizedBox(height: theme.spaces.sm),
        AppSafeArea(
          bottom: false,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: theme.spaces.lg),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // TODO: Replace with user's nickname and greeting message
                    Text(
                      '晚安，同學',
                      style: theme.text.common.headlineMedium
                          .copyWith(color: theme.colors.accentText),
                    ),
                    Text('想來點什麼呢？',
                        style: theme.text.common.displaySmall
                            .copyWith(fontSize: 38)),
                  ],
                ),
              ],
            ),
          ),
        ),
        SizedBox(height: theme.spaces.sm),
        Stack(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: theme.spaces.md),
              child: Assets.images.tryHack.image(),
            ),
            Container(
              constraints: BoxConstraints.expand(height: 650),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.white60,
                    Colors.white.withValues(alpha: 0.85),
                    Colors.white,
                  ],
                  stops: [0.01, 0.15, 0.75],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
              child: SizedBox(height: 600, width: 600),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Column(
                children: [
                  SizedBox(height: 330),
                  Text(
                    '更多功能即將推出',
                    style: theme.text.common.displaySmall,
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    '追蹤官方帳號了解更新及優惠資訊',
                    style: theme.text.common.headlineMedium
                        .copyWith(color: theme.colors.primaryText),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: theme.spaces.lg),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    spacing: theme.spaces.md,
                    children: [
                      Assets.images.instagramProfile.image(width: 110),
                      Column(
                        spacing: theme.spaces.xs,
                        children: [
                          Text(
                            '@ukhsc_2025',
                            style: theme.text.common.headlineSmall.copyWith(
                              color: theme.colors.primaryText,
                            ),
                          ),
                          ComposableButton(
                            onPressed: () {
                              launchUrlString(AppEnvironment.socialMediaLink);
                            },
                            style: FilledStyle.dark(),
                            content: Text(
                              '追蹤',
                              style: theme.text.common.headlineSmall.copyWith(
                                color: theme.colors.onPrimary,
                              ),
                            ).asButtonContent.withPadding(EdgeInsets.symmetric(
                                horizontal: theme.spaces.sm,
                                vertical: theme.spaces.xs)),
                          ),
                        ],
                      ),
                    ],
                  )
                ],
              ),
            ),
          ],
        )
      ],
    );
  }
}
