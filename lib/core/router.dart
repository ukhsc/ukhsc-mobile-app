import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';

import '../features/lib.dart';

part 'router.g.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: HomeRoute().location,
  debugLogDiagnostics: true,
  routes: $appRoutes,
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

@TypedGoRoute<OnboardingRoute>(
  path: '/onboarding',
  routes: <TypedGoRoute<GoRouteData>>[
    TypedGoRoute<HistoryRoute>(path: 'history'),
    TypedGoRoute<GetStartedRoute>(path: 'get-started'),
  ],
)
class OnboardingRoute extends GoRouteData {
  const OnboardingRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return Container();
  }

  @override
  FutureOr<String?> redirect(BuildContext context, GoRouterState state) {
    if (state.fullPath == GetStartedRoute().location) {
      return state.fullPath;
    }

    // TODO: Skip history retrospect if user are redirected from QR code scan. (Web only)

    return HistoryRoute().location;
  }
}

class HistoryRoute extends GoRouteData {
  const HistoryRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return HistoryRetrospectPage(
      onFinished: () {
        GetStartedRoute().go(context);
      },
    );
  }
}

class GetStartedRoute extends GoRouteData {
  @override
  Widget build(BuildContext context, GoRouterState state) => GetStartedPage();
}
