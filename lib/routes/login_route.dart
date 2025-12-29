import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:test_3_35_7/features/auth/blocs/login_bloc/login_bloc.dart';
import 'package:test_3_35_7/pages/login_page/login_page.dart';
import 'package:domain/domain.dart';

part 'login_route.g.dart';

const loginPath = '/login';

@TypedGoRoute<LoginRoute>(path: loginPath)
class LoginRoute extends GoRouteData with $LoginRoute {
  @override
  Widget build(context, state) {
    return BlocProvider(
      create: (context) => LoginBloc(loginUseCase: GetIt.I.get<LoginUseCase>()),
      child: const LoginPage(),
    );
  }
}
