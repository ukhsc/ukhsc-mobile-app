import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:ukhsc_mobile_app/core/style/lib.dart';
import 'package:ukhsc_mobile_app/features/onboarding/widgets/history_case.dart';

class HistoryRetrospectPage extends StatefulHookConsumerWidget {
  const HistoryRetrospectPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _HistoryRetrospectPageState();
}

class _HistoryRetrospectPageState extends ConsumerState<HistoryRetrospectPage> {
  @override
  Widget build(BuildContext context) {
    final theme = useTheme();

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
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: EdgeInsets.all(theme.spaces.xs),
                  child: Placeholder(
                    child: SizedBox(
                      width: 300,
                      height: 50,
                    ),
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
