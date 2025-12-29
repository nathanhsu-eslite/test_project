import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:test_3_35_7/features/favorite/blocs/add_favorite/add_favorite_bloc.dart';
import 'package:test_3_35_7/features/favorite/blocs/delete_favorite/delete_favorite_bloc.dart';
import 'package:test_3_35_7/features/favorite/blocs/find_favorite/find_favorite_bloc.dart';
import 'package:test_3_35_7/features/get_cat_detail/bloc/get_cat_bloc.dart';
import 'package:test_3_35_7/features/get_cat_images/models/my_image.dart';
import 'package:test_3_35_7/pages/detail_page/detail_page.dart';

part 'detail_route.g.dart';

const detailPath = '/detail';

@TypedGoRoute<DetailRoute>(path: detailPath)
class DetailRoute extends GoRouteData with $DetailRoute {
  final MyImage $extra;

  DetailRoute(this.$extra);
  @override
  Widget build(BuildContext context, GoRouterState state) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) =>
              GetCatBloc(getCatsDetailUseCase: GetIt.I.get<GetCatDetailUC>())
                ..add(GetCatQueried($extra.id)),
        ),
        BlocProvider<AddFavoriteBloc>(
          create: (context) => AddFavoriteBloc(
            addFavoriteUseCase: GetIt.I.get<AddFavoriteUseCase>(),
          ),
        ),
        BlocProvider<DeleteFavoriteBloc>(
          create: (context) => DeleteFavoriteBloc(
            deleteFavoriteUC: GetIt.I.get<DeleteFavoriteUseCase>(),
          ),
        ),
        BlocProvider<FindFavoriteBloc>(
          create: (context) => FindFavoriteBloc(
            findFavoriteUC: GetIt.I.get<FindFavoriteUseCase>(),
          ),
        ),
      ],

      child: CatDetailPage(image: $extra),
    );
  }
}
