import 'package:bloc_test/bloc_test.dart';
import 'package:cats_repository/cats_repository.dart';
import 'package:data/data.dart';
import 'package:domain/domain.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test_3_35_7/features/breeds_matcher/bloc/breeds_matcher_bloc.dart';

class MockGetMatchResultUseCase extends Mock implements GetMatchResultUseCase {}

void main() {
  group('BreedsMatcherBloc', () {
    late BreedsMatcherBloc breedsMatcherBloc;
    late GetMatchResultUseCase mockGetMatchResultUseCase;

    setUp(() {
      mockGetMatchResultUseCase = MockGetMatchResultUseCase();
      breedsMatcherBloc = BreedsMatcherBloc(
        getMatchResultUC: mockGetMatchResultUseCase,
      );
    });

    test('initial state is BreedsMatcherInitial', () {
      expect(breedsMatcherBloc.state, BreedsMatcherInitial());
    });

    group('BreedsMatcherStarted', () {
      final userPreference = UserPreference(
        desiredEnergyLevel: 3,
        desiredAffectionLevel: 3,
        desiredChildFriendly: 3,
        desiredGrooming: 3,
        desiredStrangerFriendly: 3,
        desiredDogFriendly: 3,
        desiredSocialNeeds: 3,
      );

      blocTest<BreedsMatcherBloc, BreedsMatcherState>(
        'emits [BreedsMatcherLoadInProgress, BreedsMatcherLoadSuccess] when BreedsMatcherStarted is added and succeeds',
        setUp: () {
          when(
            () =>
                mockGetMatchResultUseCase.call(pref: userPreference, limit: 15),
          ).thenAnswer((_) async => _Data.matchResults);
        },
        seed: () => BreedsMatcherLoadSuccess(matchResult: []),
        build: () => breedsMatcherBloc,
        act: (bloc) =>
            bloc.add(BreedsMatcherStarted(userPreference: userPreference)),
        expect: () => [
          BreedsMatcherLoadInProgress(),
          BreedsMatcherLoadSuccess(matchResult: _Data.matchResults),
        ],
      );
      blocTest<BreedsMatcherBloc, BreedsMatcherState>(
        'emits [BreedsMatcherInitial BreedsMatcherLoadInProgress, BreedsMatcherLoadSuccess] when BreedsMatcherStarted is added and succeeds',
        setUp: () {
          when(
            () =>
                mockGetMatchResultUseCase.call(pref: userPreference, limit: 4),
          ).thenAnswer((_) async => _Data.matchResults);
        },
        seed: () => BreedsMatcherInitial(),
        build: () => breedsMatcherBloc,
        act: (bloc) =>
            bloc.add(BreedsMatcherStarted(userPreference: userPreference)),
        expect: () => [
          BreedsMatcherLoadInProgress(),
          BreedsMatcherLoadSuccess(matchResult: _Data.matchResults),
        ],
      );
      blocTest<BreedsMatcherBloc, BreedsMatcherState>(
        'emits [BreedsMatcherLoadInProgress, BreedsMatcherLoadFailure] when BreedsMatcherStarted is added and fails',
        setUp: () {
          when(
            () =>
                mockGetMatchResultUseCase.call(pref: userPreference, limit: 4),
          ).thenThrow(Exception('Failed to fetch match result'));
        },
        build: () => breedsMatcherBloc,
        act: (bloc) =>
            bloc.add(BreedsMatcherStarted(userPreference: userPreference)),
        expect: () => [
          BreedsMatcherLoadInProgress(),
          BreedsMatcherLoadFailure(
            message: 'Exception: Failed to fetch match result',
          ),
        ],
      );
    });
  });
}

class _Data {
  static List<BreedMatchResult> matchResults = [
    BreedMatchResult(
      catModel: ImageModel(id: '1', url: 'url1', urlHeight: 1, urlWidth: 1),
      score: 75.0,
    ),
    BreedMatchResult(
      catModel: ImageModel(id: '2', url: 'url2', urlHeight: 2, urlWidth: 2),
      score: 68.75,
    ),
    BreedMatchResult(
      catModel: ImageModel(id: '3', url: 'url3', urlHeight: 3, urlWidth: 3),
      score: 62.5,
    ),
  ];
}
