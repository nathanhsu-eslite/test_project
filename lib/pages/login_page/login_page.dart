import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:test_3_35_7/features/auth/blocs/login_bloc/login_bloc.dart';
import 'package:test_3_35_7/pages/login_page/widget/login_form.dart';
import 'package:test_3_35_7/routes/app_routes.dart';
import 'package:test_3_35_7/routes/images_route.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () {
            // 判斷能不能 pop，不能的話就 go 回首頁
            if (context.canPop()) {
              context.pop();
            } else {
              ImagesRoute().go(context); // 強制回到首頁
            }
          },
        ),
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
            if (context.mounted) {
              authNotifier.value = true;
              ImagesRoute().go(
                context,
              ); // Navigate to ImagesRoute without extra
            }
          }
        },
        child: const LoginForm(),
      ),
    );
  }
}
