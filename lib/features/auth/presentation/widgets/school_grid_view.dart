import 'package:flutter/widgets.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
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
              return SchoolCard(
                school: school,
                isSelected: isSelected,
                onPressed: () {
                  selectedSchool.value = school;
                },
              );
            },
          ),
        ),
        FilledButton.darkLabel(
          onPressed: () {
            //    SchoolAccountHintRoute(schoolId: school.id).push(context);
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

class SchoolCard extends StatefulHookWidget {
  final PartnerSchool school;
  final bool isSelected;
  final VoidCallback onPressed;

  const SchoolCard(
      {super.key,
      required this.school,
      this.isSelected = false,
      required this.onPressed});

  @override
  State<SchoolCard> createState() => _SchoolCardState();
}

class _SchoolCardState extends State<SchoolCard> {
  @override
  Widget build(BuildContext context) {
    final theme = useTheme();

    return FilledButton.lightLabel(
      onPressed: widget.onPressed,
      label: widget.school.shortName,
      options: FilledButtonOptions(
        icon: Icons.school_outlined,
        backgroundColor:
            widget.isSelected ? theme.colors.primary : Colors.white,
        padding: EdgeInsets.all(theme.spaces.sm),
        textStyle: theme.text.common.titleMedium.copyWith(
          color: widget.isSelected
              ? theme.colors.darkButtonText
              : theme.colors.primary,
        ),
      ),
    );
  }
}
