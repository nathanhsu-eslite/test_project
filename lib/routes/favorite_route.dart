import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:test_3_35_7/features/favorite/blocs/blocs.dart';
import 'package:test_3_35_7/pages/favorite_list_page/favorite_page.dart';

part 'favorite_route.g.dart';

const favoritePath = '/favorite';

@TypedGoRoute<FavoriteRoute>(path: favoritePath)
class FavoriteRoute extends GoRouteData with $FavoriteRoute {
  @override
  Widget build(BuildContext context, GoRouterState state) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<GetAllFavoriteBloc>(
          create: (context) => GetAllFavoriteBloc(
            getFavoriteUC: GetIt.I.get<GetAllFavoriteUseCase>(),
          )..add(DoGetAllFavoriteEvent()),
        ),
        BlocProvider<FindFavoriteBloc>(
          create: (context) => FindFavoriteBloc(
            findFavoriteUC: GetIt.I.get<FindFavoriteUseCase>(),
          ),
        ),
        BlocProvider<DeleteFavoriteBloc>(
          create: (context) => DeleteFavoriteBloc(
            deleteFavoriteUC: GetIt.I.get<DeleteFavoriteUseCase>(),
          ),
        ),
        BlocProvider<ClearFavoriteBloc>(
          create: (context) => ClearFavoriteBloc(
            clearFavoriteUC: GetIt.I.get<ClearFavoriteUseCase>(),
          ),
        ),
      ],
      child: const FavoriteListPage(),
    );
  }
}
