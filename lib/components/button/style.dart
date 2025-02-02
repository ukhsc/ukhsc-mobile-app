import 'package:flutter/material.dart' as md;
import 'package:flutter/widgets.dart';

import 'package:ukhsc_mobile_app/core/style/lib.dart';

abstract class ButtonStyle {
  final Color? foregroundColor;

  const ButtonStyle({this.foregroundColor});

  Widget build(Widget child, VoidCallback? onPressed);
  TextStyle textStyle();
}

class PlainStyle extends ButtonStyle {
  final Color? overlayColor;

  const PlainStyle({required super.foregroundColor, this.overlayColor});

  @override
  Widget build(Widget child, VoidCallback? onPressed) {
    final theme = useTheme();

    return md.TextButton(
      onPressed: onPressed,
      style: md.TextButton.styleFrom(
        foregroundColor: foregroundColor,
        overlayColor: overlayColor ?? theme.colors.overlay,
        iconColor: foregroundColor,
        iconSize: 20,
      ),
      child: child,
    );
  }

  @override
  TextStyle textStyle() {
    final theme = useTheme();

    return theme.text.button.copyWith(color: foregroundColor);
  }
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
          borderRadius: BorderRadius.all(theme.radii.medium),
        ),
      ),
      child: IconTheme(
        data: IconThemeData(size: 24, color: foregroundColor),
        child: child,
      ),
    );
  }

  @override
  TextStyle textStyle() {
    final theme = useTheme();

    return theme.text.button.copyWith(color: foregroundColor);
  }
}

class OutlinedStyle extends ButtonStyle {
  final Color borderColor;
  const OutlinedStyle(
      {required super.foregroundColor, required this.borderColor});

  @override
  Widget build(Widget child, VoidCallback? onPressed) {
    return md.OutlinedButton(
      onPressed: onPressed,
      style: md.OutlinedButton.styleFrom(
        foregroundColor: foregroundColor,
        side: md.BorderSide(color: borderColor),
      ),
      child: child,
    );
  }

  factory OutlinedStyle.normal() {
    final theme = useTheme();

    return OutlinedStyle(
      foregroundColor: theme.colors.primary,
      borderColor: theme.colors.tertiaryText.withValues(alpha: 0.3),
    );
  }

  @override
  TextStyle textStyle() {
    final theme = useTheme();

    return theme.text.button.copyWith(color: foregroundColor);
  }
}
