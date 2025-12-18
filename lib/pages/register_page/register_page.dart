import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_3_35_7/features/auth/blocs/register_bloc/register_bloc.dart';
import 'package:test_3_35_7/pages/register_page/widget/register_form.dart';
import 'package:test_3_35_7/routes/home_route.dart';
import 'package:test_3_35_7/service/auth_service.dart';
import 'package:test_3_35_7/service/service_locator.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Register')),
      body: BlocProvider(
        create: (context) =>
            RegisterBloc(registerUseCase: getIt<RegisterUseCase>()),
        child: BlocListener<RegisterBloc, RegisterState>(
          listener: (context, state) {
            if (state is RegisterFailure) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Register Failed: ${state.error}'),
                  backgroundColor: Colors.red,
                ),
              );
            } else if (state is RegisterSuccess) {
              HomeRoute().go(context);
              getIt<AuthService>().login(state.user);
            }
          },
          child: const RegisterForm(),
        ),
      ),
    );
  }
}
