import 'package:data/objectbox.g.dart';
import 'package:flutter/material.dart';

import 'package:test_3_35_7/pages/home_page/home_page.dart';

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
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const MyHomePage(title: 'test'),
    );
  }
}
