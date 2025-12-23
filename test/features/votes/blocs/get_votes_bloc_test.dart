import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test_3_35_7/features/votes/blocs/get_votes/get_votes_bloc.dart';
import 'package:domain/domain.dart';
import 'package:cats_repository/cats_repository.dart';

class MockGetVotesUseCase extends Mock implements GetVotesUseCase {}

void main() {
  group('GetVotesBloc', () {
    late GetVotesUseCase getVotesUseCase;
    final exception = Exception('Failed to fetch votes');
    final mockVotes = [
      const VotesDataEntity(
        id: 1,
        imageId: 'imageId',
        subId: 'subId',
        value: 1,
        url: 'url',
      ),
    ];

    setUp(() {
      getVotesUseCase = MockGetVotesUseCase();
    });

    GetVotesBloc buildBloc() {
      return GetVotesBloc(getVotesUseCase: getVotesUseCase);
    }

    group('constructor', () {
      test('works properly', () => expect(buildBloc, returnsNormally));

      test('has correct initial state', () {
        expect(
          buildBloc().state,
          const GetVotesDataState(status: GetVotesStatus.initial),
        );
      });
    });

    group('GetVotes', () {
      blocTest<GetVotesBloc, GetVotesState>(
        'emits [loading, success] when get votes succeeds',
        setUp: () {
          when(() => getVotesUseCase()).thenAnswer((_) async => mockVotes);
        },
        build: buildBloc,
        act: (bloc) => bloc.add(GetVotes()),
        expect: () => <GetVotesState>[
          const GetVotesDataState(status: GetVotesStatus.loading),
          GetVotesDataState(
            status: GetVotesStatus.success,
            votes: mockVotes,
          ),
        ],
      );

      blocTest<GetVotesBloc, GetVotesState>(
        'emits [loading, failure] when get votes fails',
        setUp: () {
          when(
            () => getVotesUseCase(),
          ).thenAnswer((_) async => throw exception);
        },
        build: buildBloc,
        act: (bloc) => bloc.add(GetVotes()),
        expect: () => <GetVotesState>[
          const GetVotesDataState(status: GetVotesStatus.loading),
          GetVotesDataState(
            status: GetVotesStatus.failure,
            error: exception,
          ),
        ],
      );
    });
  });
}
