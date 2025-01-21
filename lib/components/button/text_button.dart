import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart' as material;
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:ukhsc_mobile_app/core/style/lib.dart';

enum IconAlignment {
  left,
  right,
}

class TextButton extends StatefulHookConsumerWidget {
  final VoidCallback? onPressed;
  final Color? color;
  final Widget child;

  const TextButton._({
    required super.key,
    this.onPressed,
    this.color,
    required this.child,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _TextButtonState();

  factory TextButton.label({
    Key? key,
    required VoidCallback? onPressed,
    required String label,
    Color? color,
  }) {
    return TextButton._(
      key: key,
      onPressed: onPressed,
      color: color,
      child: Text(label),
    );
  }

  factory TextButton.icon({
    Key? key,
    required VoidCallback? onPressed,
    required String label,
    required IconData icon,
    IconAlignment alignment = IconAlignment.left,
    Color? color,
  }) {
    final theme = useTheme();
    final buttonColor = color ?? theme.colors.iconColor;

    return TextButton._(
      key: key,
      onPressed: onPressed,
      color: color,
      child: Row(
        spacing: theme.spaces.sm,
        mainAxisSize: MainAxisSize.min,
        children: [
          if (alignment == IconAlignment.left) FaIcon(icon, color: buttonColor),
          Text(label),
          if (alignment == IconAlignment.right)
            FaIcon(icon, color: buttonColor),
        ],
      ),
    );
  }
}

class _TextButtonState extends ConsumerState<TextButton> {
  @override
  Widget build(BuildContext context) {
    final theme = useTheme();

    return material.TextButton(
      onPressed: widget.onPressed,
      style: material.TextButton.styleFrom(
        overlayColor: theme.colors.overlay,
      ),
      child: DefaultTextStyle(
        style: theme.text.button.copyWith(
            fontVariations: AppFontWeight.semiBold.variations,
            color: widget.color),
        child: widget.child,
      ),
    );
  }
}
