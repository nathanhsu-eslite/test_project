import 'package:cats_repository/cats_repository.dart';
import 'package:data/data.dart';
import 'package:dio/dio.dart';
import 'package:domain/domain.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';

void main() {
  group('DeleteVotesUC', () {
    late DeleteVotesUseCase deleteVotesUC;
    late Dio dio;
    late DioAdapter dioAdapter;
    late PublicApiClient publicApiClient;

    const tVoteId = 1;
    const path = '/votes/$tVoteId';

    setUp(() {
      dio = Dio(BaseOptions(baseUrl: 'https://api.thecatapi.com/v1'));
      dioAdapter = DioAdapter(dio: dio);
      publicApiClient = PublicApiClient(dio);
      final repo = DeleteVotesRepo(apiClient: publicApiClient);
      deleteVotesUC = DeleteVotesUC(repo: repo);
    });

    test('should call delete on repository', () async {
      // arrange
      dioAdapter.onDelete(path, (server) => server.reply(200, {}));

      // act
      await deleteVotesUC.call(tVoteId);

      // assert
      // The mock adapter will throw if the request is not handled.
    });
  });
}
