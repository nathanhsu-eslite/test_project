import 'package:cats_repository/cats_repository.dart';
import 'package:flutter/material.dart';
import 'package:test_3_35_7/features/get_cat_images/models/my_image.dart';
import 'package:test_3_35_7/routes/detail_route.dart';

class MatchResultWidget extends StatelessWidget {
  const MatchResultWidget({super.key, required this.breedMatchResult});
  final BreedMatchResult breedMatchResult;

  @override
  Widget build(BuildContext context) {
    final image = breedMatchResult.catModel;
    final breeds = image.breeds;
    return GestureDetector(
      onTap: () {
        DetailRoute(
          MyImage(
            id: image.id,
            url: image.url,
            width: image.urlWidth,
            height: image.urlWidth,
          ),
        ).push(context);
      },
      child: Card(
        margin: const EdgeInsets.all(8.0),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.network(
                image.url,
                height: 200,
                fit: BoxFit.contain,
                cacheHeight: image.urlHeight,
                cacheWidth: image.urlWidth,
              ),
              ListTile(
                title: Text(breeds!.first.name),
                subtitle: Text(
                  'Score: ${breedMatchResult.score.toStringAsFixed(2)}',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
