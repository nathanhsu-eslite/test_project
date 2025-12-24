import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_3_35_7/features/get_cat_images/bloc/get_cat_images_bloc.dart';

import 'package:test_3_35_7/pages/error_page/error_page.dart';
import 'package:test_3_35_7/pages/home_page/widget/images_list.dart';
import 'package:test_3_35_7/routes/app_routes.dart'; // Import authNotifier
import 'package:test_3_35_7/routes/favorite_route.dart';
import 'package:test_3_35_7/routes/home_route.dart';
import 'package:test_3_35_7/routes/login_route.dart';

import 'package:data/data.dart';
import 'package:test_3_35_7/routes/vote_route.dart';
import 'package:test_3_35_7/routes/voted_cats_route.dart';
import 'package:test_3_35_7/service/service_locator.dart';
import 'dart:developer' as dev;

class MyHomePage extends StatelessWidget {
  final UserEntity? user;
  const MyHomePage({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<GetCatImagesBloc>()..add(GetCatImages()),
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              FavoriteRoute().push(context);
            },
            icon: const Icon(Icons.favorite_sharp),
          ),
          actions: [
            IconButton(
              onPressed: () {
                const VotedCatsRoute().push(context);
              },
              icon: const Icon(Icons.show_chart),
            ),
            IconButton(
              onPressed: () {
                VoteRoute(user).push(context);
              },
              icon: const Icon(Icons.how_to_vote),
            ),
            user != null
                ? IconButton(
                    icon: const Icon(Icons.logout),
                    onPressed: () async {
                      await getIt.popScopesTill('logged-in').then((_) {
                        dev.log('Logged-in scope popped');
                      });
                      authNotifier.value = false;

                      if (context.mounted) HomeRoute(null).go(context);
                    },
                  )
                : IconButton(
                    icon: const Icon(Icons.login),
                    onPressed: () {
                      LoginRoute().push(context);
                    },
                  ),
          ],
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(width: 8),
              Text(
                user != null
                    ? '(Logged in: ${user!.username})'
                    : '(Guest mode)',
                style: const TextStyle(fontSize: 12),
              ),
            ],
          ),
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
