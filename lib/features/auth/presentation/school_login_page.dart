import 'package:flutter/material.dart' show CircularProgressIndicator, Scaffold;
import 'package:flutter/widgets.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:ukhsc_mobile_app/components/lib.dart';
import 'package:ukhsc_mobile_app/core/error/lib.dart';
import 'package:ukhsc_mobile_app/core/style/lib.dart';

import 'widgets/school_grid_view.dart';
import 'provider.dart';

class SchoolLoginPage extends StatefulHookConsumerWidget {
  const SchoolLoginPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _SchoolLoginPageState();
}

class _SchoolLoginPageState extends ConsumerState<SchoolLoginPage> {
  @override
  Widget build(BuildContext context) {
    final theme = useTheme();
    final schools = ref.watch(partnerSchoolsProvider);

    return Scaffold(
      appBar: AppBar(),
      extendBodyBehindAppBar: true,
      body: Container(
        constraints: BoxConstraints.expand(),
        color: theme.colors.secondaryBackground,
        padding: EdgeInsets.only(top: theme.spaces.sm),
        child: AppSafeArea(
          child: Column(
            children: [
              Text('請選擇您就讀的學校', style: theme.text.common.displaySmall),
              Expanded(
                child: switch (schools) {
                  AsyncData(:final value) => Padding(
                      padding: EdgeInsets.all(theme.spaces.lg),
                      child: SchoolGridView(schools: value),
                    ),
                  AsyncError err => Builder(builder: (context) {
                      err.handleError(ref);
                      return Center(
                          child: Column(
                        mainAxisSize: MainAxisSize.min,
                        spacing: theme.spaces.sm,
                        children: [
                          Text(
                            '無法取得合作學校清單，請稍候再試。',
                            style: theme.text.common.bodyLarge,
                          ),
                          ComposableButton(
                            onPressed: () =>
                                ref.refresh(partnerSchoolsProvider),
                            style: FilledStyle.light(),
                            content: Text('重新載入').asButtonContent,
                          ),
                        ],
                      ));
                    }),
                  _ => Center(child: CircularProgressIndicator()),
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
