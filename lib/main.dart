import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_web_plugins/url_strategy.dart';
import 'package:logging/logging.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:sentry_logging/sentry_logging.dart';

import 'core/env.dart';
import 'core/error/lib.dart';
import 'core/style/lib.dart';
import 'core/router.dart';
import 'core/logger.dart';
import 'features/auth/lib.dart';
import 'components/error/error_wrap.dart';
import 'components/error/exception_display.dart';

Future<void> main() async {
  Logger.root.level = Level.ALL;
  runZonedGuarded(() async {
    platformSetup();

    final dsn = AppEnvironment.sentryDSN;
    if (kReleaseMode && dsn == null) {
      throw Exception('Sentry DSN is required in release mode');
    }
    if (kEnableSentry) {
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

    runApp(
      ProviderScope(
        child: SentryWidget(
          child: DefaultAssetBundle(
            bundle: SentryAssetBundle(),
            child: MainApp(hasCredential: hasCredential),
          ),
        ),
      ),
    );
  }, (error, stackTrace) async {
    if (!kEnableSentry) return;
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
      builder: (context, child) {
        ErrorWidget.builder = (FlutterErrorDetails details) {
          return PanicExceptionDisplay(details: details);
        };

        if (child == null) {
          globalLogger.severe('child is null in MaterialApp.builder');
          return PanicExceptionDisplay();
        }

        return Overlay(
          initialEntries: [
            OverlayEntry(
              builder: (context) => ErrorHandlerWrap(child: child),
            ),
          ],
        );
      },
    );
  }
}
