import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';

import 'presentation/school_login_page.dart';

part 'router.g.dart';

@TypedGoRoute<SchoolLoginRoute>(path: '/auth/school')
class SchoolLoginRoute extends GoRouteData {
  const SchoolLoginRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return SchoolLoginPage();
  }
}

@TypedGoRoute<SchoolAccountHintRoute>(path: '/auth/school/hint')
class SchoolAccountHintRoute extends GoRouteData{
  final int schoolId;

  const SchoolAccountHintRoute({required this.schoolId});

  @override
  Widget build(BuildContext context, GoRouterState state) {
    throw UnimplementedError();
  }
}

@TypedGoRoute<AuthCallbackRoute>(path: '/auth/callback')
class AuthCallbackRoute extends GoRouteData {
  final AuthRedirectType redirectType;
  final String authorizationCode;
  const AuthCallbackRoute(
      {required this.redirectType, required this.authorizationCode});

  @override
  Widget build(BuildContext context, GoRouterState state) {
    throw UnimplementedError();
  }
}

enum AuthRedirectType {
  schoolLogin,
  linkAccount,
}
