import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:test_3_35_7/features/get_cat_images/models/my_image.dart';
import 'package:test_3_35_7/pages/detail_page/detail_page.dart';
import 'package:test_3_35_7/pages/favorite_list_page/favorite_page.dart';
import 'package:test_3_35_7/pages/home_page/home_page.dart';
import 'package:test_3_35_7/page/error_page.dart';

final GoRouter router = GoRouter(
  errorBuilder: (context, state) {
    final error = state.error;
    return ErrorPage(error: error);
  },
  routes: <GoRoute>[
    GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state) {
        return const MyHomePage();
      },
      routes: [
        GoRoute(
          path: 'detail',
          builder: (BuildContext context, GoRouterState state) {
            final image = state.extra as MyImage;
            return CatDetailPage(image: image);
          },
        ),
      ],
    ),
    GoRoute(
      path: '/favorite',
      builder: (BuildContext context, GoRouterState state) {
        return const FavoriteListPage();
      },
    ),
  ],
);
