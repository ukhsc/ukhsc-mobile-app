import 'package:flutter/widgets.dart';

class AppRadius {
  final Radius large;
  final Radius medium;
  final Radius small;

  AppRadius({
    required this.large,
    required this.medium,
    required this.small,
  });

  static AppRadius lerp(AppRadius a, AppRadius b, double t) {
    return AppRadius(
      large: Radius.lerp(a.large, b.large, t) ?? b.large,
      medium: Radius.lerp(a.medium, b.medium, t) ?? b.medium,
      small: Radius.lerp(a.small, b.small, t) ?? b.small,
    );
  }

  factory AppRadius.normal() {
    return AppRadius(
      large: Radius.circular(30),
      medium: Radius.circular(20),
      small: Radius.circular(10),
    );
  }
}
