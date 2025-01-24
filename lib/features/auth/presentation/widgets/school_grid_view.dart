import 'package:flutter/material.dart'
    show ScaffoldMessenger, SnackBar, SnackBarBehavior;
import 'package:flutter/widgets.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:ukhsc_mobile_app/components/lib.dart';
import 'package:ukhsc_mobile_app/core/style/lib.dart';
import 'package:ukhsc_mobile_app/features/auth/lib.dart';

class SchoolGridView extends StatefulHookConsumerWidget {
  final List<PartnerSchool> schools;

  const SchoolGridView({super.key, required this.schools});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SchoolGridViewState();
}

class _SchoolGridViewState extends ConsumerState<SchoolGridView> {
  @override
  Widget build(BuildContext context) {
    final theme = useTheme();
    final selectedSchool = useState<PartnerSchool?>(null);

    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Expanded(
          child: GridView.builder(
            shrinkWrap: true,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: theme.spaces.sm,
              mainAxisSpacing: theme.spaces.md,
              childAspectRatio: 2.8,
            ),
            itemCount: widget.schools.length,
            itemBuilder: (context, index) {
              final school = widget.schools[index];
              final isSelected = selectedSchool.value == school;
              return SchoolItem(
                school: school,
                isSelected: isSelected,
                onPressed: () {
                  selectedSchool.value = school;
                },
              );
            },
          ),
        ),
        Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: theme.spaces.sm,
                vertical: theme.spaces.md,
              ),
              child: Text(
                '找不到您的學校嗎？歡迎您推薦貴校學生自治組織（學聯會、學生會、班聯會）加入聯盟！',
                style: theme.text.common.bodyLarge,
              ),
            ),
            ComposableButton(
              onPressed: () {
                final school = selectedSchool.value;
                if (school == null) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      behavior: SnackBarBehavior.floating,
                      content: Text('請先選擇您就讀的學校'),
                    ),
                  );
                  return;
                }

                SchoolAccountHintRoute($extra: school).push(context);
              },
              style: FilledStyle.dark(),
              content: ButtonContent(Text('繼續')).withPadding(
                EdgeInsets.symmetric(
                  horizontal: 100,
                  vertical: theme.spaces.sm,
                ),
              ),
            ),
          ],
        )
      ],
    );
  }
}

class SchoolItem extends HookWidget {
  final PartnerSchool school;
  final bool isSelected;
  final VoidCallback onPressed;

  const SchoolItem(
      {super.key,
      required this.school,
      this.isSelected = false,
      required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ComposableButton(
      onPressed: onPressed,
      style: isSelected ? FilledStyle.dark() : FilledStyle.light(),
      content: Text(school.shortName)
          .asButtonContent
          .withIcon(Icons.school_outlined),
    );
  }
}
