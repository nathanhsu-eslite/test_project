import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:test_3_35_7/pages/favorite_list_page/favorite_page.dart';

part 'favorite_route.g.dart';

const favoritePath = '/favorite';

@TypedGoRoute<FavoriteRoute>(path: favoritePath)
class FavoriteRoute extends GoRouteData with $FavoriteRoute {
  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const FavoriteListPage();
  }
}
