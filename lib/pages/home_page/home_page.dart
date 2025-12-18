import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_3_35_7/features/get_cat_images/bloc/get_cat_images_bloc.dart';

import 'package:test_3_35_7/pages/error_page/error_page.dart';
import 'package:test_3_35_7/pages/home_page/widget/images_list.dart';
import 'package:test_3_35_7/routes/favorite_route.dart';
import 'package:test_3_35_7/routes/login_route.dart';
import 'package:test_3_35_7/routes/preference_form_route.dart';
import 'package:test_3_35_7/service/auth_service.dart';

import 'package:test_3_35_7/service/service_locator.dart';
import 'package:data/data.dart'; // Import UserEntity

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

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
              FavoriteRoute().push(context);
            },
            icon: const Icon(Icons.favorite_sharp),
          ),
          actions: [
            IconButton(
              onPressed: () {
                PreferenceRoute().push(context);
              },
              icon: const Icon(Icons.filter_list),
            ),
            StreamBuilder<UserEntity?>(
              stream: getIt<AuthService>().authStream,
              initialData: getIt<AuthService>().user,
              builder: (context, snapshot) {
                final user = snapshot.data;
                if (user != null) {
                  return IconButton(
                    icon: const Icon(Icons.logout),
                    onPressed: () {
                      getIt<AuthService>().logout();
                    },
                  );
                } else {
                  return IconButton(
                    icon: const Icon(Icons.login),
                    onPressed: () {
                      LoginRoute().push(context);
                    },
                  );
                }
              },
            ),
          ],
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: StreamBuilder<UserEntity?>(
            stream: getIt<AuthService>().authStream,
            initialData: getIt<AuthService>().user,
            builder: (context, snapshot) {
              final user = snapshot.data;
              return Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text('cats'),
                  const SizedBox(width: 8),
                  Text(
                    user != null ? '(Logged in: ${user.username})' : '(Logged out)',
                    style: const TextStyle(fontSize: 12),
                  ),
                ],
              );
            },
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
