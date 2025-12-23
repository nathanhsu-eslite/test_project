import 'dart:convert';

import 'package:cats_repository/cats_repository.dart';
import 'package:data/data.dart';
import 'package:dio/dio.dart';
import 'package:domain/domain.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';

void main() {
  group('GetVotesUC', () {
    late GetVotesUseCase getVotesUC;
    late Dio dio;
    late DioAdapter dioAdapter;
    late PublicApiClient publicApiClient;
    const path = '/votes';

    setUp(() {
      dio = Dio(BaseOptions(baseUrl: 'https://api.thecatapi.com/v1'));
      dioAdapter = DioAdapter(dio: dio);
      publicApiClient = PublicApiClient(dio);
      final repo = GetVotesRepo(publicApiClient: publicApiClient);
      getVotesUC = GetVotesUC(repo: repo);
    });

    final tVotesJson = r"""
      [
        {
          "id": 1,
          "image_id": "imageId",
          "sub_id": "subId",
          "created_at": "2024-01-01T00:00:00.000Z",
          "value": 1,
          "country_code": "US",
          "image": {
            "id": "id",
            "url": "url"
          }
        }
      ]
    """;

    test('should get votes from the repository', () async {
      // arrange
      dioAdapter.onGet(
        path,
        (server) => server.reply(200, jsonDecode(tVotesJson)),
      );

      // act
      final result = await getVotesUC.call();

      // assert
      expect(result, isA<List<VotesDataEntity>>());
      expect(result.length, 1);
      expect(result.first.id, 1);
      expect(result.first.imageId, 'imageId');
    });
  });
}
