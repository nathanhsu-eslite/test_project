import 'package:data/data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import 'package:test_3_35_7/features/get_cat_images/bloc/get_cat_images_bloc.dart';
import 'package:test_3_35_7/pages/vote_page/widget/cat_card_swiper.dart';
import 'package:test_3_35_7/pages/vote_page/widget/flash_effect_overlay.dart';

class VoteView extends StatelessWidget {
  const VoteView({
    super.key,
    required this.flashColor,
    required this.showFlash,
    required this.flashAlignment,
    required this.controller,
    required this.onSwipeCallback,
    required this.user,
  });

  final Color flashColor;
  final bool showFlash;
  final Alignment flashAlignment;
  final CardSwiperController controller;
  final SwiperOnSwipeCallback onSwipeCallback;
  final UserEntity? user;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        BlocBuilder<GetCatImagesBloc, GetCatImagesDataState>(
          builder: (context, state) {
            switch (state.status) {
              case CatImagesStatus.loading:
              case CatImagesStatus.initial:
                return const Center(child: CircularProgressIndicator());
              case CatImagesStatus.failure:
                return Center(
                  child: Text('Failed to load cat images: ${state.error}'),
                );
              case CatImagesStatus.success:
              case CatImagesStatus.loadingMore:
                if (state.images.isEmpty) {
                  return const Center(child: Text('No cat images found.'));
                }
                return Column(
                  children: [
                    CatCardSwiper(
                      controller: controller,
                      images: state.images,
                      onSwipeCallback: onSwipeCallback,
                    ),
                  ],
                );
            }
          },
        ),
        FlashEffectOverlay(
          showFlash: showFlash,
          flashColor: flashColor,
          flashAlignment: flashAlignment,
        ),
      ],
    );
  }
}
