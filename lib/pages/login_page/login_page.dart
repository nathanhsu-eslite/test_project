import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_3_35_7/features/auth/blocs/login_bloc/login_bloc.dart';
import 'package:test_3_35_7/pages/login_page/widget/login_form.dart';
import 'package:test_3_35_7/routes/home_route.dart';
import 'package:test_3_35_7/service/auth_service.dart';
import 'package:test_3_35_7/service/service_locator.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: BlocListener<LoginBloc, LoginState>(
        listener: (context, state) {
          if (state is LoginFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Login Failed: ${state.error}'),
                backgroundColor: Colors.red,
              ),
            );
          } else if (state is LoginSuccess) {
            HomeRoute().go(context);
            getIt<AuthService>().login();
          }
        },
        child: const LoginForm(),
      ),
    );
  }
}