import 'package:flutter/material.dart';
import 'package:ukhsc_mobile_app/gen/fonts.gen.dart';

import 'colors.dart';
import 'text.dart' show AppFontWeight;

class CommonTextStyle {
  final TextStyle displayLarge;
  final TextStyle displayMedium;
  final TextStyle displaySmall;

  final TextStyle headlineLarge;
  final TextStyle headlineMedium;
  final TextStyle headlineSmall;

  final TextStyle titleLarge;
  final TextStyle titleMedium;
  final TextStyle titleSmall;

  final TextStyle bodyLarge;
  final TextStyle bodyMedium;
  final TextStyle bodySmall;

  final TextStyle labelLarge;
  final TextStyle labelMedium;
  final TextStyle labelSmall;

  CommonTextStyle({
    required this.displayLarge,
    required this.displayMedium,
    required this.displaySmall,
    required this.headlineLarge,
    required this.headlineMedium,
    required this.headlineSmall,
    required this.titleLarge,
    required this.titleMedium,
    required this.titleSmall,
    required this.bodyLarge,
    required this.bodyMedium,
    required this.bodySmall,
    required this.labelLarge,
    required this.labelMedium,
    required this.labelSmall,
  });

  factory CommonTextStyle.normal(AppColors colors) {
    final initial = TextStyle(
      fontFamily: FontFamily.notoSansTC,
      decorationColor: colors.primary,
    );

    final display = initial.copyWith(
      color: colors.primary,
      fontVariations: AppFontWeight.bold.variations,
    );
    final headline = initial.copyWith(
      color: colors.primary,
      fontVariations: AppFontWeight.bold.variations,
    );
    final title = initial.copyWith(
      color: colors.primary,
      fontVariations: AppFontWeight.semiBold.variations,
    );
    final body = initial.copyWith(
      color: colors.primaryText,
      fontVariations: AppFontWeight.medium.variations,
    );
    final label = initial.copyWith(
      color: colors.secondaryText,
      fontVariations: AppFontWeight.medium.variations,
    );

    return CommonTextStyle(
      displayLarge: display.copyWith(fontSize: 64),
      displayMedium: display.copyWith(fontSize: 48),
      displaySmall: display.copyWith(fontSize: 32),
      headlineLarge: headline.copyWith(fontSize: 26),
      headlineMedium: headline.copyWith(fontSize: 22),
      headlineSmall: headline.copyWith(fontSize: 18),
      titleLarge: title.copyWith(fontSize: 24),
      titleMedium: title.copyWith(fontSize: 20),
      titleSmall: title.copyWith(fontSize: 16),
      bodyLarge: body.copyWith(fontSize: 16),
      bodyMedium: body.copyWith(fontSize: 14),
      bodySmall: body.copyWith(fontSize: 12),
      labelLarge: label.copyWith(fontSize: 16),
      labelMedium: label.copyWith(fontSize: 14),
      labelSmall: label.copyWith(fontSize: 12),
    );
  }

  static CommonTextStyle lerp(CommonTextStyle a, CommonTextStyle b, double t) {
    return CommonTextStyle(
      displayLarge:
          TextStyle.lerp(a.displayLarge, b.displayLarge, t) ?? b.displayLarge,
      displayMedium: TextStyle.lerp(a.displayMedium, b.displayMedium, t) ??
          b.displayMedium,
      displaySmall:
          TextStyle.lerp(a.displaySmall, b.displaySmall, t) ?? b.displaySmall,
      headlineLarge: TextStyle.lerp(a.headlineLarge, b.headlineLarge, t) ??
          b.headlineLarge,
      headlineMedium: TextStyle.lerp(a.headlineMedium, b.headlineMedium, t) ??
          b.headlineMedium,
      headlineSmall: TextStyle.lerp(a.headlineSmall, b.headlineSmall, t) ??
          b.headlineSmall,
      titleLarge: TextStyle.lerp(a.titleLarge, b.titleLarge, t) ?? b.titleLarge,
      titleMedium:
          TextStyle.lerp(a.titleMedium, b.titleMedium, t) ?? b.titleMedium,
      titleSmall: TextStyle.lerp(a.titleSmall, b.titleSmall, t) ?? b.titleSmall,
      bodyLarge: TextStyle.lerp(a.bodyLarge, b.bodyLarge, t) ?? b.bodyLarge,
      bodyMedium: TextStyle.lerp(a.bodyMedium, b.bodyMedium, t) ?? b.bodyMedium,
      bodySmall: TextStyle.lerp(a.bodySmall, b.bodySmall, t) ?? b.bodySmall,
      labelLarge: TextStyle.lerp(a.labelLarge, b.labelLarge, t) ?? b.labelLarge,
      labelMedium:
          TextStyle.lerp(a.labelMedium, b.labelMedium, t) ?? b.labelMedium,
      labelSmall: TextStyle.lerp(a.labelSmall, b.labelSmall, t) ?? b.labelSmall,
    );
  }
}
