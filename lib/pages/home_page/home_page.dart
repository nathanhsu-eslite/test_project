import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:test_3_35_7/features/get_cat_images/bloc/get_cat_images_bloc.dart';

import 'package:test_3_35_7/routes/app_routes.dart'; // Import authNotifier
import 'package:test_3_35_7/routes/favorite_route.dart';
import 'package:test_3_35_7/routes/images_route.dart';
import 'package:test_3_35_7/routes/login_route.dart';

import 'package:test_3_35_7/service/service_locator.dart';
import 'dart:developer' as dev;

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key, required this.navigationShell});
  final StatefulNavigationShell navigationShell;

  void _goBranch(int index) => navigationShell.goBranch(
    index,
    initialLocation: index == navigationShell.currentIndex,
  );
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
            authNotifier.value
                ? IconButton(
                    icon: const Icon(Icons.logout),
                    onPressed: () async {
                      await getIt.popScopesTill('logged-in').then((_) {
                        dev.log('Logged-in scope popped');
                      });
                      authNotifier.value = false;

                      if (context.mounted) ImagesRoute().go(context);
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
                authNotifier.value ? '(Logged in)' : '(Guest mode)',
                style: const TextStyle(fontSize: 12),
              ),
            ],
          ),
        ),
        body: navigationShell,
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: navigationShell.currentIndex,
          onTap: _goBranch,
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.image), label: 'Images'),
            BottomNavigationBarItem(
              icon: Icon(Icons.room_preferences),
              label: 'Preference',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.how_to_vote),
              label: 'Vote',
            ),
          ],
        ),
      ),
    );
  }
}
