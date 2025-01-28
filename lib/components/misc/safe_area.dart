import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

import 'package:ukhsc_mobile_app/core/web.dart';

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
    final isIosPWA = kIsWeb && WebDetector.isPWA() && WebDetector.isIOS();

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
