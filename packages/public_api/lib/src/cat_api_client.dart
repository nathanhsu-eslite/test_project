import 'dart:io';

import 'package:dio/dio.dart';
import 'interceptor/interceptor.dart';
import 'models/models.dart';

class CatApiClient {
  final Dio _dio;
  static const String _baseUrl = 'https://api.thecatapi.com/v1';
  static const String _apiKey = String.fromEnvironment('API_KEY');

  CatApiClient(this._dio) {
    HttpOverrides.global = MyHttpOverrides();
    _dio.options
      ..baseUrl = _baseUrl
      ..connectTimeout = const Duration(seconds: 5)
      ..receiveTimeout = const Duration(seconds: 10)
      ..headers['x-api-key'] = _apiKey;
    _dio.interceptors.add(SimpleLogInterceptor());
  }

  Future<T> get<T>(
    String path, {
    Map<String, dynamic>? queryParameters,
    required T Function(dynamic data) parser,
  }) async {
    try {
      final response = await _dio.get(path, queryParameters: queryParameters);
      try {
        return parser(response.data);
      } catch (e) {
        rethrow;
      }
    } on DioException {
      rethrow;
    }
  }

  Future<List<CatImage>> fetchCatsImages(int limit) async {
    return await get(
      '/images/search',
      queryParameters: {"limit": limit},
      parser: (data) {
        try {
          if (data is! List || data.isEmpty) {
            throw Exception("Expected a list of cats, got: $data");
          }

          List<CatImage> catList = [];
          for (int i = 0; i < data.length; i++) {
            catList.add(CatImage.fromJson(data[i] as Map<String, dynamic>));
          }
          return catList;
        } on Exception catch (e) {
          throw Exception("Failed to parse cats: $e");
        }
      },
    );
  }

  Future<Map<String, dynamic>> fetchCatsDetail(String id) async {
    return await get(
      '/images/$id',
      queryParameters: {},
      parser: (data) {
        return {
          "cat_image": CatImage.fromJson(data as Map<String, dynamic>),
          "breeds": _extractFirstBreed(data['breeds'] as List<dynamic>),
        };
      },
    );
  }
}

List<BreedModel> _extractFirstBreed(List<dynamic> source) {
  // 取出第一個，轉成 BreedModel，再放回 List 回傳
  final firstItem = source.first as Map<String, dynamic>;
  return [BreedModel.fromJson(firstItem)];
}

@override
class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
