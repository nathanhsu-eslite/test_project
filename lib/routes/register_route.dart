import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:test_3_35_7/pages/register_page/register_page.dart';

part 'register_route.g.dart';

const registerPath = '/register';

@TypedGoRoute<RegisterRoute>(path: registerPath)
class RegisterRoute extends GoRouteData with $RegisterRoute {
  @override
  Widget build(context, state) {
    return const RegisterPage();
  }
}
