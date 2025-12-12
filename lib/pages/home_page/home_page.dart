import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_3_35_7/features/get_cat_images/bloc/get_cat_images_bloc.dart';
import 'package:test_3_35_7/page/error_page.dart';
import 'package:test_3_35_7/pages/favorite_list_page/favorite_page.dart';
import 'package:test_3_35_7/pages/home_page/widget/images_list.dart';

import 'package:test_3_35_7/service/service_locator.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          GetCatImagesBloc(getCatsImagesUseCase: getIt<GetCatsImagesUC>())
            ..add(GetCatImages()),
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => FavoriteListPage()),
              );
            },
            icon: Icon(Icons.favorite_sharp),
          ),
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: Text(title),
        ),
        body: const HomeView(),
      ),
    );
  }
}

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
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
