import 'package:flutter/material.dart';
import 'package:test_3_35_7/features/get_cat_detail/models/cat.dart';
import 'package:test_3_35_7/features/get_cat_images/models/my_image.dart';
import 'package:test_3_35_7/pages/detail_page/widget/detail_property.dart';
import 'package:test_3_35_7/pages/detail_page/widget/favorite_button.dart';

class DetailView extends StatelessWidget {
  final Cat cat;
  final MyImage image;
  const DetailView({super.key, required this.cat, required this.image});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(cat.breedName),
        centerTitle: true,
        actions: [FavoriteButton(image: image, cat: cat)],
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,

              children: [
                const SizedBox(height: 8),
                Container(
                  padding: EdgeInsets.all(8),
                  width: 300,
                  height: 300,

                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(8.0),
                    image: DecorationImage(
                      image: NetworkImage(image.url),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                DetailProperty(cat: cat),

                const SizedBox(height: 8),
                Container(
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Text(cat.description),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
