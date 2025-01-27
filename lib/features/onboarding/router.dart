import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';

import 'presentation/get_started_page.dart';
import 'presentation/history_retrospect_page.dart';

part 'router.g.dart';

@TypedGoRoute<OnboardingRoute>(name: 'Onboarding', path: '/onboarding')
class OnboardingRoute extends GoRouteData {
  const OnboardingRoute();
  @override
  FutureOr<String?> redirect(BuildContext context, GoRouterState state) {
    // TODO: Skip history retrospect if user are redirected from QR code scan. (Web only)
    return HistoryRoute().location;
  }
}

@TypedGoRoute<HistoryRoute>(
  name: 'History Retrospect',
  path: '/onboarding/history',
)
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

@TypedGoRoute<GetStartedRoute>(
  name: 'Get Started',
  path: '/onboarding/get-started',
)
class GetStartedRoute extends GoRouteData {
  @override
  Widget build(BuildContext context, GoRouterState state) => GetStartedPage();
}
