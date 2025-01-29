import 'package:flutter/widgets.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'style.dart';

enum IconAlignment {
  left,
  right,
}

class ComposableButton extends HookWidget {
  final ButtonStyle style;
  final ButtonContent content;
  final VoidCallback? onPressed;

  const ComposableButton({
    super.key,
    required this.style,
    required this.content,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return style.build(
      AnimatedDefaultTextStyle(
        style: style.textStyle(),
        duration: const Duration(milliseconds: 200),
        child: content.child,
      ),
      onPressed,
    );
  }
}

class ButtonContent {
  final Widget child;

  const ButtonContent(this.child);

  ButtonContent withIcon(IconData icon,
      {IconAlignment alignment = IconAlignment.left}) {
    return ButtonContent(
      Row(
        mainAxisSize: MainAxisSize.min,
        spacing: 8,
        children: [
          if (alignment == IconAlignment.left) FaIcon(icon),
          child,
          if (alignment == IconAlignment.right) FaIcon(icon),
        ],
      ),
    );
  }

  ButtonContent withPadding(EdgeInsets padding) {
    return ButtonContent(
      Padding(
        padding: padding,
        child: child,
      ),
    );
  }

  // TODO: Implement this method
  ButtonContent withLoading() {
    throw UnimplementedError();
  }
}

extension ButtonContentExtensions on Widget {
  ButtonContent get asButtonContent => ButtonContent(this);
}
