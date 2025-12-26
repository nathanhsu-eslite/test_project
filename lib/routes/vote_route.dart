import 'package:data/data.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:test_3_35_7/pages/vote_page/vote_page.dart';
import 'package:test_3_35_7/pages/voted_cats_page/voted_cats_page.dart';

part 'vote_route.g.dart';

const votePath = '/vote';

@TypedGoRoute<VoteRoute>(path: votePath)
class VoteRoute extends GoRouteData with $VoteRoute {
  final UserEntity? $extra;
  VoteRoute(this.$extra);

  @override
  Widget build(context, state) {
    return VotePage(user: $extra);
  }
}

const votedCatsPath = '/vote/voted-cats';

@TypedGoRoute<VotedCatsRoute>(path: votedCatsPath)
class VotedCatsRoute extends GoRouteData with $VotedCatsRoute {
  const VotedCatsRoute();

  @override
  Widget build(context, state) {
    return const VotedCatsPage();
  }
}
