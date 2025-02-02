import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

import '../features/lib.dart';

final navigatorKey = GlobalKey<NavigatorState>();

GoRouter getRouterConfig(bool hasCredential) {
  final initialLocation =
      hasCredential ? HomeRoute().location : OnboardingRoute().location;

  return GoRouter(
    initialLocation: initialLocation,
    debugLogDiagnostics: true,
    navigatorKey: navigatorKey,
    routes: [...$homeRoute, ...$onboardingRoute, ...$authRoute],
    redirect: (context, state) {
      if (state.path == '/' || state.path == HomeRoute().location) {
        return initialLocation;
      }

      return null;
    },
    observers: [SentryNavigatorObserver()],
  );
}
