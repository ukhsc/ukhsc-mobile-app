import 'package:flutter/foundation.dart';
import 'package:universal_html/html.dart' as html;

class WebDetector {
  static bool isPWA() {
    return html.window.matchMedia('(display-mode: standalone)').matches;
  }

  static bool isBrowser() {
    return kIsWeb && !isPWA();
  }

  static bool isIOS() {
    return html.window.navigator.userAgent
        .contains(RegExp(r'iPhone|iPad|iPod'));
  }
}
