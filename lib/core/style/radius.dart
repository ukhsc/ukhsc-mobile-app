import 'package:flutter/widgets.dart';

class AppRadius {
  final Radius extraLarge;
  final Radius large;
  final Radius medium;
  final Radius small;

  AppRadius({
    required this.extraLarge,
    required this.large,
    required this.medium,
    required this.small,
  });

  static AppRadius lerp(AppRadius a, AppRadius b, double t) {
    return AppRadius(
      extraLarge: Radius.lerp(a.extraLarge, b.extraLarge, t) ?? b.extraLarge,
      large: Radius.lerp(a.large, b.large, t) ?? b.large,
      medium: Radius.lerp(a.medium, b.medium, t) ?? b.medium,
      small: Radius.lerp(a.small, b.small, t) ?? b.small,
    );
  }

  factory AppRadius.normal() {
    return AppRadius(
      extraLarge: Radius.circular(50),
      large: Radius.circular(30),
      medium: Radius.circular(25),
      small: Radius.circular(20),
    );
  }
}
