import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';

import '../features/lib.dart';

final GoRouter appRouter = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => HomePage(),
      redirect: (context, state) {
        // TODO: Implement authentication check
        return '/onboarding';
      },
    ),
    GoRoute(
      path: '/onboarding',
      redirect: (context, state) => '/onboarding/history',
      routes: [
        GoRoute(
          path: '/history',
          builder: (context, state) => HistoryRetrospectPage(),
        ),
        GoRoute(
          path: '/get-started',
          builder: (context, state) => Placeholder(),
        ),
      ],
    ),
  ],
);
