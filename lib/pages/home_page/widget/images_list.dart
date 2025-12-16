import 'package:flutter/material.dart';
import 'package:test_3_35_7/features/get_cat_images/models/my_image.dart';
import 'package:test_3_35_7/routes/detail_route.dart';

class ImagesList extends StatelessWidget {
  const ImagesList({
    super.key,
    required this.images,
    required this.controller,
    this.hasReachedMax = false,
  });
  final ScrollController controller;
  final bool hasReachedMax;

  final List<MyImage> images;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      controller: controller,
      itemCount: hasReachedMax ? images.length : images.length + 1,
      itemBuilder: (context, index) {
        if (index >= images.length) {
          return const Padding(
            padding: EdgeInsets.all(8.0),
            child: Center(child: CircularProgressIndicator()),
          );
        }
        final image = images[index];
        return GestureDetector(
          onTap: () {
            DetailRoute(image).push(context);
          },
          child: Card(
            margin: const EdgeInsets.all(8.0),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.network(
                    image.url,
                    width: double.infinity,
                    height: 200,
                    fit: BoxFit.cover,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
