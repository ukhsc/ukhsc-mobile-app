import 'dart:async';
import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';

import 'models/auth.dart';
import 'presentation/member_creation_page.dart';
import 'presentation/school_account_hint_page.dart';
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
  final String? code;
  final String? state;

  const AuthCallbackRoute({required this.provider, this.code, this.state});

  @override
  Widget build(BuildContext context, GoRouterState state) {
    if (this.state == null || code == null) {
      throw Exception('Invalid callback parameters');
    }

    final OAuthCallbackState state;
    try {
      state = OAuthCallbackState.fromJson(jsonDecode(this.state!));
    } catch (e) {
      throw Exception('Invalid callback state');
    }

    switch (state) {
      case RegisterMember():
        return MemberCreationPage(
          schoolId: state.schoolId,
          authorizationCode: code!,
          redirectUri: state.redirectUri,
        );
      case LinkFederatedAccount():
        throw UnimplementedError();
    }
  }
}
