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
          child: Column(
            children: [
              GridView.builder(
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
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: theme.spaces.sm,
                  vertical: theme.spaces.md,
                ),
                child: Text(
                  '找不到您的學校嗎？歡迎您推薦貴校學生自治組織（學聯會、學生會、班聯會）加入聯盟！',
                  style: theme.text.common.bodyLarge,
                ),
              )
            ],
          ),
        ),
        FilledButton.darkLabel(
          onPressed: () {
            final school = selectedSchool.value;
            if (school != null) {
              SchoolAccountHintRoute($extra: school).push(context);
            }
          },
          options: FilledButtonOptions(
              padding: EdgeInsets.symmetric(
                  horizontal: 100, vertical: theme.spaces.sm)),
          label: '繼續',
        ),
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
    final theme = useTheme();

    return FilledButton.lightLabel(
      onPressed: onPressed,
      label: school.shortName,
      options: FilledButtonOptions(
        icon: Icons.school_outlined,
        backgroundColor: isSelected ? theme.colors.primary : Colors.white,
        padding: EdgeInsets.all(theme.spaces.sm),
        textStyle: theme.text.common.titleMedium.copyWith(
          color:
              isSelected ? theme.colors.darkButtonText : theme.colors.primary,
        ),
      ),
    );
  }
}
