import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart' show Scaffold;
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ukhsc_mobile_app/components/lib.dart';

import 'package:ukhsc_mobile_app/core/style/lib.dart';

import 'widgets/history_case.dart';

class HistoryRetrospectPage extends StatefulHookConsumerWidget {
  final VoidCallback onFinished;
  const HistoryRetrospectPage({super.key, required this.onFinished});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _HistoryRetrospectPageState();
}

class _HistoryRetrospectPageState extends ConsumerState<HistoryRetrospectPage> {
  @override
  Widget build(BuildContext context) {
    final theme = useTheme();

    final buttonColor = theme.colors.primary.withValues(alpha: 0.45);

    return Scaffold(
      body: Container(
        constraints: BoxConstraints.expand(),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [theme.colors.primaryBackground, theme.colors.darkGradient],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: Stack(
            children: [
              Center(
                child: HistoryCasesViewer(
                  cases: [
                    HistoryCase(
                      title: '高雄高校特約聯盟誕生了',
                      year: 2019,
                    ),
                    HistoryCase(
                      title: '數十校、數百間店家',
                      year: 2021,
                    ),
                    HistoryCase(
                      title: '與我們一起走過六年',
                      year: 2024,
                    ),
                    HistoryCase(
                      title: '現在，輪到您\n與我們一起開啟新篇章',
                      year: 2025,
                    ),
                  ],
                  onFinished: widget.onFinished,
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: EdgeInsets.all(theme.spaces.xs),
                  child: TextButton.icon(
                    onPressed: () {
                      widget.onFinished();
                    },
                    alignment: IconAlignment.right,
                    icon: FontAwesomeIcons.arrowRight,
                    color: buttonColor,
                    label: '跳過介紹',
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
