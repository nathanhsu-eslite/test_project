import 'package:data/objectbox.g.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:test_3_35_7/routes/app_routes.dart';
import 'package:test_3_35_7/routes/home_route.dart';

import 'package:test_3_35_7/service/service_locator.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final store = await openStore();
  setupLocator(store: store);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),

      routerConfig: GoRouter(
        routes: routes,
        initialLocation: HomeRoute().location,
      ),
    );
  }
}
