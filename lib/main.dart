import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:test_3_35_7/cat.dart';
import 'dart:developer' as dev;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final dio = Dio();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  Future<CatImage> getHttp() async {
    final response = await dio.get(
      'https://api.thecatapi.com/v1/images/search',
    );

    final data = response.data[0];
    return CatImage.fromJson(data as Map<String, dynamic>);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: FutureBuilder<CatImage>(
          future: getHttp(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasError) {
              dev.log(snapshot.error.toString());
              return ErrorPage();
            }

            switch (snapshot.connectionState) {
              case ConnectionState.none:
              case ConnectionState.waiting:
              case ConnectionState.active:
                return CircularProgressIndicator();

              case ConnectionState.done:
                final CatImage image = snapshot.data;
                return Center(
                  child: Image.network(
                    image.url,
                    width: image.width.toDouble(),
                    height: image.height.toDouble(),
                  ),
                );
            }
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // 點擊按鈕重新抓圖
          setState(() {
            getHttp();
          });
        },
      ),
    );
  }
}

class ErrorPage extends StatelessWidget {
  const ErrorPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: Text('error page')));
  }
}