import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:test_3_35_7/features/auth/blocs/auth/auth_bloc.dart';
import 'package:test_3_35_7/features/auth/blocs/register_bloc/register_bloc.dart';
import 'package:test_3_35_7/pages/register_page/widget/register_form.dart';
import 'package:test_3_35_7/routes/images_route.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Register')),
      body: BlocProvider(
        create: (context) =>
            RegisterBloc(registerUseCase: GetIt.I.get<RegisterUseCase>()),
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
              context.read<AuthBloc>().add(
                const AuthStatusChanged(AuthStatus.authenticated),
              );
              ImagesRoute().go(
                context,
              ); // Navigate to ImagesRoute without extra
            }
          },
          child: const RegisterForm(),
        ),
      ),
    );
  }
}
