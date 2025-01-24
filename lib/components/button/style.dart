import 'package:flutter/material.dart' as md;
import 'package:flutter/widgets.dart';

import 'package:ukhsc_mobile_app/core/style/lib.dart';

abstract class ButtonStyle {
  final Color foregroundColor;

  const ButtonStyle({required this.foregroundColor});

  Widget build(Widget child, VoidCallback? onPressed);
  TextStyle textStyle();
}

class FilledStyle extends ButtonStyle {
  final Color backgroundColor;
  final Color overlayColor;

  const FilledStyle({
    required super.foregroundColor,
    required this.backgroundColor,
    required this.overlayColor,
  });

  factory FilledStyle.light() {
    final theme = useTheme();

    return FilledStyle(
      backgroundColor: Colors.white,
      foregroundColor: theme.colors.lightButtonText,
      overlayColor: theme.colors.primary,
    );
  }

  factory FilledStyle.dark() {
    final theme = useTheme();

    return FilledStyle(
      backgroundColor: theme.colors.primary,
      foregroundColor: theme.colors.onPrimary,
      overlayColor: theme.colors.overlay,
    );
  }

  @override
  Widget build(Widget child, VoidCallback? onPressed) {
    final theme = useTheme();

    return md.FilledButton(
      onPressed: onPressed,
      style: md.FilledButton.styleFrom(
        backgroundColor: backgroundColor,
        foregroundColor: foregroundColor,
        overlayColor: overlayColor,
        alignment: Alignment.centerLeft,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(theme.radii.large),
        ),
      ),
      child: child,
    );
  }

  @override
  TextStyle textStyle() {
    final theme = useTheme();

    return theme.text.button.copyWith(
      color: foregroundColor,
    );
  }
}

class OutlinedStyle extends ButtonStyle {
  const OutlinedStyle({required super.foregroundColor});

  @override
  Widget build(Widget child, VoidCallback? onPressed) {
    return md.OutlinedButton(
      onPressed: onPressed,
      style: md.OutlinedButton.styleFrom(
        foregroundColor: foregroundColor,
      ),
      child: child,
    );
  }

  @override
  TextStyle textStyle() {
    throw UnimplementedError();
  }
}
