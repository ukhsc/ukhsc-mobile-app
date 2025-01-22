import 'package:flutter/material.dart' show VerticalDivider;
import 'package:flutter/widgets.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import 'package:ukhsc_mobile_app/core/style/lib.dart';
import 'package:ukhsc_mobile_app/gen/assets.gen.dart';

class AppTitle extends HookWidget {
  const AppTitle({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = useTheme();

    return SizedBox(
      height: 20,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Assets.images.ukhscFullBrand.svg(
            alignment: Alignment.topLeft,
            width: 60,
            colorFilter: ColorFilter.mode(
              theme.colors.primary,
              BlendMode.srcIn,
            ),
          ),
          VerticalDivider(color: theme.colors.tertiaryText),
          Text('高校特約',
              style: theme.text.common.titleSmall.copyWith(height: -0.1)),
        ],
      ),
    );
  }
}
