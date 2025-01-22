import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart' show Divider, Scaffold;
import 'package:flutter/widgets.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:ukhsc_mobile_app/components/lib.dart';
import 'package:ukhsc_mobile_app/core/links.dart';
import 'package:ukhsc_mobile_app/core/style/lib.dart';
import 'package:ukhsc_mobile_app/features/auth/lib.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../models/school.dart';

class SchoolAccountHintPage extends HookWidget {
  final PartnerSchool school;

  const SchoolAccountHintPage({super.key, required this.school});

  @override
  Widget build(BuildContext context) {
    final theme = useTheme();

    return Scaffold(
      appBar: AppBar(),
      extendBodyBehindAppBar: true,
      body: Container(
        constraints: BoxConstraints.expand(),
        padding: EdgeInsets.all(theme.spaces.lg),
        color: theme.colors.lightGradient,
        child: SafeArea(
          child: Column(
            spacing: theme.spaces.lg,
            children: [
              _buildTitle(theme),
              Divider(),
              _buildAccountHint(theme),
              Divider(),
              _buildButton(theme),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTitle(AppTheme theme) {
    return Column(
      children: [
        Text('享受優惠前的', style: theme.text.common.headlineLarge),
        Text('最後一步', style: theme.text.common.displayMedium),
        SizedBox(height: theme.spaces.md),
        Text('為了確保您是本聯盟合作學校的學生，請您使用學校配發的 Google 帳號完成註冊手續，驗證完畢後即可提供您專屬的會員服務。',
            style: theme.text.common.bodyLarge)
      ],
    );
  }

  Widget _buildAccountHint(AppTheme theme) {
    return Column(
      spacing: theme.spaces.sm,
      children: [
        Text('帳號格式', style: theme.text.common.headlineLarge),
        Text('倘若您對於${school.shortName}的帳號格式不是很清楚，我們提供貴校的帳號格式及預設密碼作為參考。',
            style: theme.text.common.bodyLarge),
        Padding(
          padding: EdgeInsets.all(theme.spaces.md),
          child: Container(
            padding: EdgeInsets.all(theme.spaces.md),
            decoration: BoxDecoration(
              color: theme.colors.secondaryBackground,
              borderRadius: BorderRadius.all(theme.radii.small),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: theme.spaces.xxs,
              children: [
                Text('帳號格式：${school.googleAccountConfig.usernameFormat}',
                    style: theme.text.common.bodyLarge),
                Divider(color: theme.colors.tertiaryText, thickness: 0.5),
                Text('預設密碼：${school.googleAccountConfig.passwordFormat}',
                    style: theme.text.common.bodyLarge),
              ],
            ),
          ),
        ),
        RichText(
          text: TextSpan(
            style: theme.text.common.labelMedium
                .copyWith(color: theme.colors.primary),
            children: [
              TextSpan(text: '無法登入？'),
              TextSpan(
                text: '聯絡我們',
                style: TextStyle(
                  decoration: TextDecoration.underline,
                  fontVariations: AppFontWeight.bold.variations,
                ),
                recognizer: TapGestureRecognizer()
                  ..onTap = () {
                    launchUrlString(Links.instagram);
                  },
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildButton(AppTheme theme) {
    return FilledButton.darkLabel(
      onPressed: () {
        const googleOAuthClientId =
            String.fromEnvironment('GOOGLE_OAUTH_CLIENT_ID');
        if (googleOAuthClientId.isEmpty) {
          throw Exception('GOOGLE_OAUTH_CLIENT_ID is not set');
        }

        final uri = Uri.https('accounts.google.com', '/o/oauth2/v2/auth', {
          'client_id': googleOAuthClientId,
          'redirect_uri': 'https://web.ukhsc.org/auth/callback/google',
          'response_type': 'code',
          'scope': 'https://www.googleapis.com/auth/userinfo.email openid',
          'hd': school.googleAccountConfig.domainName,
        });
        launchUrl(uri);
      },
      label: '使用學校帳號登入',
      options: FilledButtonOptions(
        icon: FontAwesomeIcons.google,
        textStyle: theme.text.common.headlineMedium
            .copyWith(height: 1.2, color: theme.colors.darkButtonText),
        padding: EdgeInsets.symmetric(
            vertical: theme.spaces.lg, horizontal: theme.spaces.xl),
      ),
    );
  }
}