import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart' as material;
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:ukhsc_mobile_app/core/style/lib.dart';

class FilledButtonOptions {
  final TextStyle? textStyle;
  final Color? backgroundColor;
  final EdgeInsetsGeometry? padding;
  final Color? overlayColor;
  final IconData? icon;

  FilledButtonOptions({
    this.textStyle,
    this.backgroundColor,
    this.padding,
    this.overlayColor,
    this.icon,
  });

  FilledButtonOptions merge(FilledButtonOptions? other) {
    return FilledButtonOptions(
      textStyle: other?.textStyle ?? textStyle,
      backgroundColor: other?.backgroundColor ?? backgroundColor,
      padding: other?.padding ?? padding,
      overlayColor: other?.overlayColor ?? overlayColor,
      icon: other?.icon ?? icon,
    );
  }
}

class FilledButton extends StatefulHookWidget {
  final VoidCallback? onPressed;
  final FilledButtonOptions options;
  final Widget child;

  const FilledButton._(
      {required super.key,
      required this.onPressed,
      required this.options,
      required this.child});

  @override
  State<FilledButton> createState() => _FilledButtonState();

  factory FilledButton.lightLabel({
    Key? key,
    required VoidCallback? onPressed,
    required String label,
    FilledButtonOptions? options,
  }) {
    final theme = useTheme();

    return FilledButton._(
      key: key,
      onPressed: onPressed,
      options: FilledButtonOptions(
        textStyle: TextStyle(
          color: theme.colors.lightButtonText,
        ),
        backgroundColor: theme.colors.primaryBackground,
        overlayColor: theme.colors.primary,
      ).merge(options),
      child: Text(label),
    );
  }

  factory FilledButton.darkLabel({
    Key? key,
    required VoidCallback? onPressed,
    required String label,
    FilledButtonOptions? options,
  }) {
    final theme = useTheme();

    return FilledButton._(
      key: key,
      onPressed: onPressed,
      options: FilledButtonOptions(
        textStyle: TextStyle(
          color: theme.colors.darkButtonText,
        ),
        backgroundColor: theme.colors.primary,
        overlayColor: theme.colors.primaryBackground,
      ).merge(options),
      child: Text(label),
    );
  }
}

class _FilledButtonState extends State<FilledButton> {
  @override
  Widget build(BuildContext context) {
    final theme = useTheme();
    final options = widget.options;

    return material.FilledButton(
      onPressed: widget.onPressed,
      style: material.FilledButton.styleFrom(
        backgroundColor: options.backgroundColor,
        padding: options.padding ??
            EdgeInsets.symmetric(
                vertical: theme.spaces.md, horizontal: theme.spaces.lg),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(theme.radii.large),
        ),
        animationDuration: Duration(milliseconds: 300),
        overlayColor: options.overlayColor,
      ),
      child: AnimatedDefaultTextStyle(
        duration: Duration(milliseconds: 200),
        style:
            theme.text.button.copyWith(fontSize: 18).merge(options.textStyle),
        child: Builder(builder: (context) {
          if (options.icon == null) return widget.child;

          return Row(
            mainAxisAlignment: MainAxisAlignment.start,
            spacing: theme.spaces.xs,
            children: [
              SizedBox(),
              FaIcon(options.icon, color: options.textStyle?.color, size: 24),
              widget.child,
            ],
          );
        }),
      ),
    );
  }
}
