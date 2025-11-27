
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:test_3_35_7/cat.dart';
import 'dart:developer' as dev;

import 'package:test_3_35_7/dio_client.dart';

void main() {
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
  final DioClient _dioClient = DioClient(Dio());
  late Future<CatImage> _catImageFuture;

  @override
  void initState() {
    super.initState();
    _catImageFuture = _getCatImage();
  }

  Future<CatImage> _getCatImage() {
    return _dioClient.get(
      '/images/search',
      parser: (data) => CatImage.fromJson(data[0] as Map<String, dynamic>),
    );
  }

  void _refresh() {
    setState(() {
      _catImageFuture = _getCatImage();
    });
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
          future: _catImageFuture,
          builder: (BuildContext context, AsyncSnapshot<CatImage> snapshot) {
            if (snapshot.hasError) {
              dev.log(snapshot.error.toString(), error: snapshot.error);
              final error = snapshot.error;

              return ErrorPage(error:error);
            }

            switch (snapshot.connectionState) {
              case ConnectionState.none:
              case ConnectionState.waiting:
              case ConnectionState.active:
                return const CircularProgressIndicator();

              case ConnectionState.done:
                final CatImage? image = snapshot.data;
                if (image == null) {
                  return ErrorPage(error:Error());
                }
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
        onPressed: _refresh,
        child: const Icon(Icons.refresh),
      ),
    );
  }
}

class ErrorPage extends StatelessWidget {
  final Object? error;

  const ErrorPage({super.key, required this.error});

  @override
  Widget build(BuildContext context) {
    final String errorMessage = error?.toString() ?? 'An unknown error occurred';

    return Center(child: Text(errorMessage));
  }
}

String error(Object? error){
  String errorMessage;
  if (error is DioException) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        errorMessage = '連線逾時';
        break;
      case DioExceptionType.badResponse:
        errorMessage = 'Bad response: \${error.response?.statusCode}';
        break;
      case DioExceptionType.cancel:
        errorMessage = 'Request 取消';
        break;
      case DioExceptionType.connectionError:
        errorMessage = '連線錯誤';
        break;
      default:
        errorMessage = '未知錯誤';
        break;
    }
  } else {
    errorMessage = '未預期的錯誤';
  }
  return errorMessage;
}