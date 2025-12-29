import 'package:flutter/material.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import 'package:test_3_35_7/features/get_cat_images/models/my_image.dart';

typedef SwiperOnSwipeCallback =
    bool Function(
      int previousIndex,
      int? currentIndex,
      CardSwiperDirection direction,
    );

class CatCardSwiper extends StatelessWidget {
  const CatCardSwiper({
    super.key,
    required this.controller,
    required this.images,
    required this.onSwipeCallback,
  });

  final CardSwiperController controller;
  final List<MyImage> images;
  final SwiperOnSwipeCallback onSwipeCallback;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.6,
      child: CardSwiper(
        controller: controller,
        cardsCount: images.length,
        onSwipe: onSwipeCallback,
        padding: const EdgeInsets.all(24.0),
        cardBuilder:
            (
              context,
              index,
              horizontalThresholdPercentage,
              verticalThresholdPercentage,
            ) {
              final image = images[index];
              return Card(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Image.network(
                          image.url,
                          width: double.infinity,
                          fit: BoxFit.contain,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
      ),
    );
  }
}
