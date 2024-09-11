import 'package:flutter/material.dart';
import 'package:flutter_instagram/router/route_constant.dart';
import 'package:go_router/go_router.dart';

import '../home_intagram/home_intagram_screen.dart';
import '../login_instagram/login_instagram_screen.dart';
import '../register_intagarm/register_instagram_screen.dart';

final GoRouter routerMyApp = GoRouter(
  routes: <RouteBase>[
    GoRoute(
      path: '/',
      name: routerNameLoginInstagram,
      builder: (BuildContext context, GoRouterState state) {
        return const LoginInstagramScreen();
      },
    ),
    GoRoute(
      path: routerPathRegisterInstagram,
      name: routerNameRegisterInstagram,
      builder: (BuildContext context, GoRouterState state) {
        return const RegisterInstagramScreen();
      },
    ),
    GoRoute(
      path: routerPathHomeInstagram,
      name: routerNameHomeInstagram,
      builder: (BuildContext context, GoRouterState state) {
        final userModel = (state.extra as Map<String, dynamic>?)?['userModel'];
        return HomeInstagramScreen(
          user: userModel,
        );
      },
    ),
  ],
);
