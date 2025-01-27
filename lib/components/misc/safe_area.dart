import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:universal_html/html.dart' as html;

// Workaround for iOS PWA bottom padding.
// See Also: https://github.com/flutter/flutter/issues/84833
class AppSafeArea extends StatelessWidget {
  final Widget child;
  final bool top;
  final bool bottom;
  const AppSafeArea({
    super.key,
    this.top = true,
    this.bottom = true,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    final isPWA =
        kIsWeb && html.window.matchMedia('(display-mode: standalone)').matches;
    final isIosPWA = isPWA &&
        html.window.navigator.userAgent.contains(RegExp(r'iPhone|iPad|iPod'));

    return SafeArea(
        top: top,
        bottom: bottom,
        child: Padding(
          padding: EdgeInsets.only(
            bottom: bottom && isIosPWA ? 30 : 0,
          ),
          child: child,
        ));
  }
}
