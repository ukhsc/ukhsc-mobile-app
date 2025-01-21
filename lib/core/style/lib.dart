import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:ukhsc_mobile_app/core/style/space.dart';

import 'colors.dart';
import 'text.dart';
import 'radius.dart';

export 'text.dart' show AppFontWeight;

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
}
