import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:ukhsc_mobile_app/features/auth/lib.dart';

import '../features/lib.dart';

part 'router.g.dart';

GoRouter appRouter = GoRouter(
  initialLocation: HomeRoute().location,
  debugLogDiagnostics: true,
  routes: [...$appRoutes, ...$onboardingRoute, ...$authRoute],
);

@TypedGoRoute<HomeRoute>(path: '/home')
class HomeRoute extends GoRouteData {
  const HomeRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return HomePage();
  }

  @override
  FutureOr<String?> redirect(BuildContext context, GoRouterState state) {
    // TODO: Handle authentication redirection.

    return OnboardingRoute().location;
  }
}
