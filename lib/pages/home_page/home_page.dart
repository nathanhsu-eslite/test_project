import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:test_3_35_7/features/auth/blocs/auth/auth_bloc.dart';
import 'package:test_3_35_7/pages/home_page/widget/login_logout_button.dart';
import 'package:test_3_35_7/routes/favorite_route.dart';

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
        actions: [LogInOutButton()],
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
