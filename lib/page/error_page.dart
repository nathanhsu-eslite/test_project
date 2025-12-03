import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class ErrorPage extends StatelessWidget {
  final Object? error;

  const ErrorPage({super.key, required this.error});

  @override
  Widget build(BuildContext context) {
    return Center(child: Text(errorToString(error)));
  }
}

String errorToString(Object? error) {
  String errorMessage;
  if (error is DioException) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        errorMessage = '連線逾時';
        break;
      case DioExceptionType.badResponse:
        errorMessage = 'Bad response: ${error.response?.statusCode}';
        break;
      case DioExceptionType.cancel:
        errorMessage = 'Request 取消';
        break;
      case DioExceptionType.connectionError:
        errorMessage = '連線錯誤';
        break;
      default:
        errorMessage = 'dio未知錯誤: ${error.toString()}';
        break;
    }
  } else {
    errorMessage = '''未預期的錯誤:
    ${error.toString()}''';
  }
  return errorMessage;
}
