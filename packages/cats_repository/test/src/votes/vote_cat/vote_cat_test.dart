import 'package:cats_repository/src/votes/vote_cat/methods/methods.dart';
import 'package:data/data.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockPublicApiClient extends Mock implements PublicApiClient {}

void main() {
  late PublicApiClient publicApiClient;
  late VoteRepo voteRepo;

  setUpAll(() {
    publicApiClient = MockPublicApiClient();
    voteRepo = VoteRepo(publicApiClient: publicApiClient);
  });

  group('VoteCat', () {
    test('vote returns normally when api call is successful', () async {
      when(() => publicApiClient.voteCat(any())).thenAnswer(
        (_) async => VoteModel(
          id: 1,
          imageId: 'imageId',
          subId: 'subId',
          createdAt: 'createdAt',
          countryCode: 'countryCode',
          value: 1,
        ),
      );
      await voteRepo.handle('imageId', 'subId');
    });

    test('vote throws exception when api call fails', () async {
      when(
        () => publicApiClient.voteCat(any()),
      ).thenThrow(Exception('API Error'));
      expect(
        () async => await voteRepo.handle('imageId', 'subId'),
        throwsA(isA<Exception>()),
      );
    });
  });
}
