import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:test_3_35_7/features/auth/blocs/auth/auth_bloc.dart';
import 'package:test_3_35_7/routes/favorite_route.dart';
import 'package:test_3_35_7/routes/images_route.dart';
import 'package:test_3_35_7/routes/login_route.dart';
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
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            FavoriteRoute().push(context);
          },
          icon: const Icon(Icons.favorite_sharp),
        ),
        actions: [
          BlocBuilder<AuthBloc, AuthState>(
            builder: (context, state) {
              if (state.status == AuthStatus.authenticated) {
                return IconButton(
                  icon: const Icon(Icons.logout),
                  onPressed: () async {
                    await GetIt.I.popScopesTill('logged-in').then((_) {
                      dev.log('Logged-in scope popped');
                    });
                    if (context.mounted) {
                      context.read<AuthBloc>().add(
                        const AuthStatusChanged(AuthStatus.unauthenticated),
                      );
                      ImagesRoute().go(context);
                    }
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
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(width: 8),
            BlocBuilder<AuthBloc, AuthState>(
              builder: (context, state) {
                return Text(
                  state.status == AuthStatus.authenticated
                      ? '(Logged in)'
                      : '(Guest mode)',
                  style: const TextStyle(fontSize: 12),
                );
              },
            ),
          ],
        ),
      ),
      body: navigationShell,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: navigationShell.currentIndex,
        onTap: _goBranch,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.image), label: 'Images'),
          BottomNavigationBarItem(
            icon: Icon(Icons.room_preferences),
            label: 'Preference',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.how_to_vote), label: 'Vote'),
        ],
      ),
    );
  }
}
