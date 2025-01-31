import 'package:flutter/widgets.dart';
import 'package:ukhsc_mobile_app/gen/fonts.gen.dart';

import 'colors.dart';
import 'common_text.dart';

class AppTextStyle {
  final CommonTextStyle common;

  final TextStyle button;
  final TextStyle specialNumber;
  final TextStyle membershipCardYear;

  AppTextStyle({
    required this.common,
    required this.button,
    required this.specialNumber,
    required this.membershipCardYear,
  });

  static AppTextStyle lerp(AppTextStyle a, AppTextStyle b, double t) {
    return AppTextStyle(
      common: CommonTextStyle.lerp(a.common, b.common, t),
      button: TextStyle.lerp(a.button, b.button, t) ?? b.button,
      specialNumber: TextStyle.lerp(a.specialNumber, b.specialNumber, t) ??
          b.specialNumber,
      membershipCardYear:
          TextStyle.lerp(a.membershipCardYear, b.membershipCardYear, t) ??
              b.membershipCardYear,
    );
  }

  factory AppTextStyle.light(AppColors colors) {
    final commonStyle = CommonTextStyle.normal(colors);

    return AppTextStyle(
      common: commonStyle,
      button: commonStyle.titleSmall
          .copyWith(fontVariations: AppFontWeight.bold.variations),
      specialNumber: TextStyle(
        fontFamily: FontFamily.delaGothicOne,
        fontSize: 24,
        color: colors.primary,
      ),
      membershipCardYear: TextStyle(
        fontFamily: FontFamily.iBMPlexMono,
        fontWeight: FontWeight.w600,
        fontSize: 24,
        color: colors.primary.withValues(alpha: 0.2),
      ),
    );
  }
}

enum AppFontWeight {
  light(300),
  regular(400),
  medium(500),
  semiBold(600),
  bold(700),
  extraBold(800),
  black(900);

  final double value;

  const AppFontWeight(this.value);

  /// See Also: https://github.com/flutter/flutter/issues/148026
  List<FontVariation> get variations => [FontVariation.weight(value)];
}
