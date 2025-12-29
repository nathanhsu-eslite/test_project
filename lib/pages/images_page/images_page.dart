import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:test_3_35_7/features/get_cat_images/bloc/get_cat_images_bloc.dart';

import 'package:test_3_35_7/pages/error_page/error_page.dart';
import 'package:test_3_35_7/pages/images_page/widget/images_list.dart';

class ImagesPage extends StatelessWidget {
  const ImagesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GetIt.I.get<GetCatImagesBloc>()..add(GetCatImages()),
      child: ImagesView(),
    );
  }
}

class ImagesView extends StatefulWidget {
  const ImagesView({super.key});

  @override
  State<ImagesView> createState() => _ImagesViewState();
}

class _ImagesViewState extends State<ImagesView> {
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetCatImagesBloc, GetCatImagesState>(
      builder: (context, state) {
        switch (state.status) {
          case CatImagesStatus.initial:
          case CatImagesStatus.loading:
            return const Center(child: CircularProgressIndicator());
          case CatImagesStatus.success:
          case CatImagesStatus.loadingMore:
            return RefreshIndicator(
              onRefresh: () async {
                context.read<GetCatImagesBloc>().add(CatImageRefreshed());
              },
              child: ImagesList(
                images: state.images,
                hasReachedMax: state.hasReachedMax,
                controller: _scrollController,
              ),
            );
          case CatImagesStatus.failure:
            return ErrorPage(error: state.error);
        }
      },
    );
  }

  @override
  void dispose() {
    _scrollController
      ..removeListener(_onScroll)
      ..dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_isBottom) context.read<GetCatImagesBloc>().add(GetCatImages());
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    return currentScroll >= (maxScroll * 0.9);
  }
}
