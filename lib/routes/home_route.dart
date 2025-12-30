import 'package:cats_repository/cats_repository.dart';
import 'package:data/data.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:test_3_35_7/pages/home_page/home_page.dart';
import 'package:test_3_35_7/routes/images_route.dart';
import 'package:test_3_35_7/routes/preference_form_route.dart';
import 'package:test_3_35_7/routes/vote_route.dart';

part 'home_route.g.dart';

@TypedStatefulShellRoute<HomeShellRouteData>(
  branches: [
    TypedStatefulShellBranch<StatefulShellBranchData>(
      routes: <TypedRoute<RouteData>>[
        TypedGoRoute<ImagesRoute>(path: imagesPath),
      ],
    ),
    TypedStatefulShellBranch<StatefulShellBranchData>(
      routes: <TypedRoute<RouteData>>[
        TypedGoRoute<PreferenceRoute>(
          path: preferencePath,
          routes: [TypedGoRoute<MatchRoute>(path: matchPath)],
        ),
      ],
    ),
    TypedStatefulShellBranch<StatefulShellBranchData>(
      routes: <TypedRoute<RouteData>>[
        TypedGoRoute<VoteRoute>(
          path: votePath,
          routes: [TypedGoRoute<VotedCatsRoute>(path: votedCatsPath)],
        ),
      ],
    ),
  ],
)
class HomeShellRouteData extends StatefulShellRouteData {
  HomeShellRouteData();

  @override
  Widget builder(context, state, navigationShell) {
    return MyHomePage(navigationShell: navigationShell);
  }
}
