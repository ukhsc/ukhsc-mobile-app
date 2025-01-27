import 'dart:ui';

const navyColor = Color(0xff34495D);
const blackColor = Color(0xff000000);
const whiteColor = Color(0xffFFFFFF);

class AppColors {
  final Color primary;

  final Color primaryText;
  final Color secondaryText;
  final Color tertiaryText;
  final Color accentText;

  final Color primaryBackground;
  final Color secondaryBackground;
  final Color screenBackground;

  final Color onPrimary;
  final Color lightButtonText;

  final Color iconColor;
  final Color selectedIconColor;

  final Color darkGradient;
  final Color tintGradient;
  final Color lightGradient;

  final Color overlay;
  final Color modalBarrier;

  AppColors({
    required this.primary,
    required this.primaryText,
    required this.secondaryText,
    required this.tertiaryText,
    required this.accentText,
    required this.primaryBackground,
    required this.secondaryBackground,
    required this.screenBackground,
    required this.onPrimary,
    required this.lightButtonText,
    required this.iconColor,
    required this.selectedIconColor,
    required this.darkGradient,
    required this.tintGradient,
    required this.lightGradient,
    required this.overlay,
    required this.modalBarrier,
  });

  static AppColors lerp(AppColors a, AppColors b, double t) {
    return AppColors(
      primary: Color.lerp(a.primary, b.primary, t) ?? b.primary,
      primaryText: Color.lerp(a.primaryText, b.primaryText, t) ?? b.primaryText,
      secondaryText:
          Color.lerp(a.secondaryText, b.secondaryText, t) ?? b.secondaryText,
      tertiaryText:
          Color.lerp(a.tertiaryText, b.tertiaryText, t) ?? b.tertiaryText,
      accentText: Color.lerp(a.accentText, b.accentText, t) ?? b.accentText,
      primaryBackground:
          Color.lerp(a.primaryBackground, b.primaryBackground, t) ??
              b.primaryBackground,
      secondaryBackground:
          Color.lerp(a.secondaryBackground, b.secondaryBackground, t) ??
              b.secondaryBackground,
      screenBackground: Color.lerp(a.screenBackground, b.screenBackground, t) ??
          b.screenBackground,
      onPrimary: Color.lerp(a.onPrimary, b.onPrimary, t) ?? b.onPrimary,
      lightButtonText: Color.lerp(a.lightButtonText, b.lightButtonText, t) ??
          b.lightButtonText,
      iconColor: Color.lerp(a.iconColor, b.iconColor, t) ?? b.iconColor,
      selectedIconColor:
          Color.lerp(a.selectedIconColor, b.selectedIconColor, t) ??
              b.selectedIconColor,
      darkGradient:
          Color.lerp(a.darkGradient, b.darkGradient, t) ?? b.darkGradient,
      tintGradient:
          Color.lerp(a.tintGradient, b.tintGradient, t) ?? b.tintGradient,
      lightGradient:
          Color.lerp(a.lightGradient, b.lightGradient, t) ?? b.lightGradient,
      overlay: Color.lerp(a.overlay, b.overlay, t) ?? b.overlay,
      modalBarrier:
          Color.lerp(a.modalBarrier, b.modalBarrier, t) ?? b.modalBarrier,
    );
  }

  factory AppColors.light() {
    return AppColors(
      primary: navyColor,
      primaryText: blackColor,
      secondaryText: const Color(0xff8B8B8B),
      tertiaryText: const Color(0xff9CACBC),
      accentText: Color.from(
        red: 0.6408,
        green: 0.5204,
        blue: 0.4085,
        alpha: 1.0,
        colorSpace: ColorSpace.displayP3,
      ),
      primaryBackground: const Color(0xffFADEC4),
      secondaryBackground: const Color(0xffFFE9D4),
      screenBackground: whiteColor,
      onPrimary: whiteColor,
      lightButtonText: navyColor,
      iconColor: const Color(0xffB2B2B2),
      selectedIconColor: navyColor,
      darkGradient: const Color(0xffF0C093),
      tintGradient: const Color(0xffF2E2CF),
      lightGradient: const Color(0xffFEF5EC),
      overlay: whiteColor,
      modalBarrier: blackColor.withValues(alpha: 0.6),
    );
  }
}
