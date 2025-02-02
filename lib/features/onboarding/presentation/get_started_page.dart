import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart'
    show Colors, Scaffold, showModalBottomSheet;
import 'package:flutter/widgets.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:url_launcher/url_launcher_string.dart';

import 'package:ukhsc_mobile_app/components/lib.dart';
import 'package:ukhsc_mobile_app/core/env.dart';
import 'package:ukhsc_mobile_app/core/style/lib.dart';
import 'package:ukhsc_mobile_app/features/auth/lib.dart';

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
      appBar: AppBar(),
      extendBodyBehindAppBar: true,
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
              child: HamburgerMascot(),
            ),
            AppSafeArea(
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
            alignment: Alignment(-0.6, -0.15),
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
            )),
        Align(
          alignment: Alignment.bottomCenter,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            spacing: theme.spaces.md,
            children: [
              ComposableButton(
                onPressed: () {
                  showModalBottomSheet(
                    context: context,
                    builder: (context) => const LoginOptionsSheets(),
                  );
                },
                style: FilledStyle.light(),
                content: Text('開始使用').asButtonContent.withPadding(
                      EdgeInsets.symmetric(
                        horizontal:
                            MediaQuery.of(context).size.width / 2 * 0.55,
                        vertical: theme.spaces.md,
                      ),
                    ),
              ),
              RichText(
                text: TextSpan(
                    text: '點擊「開始使用」，即代表您同意我們的',
                    style: hintTextStyle,
                    children: [
                      TextSpan(
                        text: '服務條款',
                        style: linkTextStyle,
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            launchUrlString(AppEnvironment.termsOfServiceLink);
                          },
                      ),
                      TextSpan(
                        text: '和',
                      ),
                      TextSpan(
                        text: '隱私政策',
                        style: linkTextStyle,
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            launchUrlString(AppEnvironment.privacyPolicyLink);
                          },
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
