import 'package:data/data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:test_3_35_7/features/get_cat_images/bloc/get_cat_images_bloc.dart';
import 'package:test_3_35_7/features/votes/blocs/delete_vote/delete_votes_bloc.dart';
import 'package:test_3_35_7/features/votes/blocs/get_votes/get_votes_bloc.dart';
import 'package:test_3_35_7/features/votes/blocs/vote_cat/vote_cat_bloc.dart';
import 'package:test_3_35_7/pages/vote_page/vote_page.dart';
import 'package:test_3_35_7/pages/voted_cats_page/voted_cats_page.dart';
import 'package:test_3_35_7/routes/home_route.dart';

part 'vote_route.g.dart';

const votePath = '/vote';

@TypedGoRoute<VoteRoute>(path: votePath)
class VoteRoute extends GoRouteData with $VoteRoute {
  final UserEntity? $extra;
  VoteRoute(this.$extra);

  @override
  Widget build(context, state) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) =>
              GetIt.I.get<GetCatImagesBloc>()..add(GetCatImages()),
        ),
        BlocProvider(create: (context) => GetIt.I.get<VoteCatBloc>()),
      ],
      child: VotePage(user: $extra),
    );
  }
}

const votedCatsPath = 'voted-cats';

class VotedCatsRoute extends GoRouteData with $VotedCatsRoute {
  const VotedCatsRoute();

  @override
  Widget build(context, state) {
    return const VotedCatsPage();
  }
}
