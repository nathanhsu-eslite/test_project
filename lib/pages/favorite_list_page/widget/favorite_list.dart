import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_3_35_7/features/favorite/blocs/blocs.dart';
import 'package:test_3_35_7/features/favorite/models/favorite_cat.dart';
import 'package:test_3_35_7/features/get_cat_images/models/my_image.dart';
import 'package:test_3_35_7/routes/detail_route.dart';

class FavoriteList extends StatelessWidget {
  final List<FavoriteCat> favorites;
  const FavoriteList({super.key, required this.favorites});

  @override
  Widget build(BuildContext context) {
    if (favorites.isEmpty) {
      return const Center(child: Text('No favorites yet.'));
    }
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 8.0,
        mainAxisSpacing: 8.0,
        childAspectRatio: 0.8,
      ),
      itemCount: favorites.length,
      itemBuilder: (context, index) {
        final favorite = favorites[index];
        return InkWell(
          onTap: () async {
            final result = await DetailRoute(
              MyImage(
                id: favorite.imageId,
                url: favorite.url,
                height: favorite.urlHeight,
                width: favorite.urlWidth,
              ),
            ).push<bool>(context);
            if (result == null || false) return;
            if (!context.mounted) return;
            context.read<GetAllFavoriteBloc>().add(DoGetAllFavoriteEvent());
          },
          child: Card(
            margin: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Expanded(child: Image.network(favorite.url, fit: BoxFit.cover)),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(favorite.breedName, textAlign: TextAlign.center),
                ),
                IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () {
                    context.read<DeleteFavoriteBloc>().add(
                      DeleteFavoriteById(favorite.id),
                    );
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
