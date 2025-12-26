import 'package:data/data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import 'package:test_3_35_7/features/get_cat_images/bloc/get_cat_images_bloc.dart';
import 'package:test_3_35_7/features/get_cat_images/models/my_image.dart';
import 'package:test_3_35_7/features/votes/blocs/vote_cat/vote_cat_bloc.dart';
import 'package:test_3_35_7/routes/vote_route.dart';
import 'package:test_3_35_7/service/service_locator.dart';

class VotePage extends StatelessWidget {
  final UserEntity? user; // Accept UserEntity
  const VotePage({super.key, this.user});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => getIt<GetCatImagesBloc>()..add(GetCatImages()),
        ),
        BlocProvider(create: (context) => getIt<VoteCatBloc>()),
      ],
      child: VoteView(user: user),
    );
  }
}

class VoteView extends StatefulWidget {
  final UserEntity? user; //
  const VoteView({super.key, required this.user});

  @override
  State<VoteView> createState() => _VoteViewState();
}

class _VoteViewState extends State<VoteView> {
  Color _flashColor = Colors.transparent;
  bool _showFlash = false;
  Alignment _flashAlignment = Alignment.center;

  final CardSwiperController controller = CardSwiperController();

  void _triggerFlash(CardSwiperDirection direction) {
    setState(() {
      _showFlash = true;
      if (direction == CardSwiperDirection.left) {
        _flashColor = Colors.green;
        _flashAlignment = Alignment.centerLeft;
      } else {
        _flashColor = Colors.red;
        _flashAlignment = Alignment.centerRight;
      }
    });
    Future.delayed(const Duration(milliseconds: 500), () {
      setState(() {
        _showFlash = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Vote for Cats'),
        actions: [
          ElevatedButton.icon(
            onPressed: () {
              const VotedCatsRoute().push(context);
            },
            label: Text('voted list'),
            icon: Icon(Icons.thumb_up),
          ),
        ],
      ),
      body: _buildBody(context),
    );
  }

  Widget _buildBody(BuildContext context) {
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
                    _buildCardSwiper(context, state.images),
                    _buildBlocListener(context),
                  ],
                );
            }
          },
        ),
        _buildFlashEffect(),
      ],
    );
  }

  Widget _buildCardSwiper(BuildContext context, List<MyImage> images) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.6,
      child: CardSwiper(
        controller: controller,
        cardsCount: images.length,
        onSwipe: (previousIndex, currentIndex, direction) =>
            _onSwipe(previousIndex, currentIndex, context, direction),
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

  Widget _buildBlocListener(BuildContext context) {
    return BlocListener<VoteCatBloc, VoteCatState>(
      listener: (context, voteState) {
        if (voteState is VoteCatError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Failed to vote: ${voteState.exception}'),
              backgroundColor: Colors.red,
            ),
          );
        }
      },
      child: const SizedBox.shrink(),
    );
  }

  Widget _buildFlashEffect() {
    return AnimatedOpacity(
      opacity: _showFlash ? 0.7 : 0.0,
      duration: const Duration(milliseconds: 200),
      child: Container(
        alignment: _flashAlignment,
        child: Container(
          width: 100,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: _flashAlignment == Alignment.centerLeft
                  ? [
                      _flashColor.withValues(alpha: 0.7),
                      _flashColor.withValues(alpha: 0.0),
                    ]
                  : [
                      _flashColor.withValues(alpha: 0.0),
                      _flashColor.withValues(alpha: 0.7),
                    ],
              stops: const [0.0, 1.0],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ),
            borderRadius: _flashAlignment == Alignment.centerLeft
                ? const BorderRadius.only(
                    topRight: Radius.circular(200),
                    bottomRight: Radius.circular(200),
                  )
                : const BorderRadius.only(
                    topLeft: Radius.circular(200),
                    bottomLeft: Radius.circular(200),
                  ),
          ),
        ),
      ),
    );
  }

  bool _onSwipe(
    int previousIndex,
    int? currentIndex,
    BuildContext context,
    CardSwiperDirection direction,
  ) {
    _triggerFlash(direction);
    final getCatImagesBloc = context.read<GetCatImagesBloc>();
    final imageId = getCatImagesBloc.state.images[previousIndex].id;
    final subId = widget.user?.username ?? 'guest'; // Use username or 'guest'

    if (currentIndex == null) {
      getCatImagesBloc.add(CatImageRefreshed());
    } else if (currentIndex == getCatImagesBloc.state.images.length - 2) {
      getCatImagesBloc.add(GetCatImages());
    }
    switch (direction) {
      case CardSwiperDirection.left:
      case CardSwiperDirection.bottom:
        context.read<VoteCatBloc>().add(VoteCat(imageId, subId));
        break;
      case CardSwiperDirection.top:
      case CardSwiperDirection.right:
        // Vote value 0 for dislike
        break;
    }
    return true;
  }
}
