import 'package:universal_html/html.dart' as html;

class WebDetector {
  static final Map<String, RegExp> _webviewRules = {
    'messenger': RegExp(
        r'(\bFB[\w_]+\/(Messenger))|(^(?!.*\buseragents)(?!.*\bIABMV).*(FB_IAB|FBAN).*)'),
    'instagram': RegExp(r'\bInstagram'),
    'facebook': RegExp(r'\bFB[\w_]+\/'),
    'twitter': RegExp(r'\bTwitter'),
    'line': RegExp(r'\bLine\/'),
    'wechat': RegExp(r'\bMicroMessenger\/'),
    'threads': RegExp(r'\bBarcelona'),
    'tiktok': RegExp(r'musical_ly|Bytedance'),
    'snapchat': RegExp(r'Snapchat'),
    'linkedin': RegExp(r'LinkedInApp'),
    'gsa': RegExp(r'GSA'),

    // Generic webview detection
    'webview': RegExp(r'WebView'),
    'ios_webview': RegExp(r'(iPhone|iPod|iPad)(?!.*Safari)'),
    'android_webview':
        RegExp(r'Android.*(;\s+wv|Version/\d.\d\s+Chrome/\d+(\\.0){3})'),
    'old_android_webview': RegExp(r'Linux; U; Android'),
  };

  static bool isWebView() {
    try {
      final userAgent = html.window.navigator.userAgent;
      return _webviewRules.values.any((regex) => regex.hasMatch(userAgent));
    } catch (e) {
      return false;
    }
  }

  static bool isPWA() {
    return html.window.matchMedia('(display-mode: standalone)').matches;
  }

  static bool isIOS() {
    return html.window.navigator.userAgent
        .contains(RegExp(r'iPhone|iPad|iPod'));
  }
}
