import 'package:flutter/material.dart' show Divider;
import 'package:flutter/widgets.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:ukhsc_mobile_app/components/lib.dart';
import 'package:ukhsc_mobile_app/core/style/lib.dart';

class LoginOptionsSheets extends StatefulHookConsumerWidget {
  const LoginOptionsSheets({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _LoginOptionsSheetsState();
}

class _LoginOptionsSheetsState extends ConsumerState<LoginOptionsSheets> {
  @override
  Widget build(BuildContext context) {
    final theme = useTheme();

    return Container(
      constraints: BoxConstraints.expand(height: 350),
      padding: EdgeInsets.symmetric(horizontal: theme.spaces.xl),
      child: Column(
        spacing: theme.spaces.lg,
        children: [
          Text('高校特約會員登入', style: theme.text.common.headlineLarge),
          ComposableButton(
            onPressed: () {},
            style: FilledStyle.dark(),
            content: Text('註冊帳號').asButtonContent.withPadding(
                  EdgeInsets.symmetric(
                      horizontal: 105, vertical: theme.spaces.sm),
                ),
          ),
          Row(
            spacing: theme.spaces.sm,
            children: [
              Expanded(child: Divider()),
              Text('我已有會員帳號', style: theme.text.common.labelLarge),
              Expanded(child: Divider()),
            ],
          ),
          Text(
            '*會員帳號僅限本屆參與合作學校之在學學生使用',
            style: theme.text.common.labelLarge,
          ),
        ],
      ),
    );
  }
}
