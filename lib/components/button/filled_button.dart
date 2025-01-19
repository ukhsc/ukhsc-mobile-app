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
      child: Text(label, style: theme.text.button),
    );
  }
}

class _FilledButtonState extends ConsumerState<FilledButton> {
  @override
  Widget build(BuildContext context) {
    return material.FilledButton(
      onPressed: widget.onPressed,
      style: material.FilledButton.styleFrom(
        backgroundColor: widget.backgroundColor,
        padding: widget.padding,
        overlayColor: widget.overlayColor,
      ),
      child: widget.child,
    );
  }
}
