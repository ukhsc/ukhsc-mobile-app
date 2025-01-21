import 'dart:ui';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart'
    show Colors, Scaffold, showModalBottomSheet;
import 'package:flutter/widgets.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:ukhsc_mobile_app/components/lib.dart';
import 'package:ukhsc_mobile_app/core/style/lib.dart';
import 'package:ukhsc_mobile_app/features/login/lib.dart';
import 'package:ukhsc_mobile_app/gen/assets.gen.dart';

class GetStartedPage extends StatefulHookConsumerWidget {
  const GetStartedPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _GetStartedPageState();
}

class _GetStartedPageState extends ConsumerState<GetStartedPage> {
  @override
  Widget build(BuildContext context) {
    final theme = useTheme();

    return Scaffold(
      body: Container(
        constraints: BoxConstraints.expand(),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [theme.colors.tintGradient, Colors.white],
            begin: Alignment(-0.14, 1),
            end: Alignment(0.14, -1),
            stops: [0.47, 1.0],
          ),
        ),
        child: Stack(
          children: [
            Align(
              alignment: Alignment.bottomCenter,
              child: _HamburgerMascot(),
            ),
            SafeArea(
              child: Padding(
                padding: EdgeInsets.all(theme.spaces.md),
                child: _buildSafeArea(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSafeArea() {
    final theme = useTheme();
    final hintTextStyle = theme.text.common.labelMedium
        .copyWith(color: theme.colors.primary, fontSize: 12.5);
    final linkTextStyle = hintTextStyle.copyWith(
      decoration: TextDecoration.underline,
      fontVariations: AppFontWeight.bold.variations,
    );

    return Stack(
      children: [
        Align(
          alignment: Alignment.topLeft,
          child: Padding(
            padding: EdgeInsets.only(left: theme.spaces.xl),
            child: AppTitle(),
          ),
        ),
        Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: EdgeInsets.only(
                  left: theme.spaces.xxl, bottom: theme.spaces.xxl),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '開啟',
                    style: theme.text.common.displayLarge,
                  ),
                  Text(
                    '新篇章',
                    style: theme.text.common.displayLarge.copyWith(
                      color: theme.colors.accentText,
                    ),
                  ),
                ],
              ),
            )),
        Align(
          alignment: Alignment.bottomCenter,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            spacing: theme.spaces.md,
            children: [
              FilledButton.lightLabel(
                onPressed: () {
                  showModalBottomSheet(
                    context: context,
                    builder: (context) => const LoginOptionsSheets(),
                  );
                },
                label: '開始使用',
                backgroundColor: Colors.white,
                padding: EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.width / 2 * 0.55,
                  vertical: theme.spaces.md,
                ),
              ),
              // TODO: Add a link to the terms of service and privacy policy.
              RichText(
                text: TextSpan(
                    text: '點擊「開始使用」，即表示您同意我們的',
                    style: hintTextStyle,
                    children: [
                      TextSpan(
                        text: '服務條款',
                        style: linkTextStyle,
                        recognizer: TapGestureRecognizer()..onTap = () {},
                      ),
                      TextSpan(
                        text: '和',
                      ),
                      TextSpan(
                        text: '隱私政策',
                        style: linkTextStyle,
                        recognizer: TapGestureRecognizer()..onTap = () {},
                      ),
                    ]),
              ),
            ],
          ),
        )
      ],
    );
  }
}

class _HamburgerMascot extends HookWidget {
  const _HamburgerMascot();

  @override
  Widget build(BuildContext context) {
    final theme = useTheme();

    return ImageFiltered(
      imageFilter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
      child: Assets.images.onboardingHamburgerMascot.image(
        frameBuilder: (context, child, frame, wasSynchronouslyLoaded) {
          return Stack(
            alignment: Alignment.bottomCenter,
            children: [
              child,
              ColoredBox(
                color: theme.colors.tintGradient.withValues(alpha: 0.7),
                child: SizedBox(
                  height: 250,
                  width: double.infinity,
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
