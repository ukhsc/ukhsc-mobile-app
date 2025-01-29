import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:ukhsc_mobile_app/core/style/space.dart';

import 'colors.dart';
import 'text.dart';
import 'radius.dart';

export 'text.dart' show AppFontWeight;
export 'package:flutter/material.dart' show Colors, Icons;

AppTheme useTheme() {
  final context = useContext();
  return Theme.of(context).extension<AppTheme>()!;
}

class AppTheme extends ThemeExtension<AppTheme> {
  final AppTextStyle text;
  final AppColors colors;
  final AppRadius radii;
  final AppSpace spaces;

  AppTheme({
    required this.text,
    required this.colors,
    required this.radii,
    required this.spaces,
  });

  @override
  ThemeExtension<AppTheme> copyWith({
    AppTextStyle? text,
    AppColors? colors,
    AppRadius? radii,
    AppSpace? spaces,
  }) {
    return AppTheme(
      text: text ?? this.text,
      colors: colors ?? this.colors,
      radii: radii ?? this.radii,
      spaces: spaces ?? this.spaces,
    );
  }

  @override
  ThemeExtension<AppTheme> lerp(
      covariant ThemeExtension<AppTheme>? other, double t) {
    if (other is! AppTheme) return this;

    return AppTheme(
      text: AppTextStyle.lerp(text, other.text, t),
      colors: AppColors.lerp(colors, other.colors, t),
      radii: AppRadius.lerp(radii, other.radii, t),
      spaces: spaces,
    );
  }

  factory AppTheme.light() {
    final colors = AppColors.light();

    return AppTheme(
      text: AppTextStyle.light(colors),
      colors: colors,
      radii: AppRadius.normal(),
      spaces: AppSpace.normal(),
    );
  }

  static ThemeData initial() {
    final theme = AppTheme.light();

    return ThemeData(
      typography: Typography.material2021(),
      bottomSheetTheme: BottomSheetThemeData(
        showDragHandle: true,
        dragHandleColor: theme.colors.secondaryText.withValues(alpha: 0.5),
        dragHandleSize: Size(34, 7),
        modalBarrierColor: theme.colors.modalBarrier,
        backgroundColor: Colors.transparent,
      ),
      progressIndicatorTheme: ProgressIndicatorThemeData(
        color: theme.colors.primary,
      ),
      scaffoldBackgroundColor: theme.colors.screenBackground,
      extensions: <ThemeExtension<AppTheme>>[theme],
      pageTransitionsTheme: const PageTransitionsTheme(
        builders: <TargetPlatform, PageTransitionsBuilder>{
          TargetPlatform.android: PredictiveBackPageTransitionsBuilder(),
          TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
        },
      ),
    );
  }
}
