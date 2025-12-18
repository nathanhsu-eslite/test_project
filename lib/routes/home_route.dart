import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:test_3_35_7/pages/home_page/home_page.dart';

part 'home_route.g.dart';

const homePath = '/home';

@TypedGoRoute<HomeRoute>(path: homePath)
class HomeRoute extends GoRouteData with $HomeRoute {
  @override
  Widget build(context, state) {
    return MyHomePage();
  }
}
