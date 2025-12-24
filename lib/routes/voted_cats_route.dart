import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:test_3_35_7/pages/voted_cats_page/voted_cats_page.dart';

part 'voted_cats_route.g.dart';

const votedCatsPath = '/vote/voted-cats';

@TypedGoRoute<VotedCatsRoute>(path: votedCatsPath)
class VotedCatsRoute extends GoRouteData with $VotedCatsRoute {
  const VotedCatsRoute();

  @override
  Widget build(context, state) {
    return const VotedCatsPage();
  }
}
