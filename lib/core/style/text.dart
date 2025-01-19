import 'package:flutter/widgets.dart';
import 'package:ukhsc_mobile_app/gen/fonts.gen.dart';

import 'colors.dart';

class AppTextStyle {
  final TextStyle basic;

  final TextStyle display1;

  final TextStyle title;
  final TextStyle button;
  final TextStyle specialNumber;

  AppTextStyle({
    required this.basic,
    required this.display1,
    required this.title,
    required this.button,
    required this.specialNumber,
  });

  static AppTextStyle lerp(AppTextStyle a, AppTextStyle b, double t) {
    return AppTextStyle(
      basic: TextStyle.lerp(a.basic, b.basic, t) ?? b.basic,
      display1: TextStyle.lerp(a.display1, b.display1, t) ?? b.display1,
      title: TextStyle.lerp(a.title, b.title, t) ?? b.title,
      button: TextStyle.lerp(a.button, b.button, t) ?? b.button,
      specialNumber: TextStyle.lerp(a.specialNumber, b.specialNumber, t) ??
          b.specialNumber,
    );
  }

  factory AppTextStyle.light(
    AppColors colors,
  ) {
    final basicStyle = TextStyle(
      fontFamily: FontFamily.notoSansTC,
      fontVariations: [FontVariation('wght', 550)],
    );

    return AppTextStyle(
      basic: basicStyle,
      display1: basicStyle.copyWith(
        fontVariations: [FontVariation('wght', 650)],
        fontSize: 64,
        color: colors.primary,
      ),
      title: basicStyle.copyWith(
        fontVariations: [FontVariation('wght', 700)],
        fontSize: 24,
      ),
      button: basicStyle.copyWith(
        fontFamily: FontFamily.notoSansTC,
        fontVariations: [FontVariation('wght', 650)],
        fontSize: 18,
        color: colors.primary,
      ),
      specialNumber: TextStyle(
        fontFamily: FontFamily.delaGothicOne,
        fontSize: 24,
        color: colors.primary,
      ),
    );
  }
}
