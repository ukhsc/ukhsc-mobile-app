import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_web_plugins/url_strategy.dart';
import 'package:logging/logging.dart';
import 'package:logging_appenders/logging_appenders.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:sentry_logging/sentry_logging.dart';
import 'package:ukhsc_mobile_app/core/env.dart';
import 'package:ukhsc_mobile_app/features/auth/lib.dart';

import 'core/style/lib.dart';
import 'core/router.dart';

Future<void> main() async {
  PrintAppender.setupLogging();
  runZonedGuarded(() async {
    platformSetup();

    final dsn = AppEnvironment.sentryDSN;
    if (kReleaseMode && dsn == null) {
      throw Exception('Sentry DSN is required in release mode');
    }
    if (kReleaseMode && dsn != null) {
      await SentryFlutter.init(
        (options) {
          options.dsn = dsn;
          options.environment = AppEnvironment.deployEnvironment.name;

          options.tracesSampleRate = 0.5;
          options.profilesSampleRate = 1.0;

          options.enableTimeToFullDisplayTracing = true;
          options.attachScreenshot = true;

          options.experimental.replay.sessionSampleRate = 0.3;
          options.experimental.replay.onErrorSampleRate = 1.0;

          options.addIntegration(
              LoggingIntegration(minBreadcrumbLevel: Level.FINE));
        },
      );
    }

    final container = ProviderContainer();
    final auth = container.read(authRepositoryProvider);
    final hasCredential = await auth.hasCredential();

    // ignore: missing_provider_scope
    runApp(
      SentryWidget(
        child: DefaultAssetBundle(
          bundle: SentryAssetBundle(),
          child: ProviderScope(child: MainApp(hasCredential: hasCredential)),
        ),
      ),
    );
  }, (error, stackTrace) async {
    if (kDebugMode) return;
    await Sentry.captureException(error, stackTrace: stackTrace);
  });
}

void platformSetup() {
  if (kIsWeb) {
    usePathUrlStrategy();
    GoRouter.optionURLReflectsImperativeAPIs = true;
  }

  SentryWidgetsFlutterBinding.ensureInitialized();
  setPortraitOnly();
}

void setPortraitOnly() {
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
}

class MainApp extends StatelessWidget {
  final bool hasCredential;
  const MainApp({super.key, required this.hasCredential});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: getRouterConfig(hasCredential),
      theme: AppTheme.initial(),
    );
  }
}
