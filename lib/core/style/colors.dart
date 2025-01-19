import 'package:flutter/widgets.dart';

const navyColor = Color(0xff34495D);
const blackColor = Color(0xff000000);
const whiteColor = Color(0xffFFFFFF);

class AppColors {
  final Color primary;

  final Color primaryText;
  final Color secondaryText;
  final Color tertiaryText;

  final Color primaryBackground;
  final Color secondaryBackground;

  final Color darkButtonText;
  final Color lightButtonText;

  final Color iconColor;
  final Color selectedIconColor;

  final Color darkGradient;
  final Color lightGradient;

  AppColors({
    required this.primary,
    required this.primaryText,
    required this.secondaryText,
    required this.tertiaryText,
    required this.primaryBackground,
    required this.secondaryBackground,
    required this.darkButtonText,
    required this.lightButtonText,
    required this.iconColor,
    required this.selectedIconColor,
    required this.darkGradient,
    required this.lightGradient,
  });

  static AppColors lerp(AppColors a, AppColors b, double t) {
    return AppColors(
      primary: Color.lerp(a.primary, b.primary, t) ?? b.primary,
      primaryText: Color.lerp(a.primaryText, b.primaryText, t) ?? b.primaryText,
      secondaryText:
          Color.lerp(a.secondaryText, b.secondaryText, t) ?? b.secondaryText,
      tertiaryText:
          Color.lerp(a.tertiaryText, b.tertiaryText, t) ?? b.tertiaryText,
      primaryBackground:
          Color.lerp(a.primaryBackground, b.primaryBackground, t) ??
              b.primaryBackground,
      secondaryBackground:
          Color.lerp(a.secondaryBackground, b.secondaryBackground, t) ??
              b.secondaryBackground,
      darkButtonText:
          Color.lerp(a.darkButtonText, b.darkButtonText, t) ?? b.darkButtonText,
      lightButtonText: Color.lerp(a.lightButtonText, b.lightButtonText, t) ??
          b.lightButtonText,
      iconColor: Color.lerp(a.iconColor, b.iconColor, t) ?? b.iconColor,
      selectedIconColor:
          Color.lerp(a.selectedIconColor, b.selectedIconColor, t) ??
              b.selectedIconColor,
      darkGradient:
          Color.lerp(a.darkGradient, b.darkGradient, t) ?? b.darkGradient,
      lightGradient:
          Color.lerp(a.lightGradient, b.lightGradient, t) ?? b.lightGradient,
    );
  }

  factory AppColors.light() {
    return AppColors(
      primary: navyColor,
      primaryText: blackColor,
      secondaryText: const Color(0xff8B8B8B),
      tertiaryText: const Color(0xff9CACBC),
      primaryBackground: const Color(0xffFADEC4),
      secondaryBackground: const Color(0xffFFE9D4),
      darkButtonText: whiteColor,
      lightButtonText: navyColor,
      iconColor: const Color(0xffB2B2B2),
      selectedIconColor: navyColor,
      darkGradient: const Color(0xffF0C093),
      lightGradient: const Color(0xffFEF5EC),
    );
  }
}
