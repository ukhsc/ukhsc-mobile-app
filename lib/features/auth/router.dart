import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:ukhsc_mobile_app/features/auth/presentation/school_account_hint_page.dart';

import 'presentation/school_login_page.dart';
import 'models/school.dart';

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
class SchoolAccountHintRoute extends GoRouteData {
  final PartnerSchool? $extra;

  const SchoolAccountHintRoute({required this.$extra});

  @override
  FutureOr<String?> redirect(BuildContext context, GoRouterState state) {
    if ($extra == null) {
      return SchoolLoginRoute().location;
    }

    return null;
  }

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return SchoolAccountHintPage(school: $extra!);
  }
}

// TODO: Support deep linking
@TypedGoRoute<AuthCallbackRoute>(path: '/auth/callback/:provider')
class AuthCallbackRoute extends GoRouteData {
  final FederatedProvider provider;
  final String code;

  const AuthCallbackRoute({required this.provider, required this.code});

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return Text('${provider.toString()} callback not implemented, code: $code');
  }
}

enum FederatedProvider { google, googleWorkspace }
