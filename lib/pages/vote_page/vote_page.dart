import 'package:data/data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import 'package:test_3_35_7/features/get_cat_images/bloc/get_cat_images_bloc.dart';
import 'package:test_3_35_7/features/votes/blocs/vote_cat/vote_cat_bloc.dart';
import 'package:test_3_35_7/pages/vote_page/widget/vote_view.dart';
import 'package:test_3_35_7/routes/vote_route.dart';

class VotePage extends StatefulWidget {
  final UserEntity? user; //
  const VotePage({super.key, required this.user});

  @override
  State<VotePage> createState() => _VotePageState();
}

class _VotePageState extends State<VotePage> {
  Color _flashColor = Colors.transparent;
  bool _showFlash = false;
  Alignment _flashAlignment = Alignment.center;

  final CardSwiperController controller = CardSwiperController();

  void _triggerFlash(CardSwiperDirection direction) {
    setState(() {
      _showFlash = true;
      if (direction == CardSwiperDirection.left ||
          direction == CardSwiperDirection.top) {
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

  bool _handleCardSwipe(
    int previousIndex,
    int? currentIndex,
    CardSwiperDirection direction,
  ) {
    _triggerFlash(direction);
    final getCatImagesBloc = context.read<GetCatImagesBloc>();
    final imageId = getCatImagesBloc.state.images[previousIndex].id;
    final subId = widget.user?.username ?? 'guest';

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
            label: const Text('voted list'),
            icon: const Icon(Icons.thumb_up),
          ),
        ],
      ),
      body: BlocListener<VoteCatBloc, VoteCatState>(
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
        child: VoteView(
          flashColor: _flashColor,
          showFlash: _showFlash,
          flashAlignment: _flashAlignment,
          controller: controller,
          onSwipeCallback: (previousIndex, currentIndex, direction) =>
              _handleCardSwipe(previousIndex, currentIndex, direction),
          user: widget.user,
        ),
      ),
    );
  }
}
