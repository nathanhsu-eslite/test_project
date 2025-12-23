import 'package:cats_repository/cats_repository.dart';
import 'package:data/data.dart';
import 'package:dio/dio.dart';
import 'package:domain/domain.dart';
import 'package:domain/src/domains/votes/domain.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';

void main() {
  group('VoteCatUC', () {
    late VoteCatUseCase voteCatUC;
    late Dio dio;
    late DioAdapter dioAdapter;
    late PublicApiClient publicApiClient;

    const path = '/votes';
    const tImageId = 'ImageId';
    const tSubId = 'SubId';
    final tData = {'image_id': tImageId, 'sub_id': tSubId, 'value': 1};
    final tVoteResponseJson = {
      "id": 1,
      "image_id": tImageId,
      "sub_id": tSubId,
      "created_at": "2024-01-01T00:00:00.000Z",
      "value": 1,
      "country_code": "US",
    };

    setUp(() {
      dio = Dio(BaseOptions(baseUrl: 'https://api.thecatapi.com/v1'));
      dioAdapter = DioAdapter(dio: dio);
      publicApiClient = PublicApiClient(dio);
      final repo = VoteRepo(publicApiClient: publicApiClient);
      voteCatUC = VoteCatUC(repo: repo);
    });

    test('should call post on repository', () async {
      // arrange
      dioAdapter.onPost(
        path,
        (server) => server.reply(200, tVoteResponseJson),
        data: tData,
      );

      // act
      await voteCatUC.call(tImageId, tSubId);

      // assert
      // The mock adapter will throw if the request is not handled.
    });
  });
}
