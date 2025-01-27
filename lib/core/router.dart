import 'package:go_router/go_router.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

import '../features/lib.dart';

GoRouter getRouterConfig(bool hasCredential) {
  return GoRouter(
    initialLocation:
        hasCredential ? HomeRoute().location : OnboardingRoute().location,
    debugLogDiagnostics: true,
    routes: [...$homeRoute, ...$onboardingRoute, ...$authRoute],
    observers: [SentryNavigatorObserver()],
  );
}
