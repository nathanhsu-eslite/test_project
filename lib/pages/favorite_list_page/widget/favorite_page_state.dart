import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_3_35_7/features/favorite/blocs/find_favorite/find_favorite_bloc.dart';
import 'package:test_3_35_7/features/favorite/blocs/get_all_favorite/get_all_favorite_bloc.dart';
import 'package:test_3_35_7/pages/favorite_list_page/widget/favorite_list.dart';

class FavoriteViewState extends StatelessWidget {
  final bool isSearchActive;
  const FavoriteViewState({super.key, required this.isSearchActive});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: isSearchActive
          ? BlocBuilder<FindFavoriteBloc, FindFavoriteState>(
              builder: (context, state) {
                if (state is FindFavoriteDataState) {
                  if (state.status == FindFavoriteStatus.loading) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (state.status == FindFavoriteStatus.success) {
                    return FavoriteList(favorites: state.favorites);
                  }
                  if (state.status == FindFavoriteStatus.failure) {
                    return Center(
                      child: Text(state.errorMessage ?? 'Search failed'),
                    );
                  }
                }
                return Container();
              },
            )
          : BlocBuilder<GetAllFavoriteBloc, GetAllFavoriteState>(
              builder: (context, state) {
                if (state.status == GetAllFavoriteStatus.loading) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (state.status == GetAllFavoriteStatus.success) {
                  return FavoriteList(favorites: state.favorites);
                }
                return const Center(
                  child: Text('Press the button to load favorites.'),
                );
              },
            ),
    );
  }
}
