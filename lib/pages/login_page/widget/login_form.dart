import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_3_35_7/features/auth/blocs/login_bloc/login_bloc.dart';
import 'package:test_3_35_7/routes/register_route.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          TextField(
            controller: _usernameController,
            decoration: const InputDecoration(labelText: 'Username'),
          ),
          TextField(
            controller: _passwordController,
            decoration: const InputDecoration(labelText: 'Password'),
            obscureText: true,
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              context.read<LoginBloc>().add(
                    LoginSubmitted(
                      username: _usernameController.text,
                      password: _passwordController.text,
                    ),
                  );
            },
            child: const Text('Login'),
          ),
          const SizedBox(height: 16),
          TextButton(
            onPressed: () {
              RegisterRoute().go(context);
            },
            child: const Text('Register'),
          ),
        ],
      ),
    );
  }
}