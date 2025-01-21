import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart' as material;
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:ukhsc_mobile_app/core/style/lib.dart';

class FilledButton extends StatefulHookConsumerWidget {
  final VoidCallback? onPressed;
  final Color? textColor;
  final Color? backgroundColor;
  final EdgeInsetsGeometry? padding;
  final Color? overlayColor;
  final Widget child;

  const FilledButton._(
      {required super.key,
      required this.onPressed,
      required this.textColor,
      required this.backgroundColor,
      required this.padding,
      required this.overlayColor,
      required this.child});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _FilledButtonState();

  factory FilledButton.lightLabel({
    Key? key,
    required VoidCallback? onPressed,
    required String label,
    Color? backgroundColor,
    EdgeInsetsGeometry? padding,
  }) {
    final theme = useTheme();

    return FilledButton._(
      key: key,
      onPressed: onPressed,
      textColor: theme.colors.lightButtonText,
      backgroundColor: backgroundColor ?? theme.colors.primaryBackground,
      padding: padding,
      overlayColor: theme.colors.primary,
      child: Text(label),
    );
  }

  factory FilledButton.darkLabel({
    Key? key,
    required VoidCallback? onPressed,
    required String label,
    Color? backgroundColor,
    EdgeInsetsGeometry? padding,
  }) {
    final theme = useTheme();

    return FilledButton._(
      key: key,
      onPressed: onPressed,
      textColor: theme.colors.darkButtonText,
      backgroundColor: backgroundColor ?? theme.colors.primary,
      padding: padding,
      overlayColor: theme.colors.primaryBackground,
      child: Text(label),
    );
  }
}

class _FilledButtonState extends ConsumerState<FilledButton> {
  @override
  Widget build(BuildContext context) {
    final theme = useTheme();

    return material.FilledButton(
      onPressed: widget.onPressed,
      style: material.FilledButton.styleFrom(
        backgroundColor: widget.backgroundColor,
        padding: widget.padding ??
            EdgeInsets.symmetric(
                vertical: theme.spaces.md, horizontal: theme.spaces.lg),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25),
        ),
        overlayColor: widget.overlayColor,
      ),
      child: DefaultTextStyle(
        style:
            theme.text.button.copyWith(fontSize: 18, color: widget.textColor),
        child: widget.child,
      ),
    );
  }
}
