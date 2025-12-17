import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_3_35_7/features/favorite/blocs/add_favorite/add_favorite_bloc.dart';
import 'package:test_3_35_7/features/favorite/blocs/delete_favorite/delete_favorite_bloc.dart';
import 'package:test_3_35_7/features/favorite/blocs/find_favorite/find_favorite_bloc.dart';
import 'package:test_3_35_7/features/get_cat_detail/bloc/get_cat_bloc.dart';
import 'package:test_3_35_7/features/get_cat_images/models/my_image.dart';

import 'package:test_3_35_7/pages/detail_page/widget/detail_widget.dart';
import 'package:test_3_35_7/pages/error_page/error_page.dart';
import 'package:test_3_35_7/service/service_locator.dart';

class CatDetailPage extends StatelessWidget {
  const CatDetailPage({super.key, required this.image});
  final MyImage image;
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) =>
              GetCatBloc(getCatsDetailUseCase: getIt<GetCatDetailUC>())
                ..add(GetCatQueried(image.id)),
        ),
        BlocProvider<AddFavoriteBloc>(
          create: (context) =>
              AddFavoriteBloc(addFavoriteUseCase: getIt<AddFavoriteUseCase>()),
        ),
        BlocProvider<DeleteFavoriteBloc>(
          create: (context) => DeleteFavoriteBloc(
            deleteFavoriteUC: getIt<DeleteFavoriteUseCase>(),
          ),
        ),
        BlocProvider<FindFavoriteBloc>(
          create: (context) =>
              FindFavoriteBloc(findFavoriteUC: getIt<FindFavoriteUseCase>()),
        ),
      ],
      child: CatDetailView(image: image),
    );
  }
}

class CatDetailView extends StatelessWidget {
  const CatDetailView({super.key, required this.image});
  final MyImage image;
  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<AddFavoriteBloc, AddFavoriteState>(
          listener: (context, state) {
            if (state is AddFavoriteSuccess) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Added to favorites!')),
              );
              final catState = context.read<GetCatBloc>().state;
              if (catState is CatGetDetailSuccessState) {
                context.read<FindFavoriteBloc>().add(
                  FindFavoriteByName(catState.detail.breedName),
                );
              }
            } else if (state is AddFavoriteFailure) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Failed to add to favorites: ${state.message}'),
                ),
              );
            }
          },
        ),
        BlocListener<DeleteFavoriteBloc, DeleteFavoriteState>(
          listener: (context, state) {
            if (state is DeleteFavoriteSuccess) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Removed from favorites!')),
              );
              final catState = context.read<GetCatBloc>().state;
              if (catState is CatGetDetailSuccessState) {
                context.read<FindFavoriteBloc>().add(
                  FindFavoriteByName(catState.detail.breedName),
                );
              }
            } else if (state is DeleteFavoriteFailure) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    'Failed to remove from favorites: ${state.message}',
                  ),
                ),
              );
            }
          },
        ),
      ],
      child: BlocBuilder<GetCatBloc, GetCatDetailState>(
        builder: (context, state) {
          switch (state) {
            case GetCatDetailInitialState():
            case GetCatDetailLoadingState():
              return const Center(child: CircularProgressIndicator());
            case CatGetDetailFailureState():
              return ErrorPage(error: state.error);
            case CatGetDetailSuccessState():
              final cat = state.detail;
              context.read<FindFavoriteBloc>().add(
                FindFavoriteByName(cat.breedName),
              );
              return Scaffold(
                appBar: AppBar(
                  backgroundColor: Theme.of(context).colorScheme.inversePrimary,
                  title: Text(cat.breedName),
                  centerTitle: true,
                  actions: [
                    BlocBuilder<FindFavoriteBloc, FindFavoriteState>(
                      builder: (context, findState) {
                        final isFavorite =
                            findState.status == FindFavoriteStatus.success &&
                            findState.favorites.any(
                              (fav) => fav.imageId == image.id,
                            );
                        return IconButton(
                          icon: Icon(
                            isFavorite ? Icons.favorite : Icons.favorite_border,
                            color: isFavorite ? Colors.red : null,
                          ),
                          onPressed: () {
                            if (isFavorite) {
                              final favorite = findState.favorites.firstWhere(
                                (fav) => fav.imageId == image.id,
                              );
                              context.read<DeleteFavoriteBloc>().add(
                                DeleteFavoriteById(favorite.id),
                              );
                            } else {
                              context.read<AddFavoriteBloc>().add(
                                AddFavorite(cat, image),
                              );
                            }
                          },
                        );
                      },
                    ),
                  ],
                ),
                body: DetailWidget(image: image, cat: cat),
              );
          }
        },
      ),
    );
  }
}
