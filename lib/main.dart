import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_web_plugins/url_strategy.dart';
import 'package:ukhsc_mobile_app/core/style/lib.dart';

import 'core/router.dart';

Future<void> main() async {
  usePathUrlStrategy();
  WidgetsFlutterBinding.ensureInitialized();
  setPortraitOnly();

  runApp(
    ProviderScope(child: const MainApp()),
  );
}

void setPortraitOnly() {
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: appRouter,
      theme: ThemeData(
        extensions: <ThemeExtension<AppTheme>>[
          AppTheme.light(),
        ],
      ),
    );
  }
}
