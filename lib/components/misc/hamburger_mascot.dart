import 'dart:ui';

import 'package:flutter/widgets.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import 'package:ukhsc_mobile_app/core/style/lib.dart';
import 'package:ukhsc_mobile_app/gen/assets.gen.dart';

class HamburgerMascot extends HookWidget {
  const HamburgerMascot({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = useTheme();

    return ImageFiltered(
      imageFilter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
      child: Assets.images.onboardingHamburgerMascot.image(
        frameBuilder: (context, child, frame, wasSynchronouslyLoaded) {
          return Stack(
            alignment: Alignment.bottomCenter,
            children: [
              child,
              ColoredBox(
                color: theme.colors.tintGradient.withValues(alpha: 0.7),
                child: SizedBox(
                  height: 250,
                  width: double.infinity,
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
