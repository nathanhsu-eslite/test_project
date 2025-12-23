import 'package:cats_repository/src/votes/delete_votes/methods/methods.dart';
import 'package:data/data.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockPublicApiClient extends Mock implements PublicApiClient {}

void main() {
  late PublicApiClient publicApiClient;
  late DeleteVotesRepo deleteVotesRepo;

  setUpAll(() {
    publicApiClient = MockPublicApiClient();
    deleteVotesRepo = DeleteVotesRepo(apiClient: publicApiClient);
  });

  group('DeleteVotes', () {
    test('delete returns normally when api call is successful', () async {
      when(
        () => publicApiClient.deleteVote(any()),
      ).thenAnswer((_) async => Future.value());
      await deleteVotesRepo.handle(1);
      verify(() => publicApiClient.deleteVote(any())).called(1);
    });

    test('delete throws exception when api call fails', () async {
      when(
        () => publicApiClient.deleteVote(any()),
      ).thenThrow(Exception('API Error'));
      expect(
        () async => await deleteVotesRepo.handle(1),
        throwsA(isA<Exception>()),
      );
    });
  });
}
