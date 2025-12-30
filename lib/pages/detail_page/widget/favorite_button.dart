import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_3_35_7/features/favorite/blocs/add_favorite/add_favorite_bloc.dart';
import 'package:test_3_35_7/features/favorite/blocs/delete_favorite/delete_favorite_bloc.dart';
import 'package:test_3_35_7/features/favorite/blocs/find_favorite/find_favorite_bloc.dart';
import 'package:test_3_35_7/features/get_cat_detail/models/cat.dart';
import 'package:test_3_35_7/features/get_cat_images/models/my_image.dart';

class FavoriteButton extends StatelessWidget {
  final MyImage image;
  final Cat cat;
  const FavoriteButton({super.key, required this.image, required this.cat});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FindFavoriteBloc, FindFavoriteState>(
      builder: (context, findState) {
        final isFavorite =
            findState.status == FindFavoriteStatus.success &&
            findState.favorites.any((fav) => fav.imageId == image.id);
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
              context.read<AddFavoriteBloc>().add(AddFavorite(cat, image));
            }
          },
        );
      },
    );
  }
}
