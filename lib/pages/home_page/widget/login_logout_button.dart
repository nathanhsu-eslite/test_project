import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:test_3_35_7/features/auth/blocs/auth/auth_bloc.dart';
import 'dart:developer' as dev;

import 'package:test_3_35_7/routes/images_route.dart';
import 'package:test_3_35_7/routes/login_route.dart';

class LogInOutButton extends StatelessWidget {
  const LogInOutButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        if (state.status == AuthStatus.authenticated) {
          return IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async {
              await GetIt.I.popScopesTill('logged-in').then((_) {
                dev.log('Logged-in scope popped');
              });

              if (!context.mounted) return;
              context.read<AuthBloc>().add(
                const AuthStatusChanged(AuthStatus.unauthenticated),
              );
              ImagesRoute().go(context);
            },
          );
        }

        return IconButton(
          icon: const Icon(Icons.login),
          onPressed: () {
            LoginRoute().push(context);
          },
        );
      },
    );
  }
}
