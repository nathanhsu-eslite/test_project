import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:get_it/get_it.dart';
import 'package:test_3_35_7/routes/go_router_refresh_stream.dart';

import 'package:test_3_35_7/routes/detail_route.dart' as detail;
import 'package:test_3_35_7/routes/favorite_route.dart' as favorite;
import 'package:test_3_35_7/routes/home_route.dart' as home;
import 'package:test_3_35_7/routes/preference_form_route.dart' as preference;
import 'package:test_3_35_7/routes/login_route.dart' as login;
import 'package:test_3_35_7/routes/register_route.dart' as register;
import 'package:test_3_35_7/service/auth_service.dart';

final getIt = GetIt.instance;

final GoRouter router = GoRouter(
  routes: <RouteBase>[
    ...home.$appRoutes,
    ...detail.$appRoutes,
    ...favorite.$appRoutes,
    ...preference.$appRoutes,
    ...login.$appRoutes,
    ...register.$appRoutes,
  ],
  redirect: (BuildContext context, GoRouterState state) {
    final bool loggedIn = getIt<AuthService>().isLoggedIn;

    final String currentPath = state.matchedLocation;

    // Redirect from '/' to '/home'
    if (currentPath == '/') {
      return home.homePath;
    }

    final bool goingToLogin = currentPath == login.loginPath;
    final bool goingToRegister = currentPath == register.registerPath;
    final bool goingToPreference = currentPath == preference.preferencePath;
    final bool goingToFavorite = currentPath == favorite.favoritePath;
    final bool goingToDetail = currentPath.startsWith(detail.detailPath);

    // If not logged in, redirect to the login page if trying to access protected routes
    if (!loggedIn && (goingToFavorite || goingToDetail || goingToPreference)) {
      return login.LoginRoute().location;
    }

    // If logged in and going to login or register page, redirect to home page
    if (loggedIn && (goingToLogin || goingToRegister)) {
      return home.homePath;
    }

    return null;
  },
  refreshListenable: GoRouterRefreshStream(getIt<AuthService>().authStream),
);
