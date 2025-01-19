import 'package:flutter/widgets.dart';
import 'package:ukhsc_mobile_app/gen/fonts.gen.dart';

import 'colors.dart';

class AppTextStyle {
  final TextStyle title;
  final TextStyle specialNumber;

  AppTextStyle({
    required this.title,
    required this.specialNumber,
  });

  static AppTextStyle lerp(AppTextStyle a, AppTextStyle b, double t) {
    return AppTextStyle(
      title: TextStyle.lerp(a.title, b.title, t) ?? b.title,
      specialNumber: TextStyle.lerp(a.specialNumber, b.specialNumber, t) ??
          b.specialNumber,
    );
  }

  factory AppTextStyle.light(
    AppColors colors,
  ) {
    return AppTextStyle(
      title: TextStyle(
        fontFamily: FontFamily.notoSansTC,
        fontVariations: [FontVariation('wght', 700)],
        fontSize: 24,
      ),
      specialNumber: TextStyle(
        fontFamily: FontFamily.delaGothicOne,
        fontSize: 24,
        color: colors.primary,
      ),
    );
  }
}
