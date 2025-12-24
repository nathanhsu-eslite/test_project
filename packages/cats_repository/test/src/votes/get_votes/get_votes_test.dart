import 'package:cats_repository/cats_repository.dart';
import 'package:data/data.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockPublicApiClient extends Mock implements PublicApiClient {}

void main() {
  late PublicApiClient publicApiClient;
  late GetVotesRepo getVotesRepo;

  setUpAll(() {
    publicApiClient = MockPublicApiClient();
    getVotesRepo = GetVotesRepo(publicApiClient: publicApiClient);
  });

  group('GetVotes', () {
    test(
      'get votes returns List<VotesDataEntity> when api call is successful',
      () async {
        when(
          () => publicApiClient.fetchVotes(),
        ).thenAnswer((_) async => _Data.votesModels);
        final result = await getVotesRepo.handle();
        expect(result, isA<List<VotesDataEntity>>());
        expect(result.length, equals(1));
        expect(result, equals(_Data.votesDataEntity));
      },
    );

    test('get votes throws exception when api call fails', () async {
      when(
        () => publicApiClient.fetchVotes(),
      ).thenThrow(Exception('API Error'));
      expect(
        () async => await getVotesRepo.handle(),
        throwsA(isA<Exception>()),
      );
    });
  });
}

class _Data {
  static List<VoteModel> votesModels = [
    VoteModel(
      id: 1,
      imageId: 'imageId',
      subId: 'subId',
      value: 1,
      voteImage: ImageModel(url: 'url', id: 'imageId'),
      createdAt: '',
      countryCode: '',
    ),
  ];

  static List<VotesDataEntity> votesDataEntity = [
    VotesDataEntity(
      id: 1,
      imageId: 'imageId',
      subId: 'subId',
      value: 1,
      url: 'url',
    ),
  ];
}
