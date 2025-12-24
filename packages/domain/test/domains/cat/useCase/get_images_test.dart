import 'dart:convert';

import 'package:cats_repository/cats_repository.dart';
import 'package:data/data.dart';
import 'package:dio/dio.dart';
import 'package:domain/src/domains/cat/cat.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';

void main() {
  group('GetCatsImages', () {
    late GetCatsImagesUseCase getImagesUC;
    late Dio dio;
    late DioAdapter dioAdapter;

    setUp(() {
      dio = Dio(BaseOptions(baseUrl: 'https://api.thecatapi.com/v1'));
      dioAdapter = DioAdapter(dio: dio);
      getImagesUC = GetCatsImagesUC(
        getImages: GetImagesRepo(apiClient: PublicApiClient(dio)),
      );
    });

    test('should get cat images from the repository', () async {
      // arrange
      const limit = 2;
      const path = '/images/search';
      final catImagesJson = r"""[
        {"id": "1", "url": "https://1", "width": 0, "height": 0},
        {"id": "2", "url": "https://2", "width": 10, "height": 10}
      ]""";

      dioAdapter.onGet(
        path,
        (server) => server.reply(200, jsonDecode(catImagesJson)),
        queryParameters: {'limit': limit},
      );

      // act
      final result = await getImagesUC.call(limit);

      // assert
      expect(result, isA<List<CatImageEntity>>());
      expect(result.length, 2);
      expect(result[1].url, 'https://2');
    });
  });
}
