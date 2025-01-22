import 'package:flutter/material.dart' show CircularProgressIndicator, Scaffold;
import 'package:flutter/widgets.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:ukhsc_mobile_app/components/lib.dart';
import 'package:ukhsc_mobile_app/core/style/lib.dart';

import '../data/auth_repository.dart';
import 'widgets/school_grid_view.dart';

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
        padding: EdgeInsets.symmetric(vertical: theme.spaces.sm),
        child: SafeArea(
          child: Column(
            children: [
              Text('請選擇您就讀的學校', style: theme.text.common.displaySmall),
              Expanded(
                child: switch (schools) {
                  AsyncData(:final value) => Padding(
                      padding: EdgeInsets.all(theme.spaces.md),
                      child: SchoolGridView(schools: value),
                    ),
                  // TODO: Add error handling
                  AsyncError(:final error) => Text('Error' + error.toString()),
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
