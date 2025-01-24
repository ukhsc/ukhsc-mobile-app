import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart' show LinearProgressIndicator, Scaffold;
import 'package:flutter/widgets.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:ukhsc_mobile_app/components/lib.dart';
import 'package:ukhsc_mobile_app/core/style/lib.dart';
import 'package:ukhsc_mobile_app/features/auth/data/auth_repository.dart';

class MemberCreationPage extends StatefulHookConsumerWidget {
  final int schoolId;
  final String authorizationCode;
  final String redirectUri;

  const MemberCreationPage(
      {super.key,
      required this.schoolId,
      required this.authorizationCode,
      required this.redirectUri});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _MemberCreationPageState();
}

class _MemberCreationPageState extends ConsumerState<MemberCreationPage> {
  @override
  Widget build(BuildContext context) {
    final theme = useTheme();

    final registerState = ref.watch(
      registerMemberProvider(
        schoolAttendanceId: widget.schoolId,
        authorizationCode: widget.authorizationCode,
        redirectUri: widget.redirectUri,
      ),
    );

    registerState.whenData((data) async {
      await Future.delayed(Duration(milliseconds: 500));

      // TODO: navigate to home
      print('finished');
    });

    if (registerState.hasError) {
      print(registerState.error);
      print(registerState.stackTrace);

      return Text('Error');
      throw UnimplementedError();
    }

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
            if (registerState.isLoading)
              Align(
                alignment: Alignment.topCenter,
                child: LinearProgressIndicator(
                  color: theme.colors.primary,
                  minHeight: 4,
                ),
              ),
            Align(
              alignment: Alignment.bottomCenter,
              child: HamburgerMascot(),
            ),
            Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    '歡迎您的加入',
                    style: theme.text.common.displayMedium,
                  ),
                  Text(
                    '請稍待片刻',
                    style: theme.text.common.displaySmall.copyWith(
                      color: theme.colors.accentText,
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
