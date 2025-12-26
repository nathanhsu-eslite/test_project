import 'package:bloc_test/bloc_test.dart';
import 'package:cats_repository/cats_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test_3_35_7/features/votes/blocs/delete_vote/delete_votes_bloc.dart';
import 'package:domain/domain.dart';

class MockDeleteVotesUseCase extends Mock implements DeleteVotesUseCase {}

class MockGetVotesUseCase extends Mock implements GetVotesUseCase {}

void main() {
  group('DeleteVotesBloc', () {
    late DeleteVotesUseCase deleteVotesUseCase;
    late GetVotesUseCase getVotesUseCase;
    final mockVotes = [
      const VotesDataEntity(id: 1, imageId: '1', subId: 'a', value: 1),
      const VotesDataEntity(id: 2, imageId: '1', subId: 'b', value: 1),
      const VotesDataEntity(id: 3, imageId: '2', subId: 'c', value: 1),
    ];

    setUp(() {
      getVotesUseCase = MockGetVotesUseCase();
      deleteVotesUseCase = MockDeleteVotesUseCase();
      when(() => getVotesUseCase.call()).thenAnswer((_) async => mockVotes);
    });

    DeleteVotesBloc buildBloc() {
      return DeleteVotesBloc(
        deleteVotesUseCase: deleteVotesUseCase,
        getVotesUseCase: getVotesUseCase,
      );
    }

    group('constructor', () {
      test('works properly', () => expect(buildBloc, returnsNormally));

      test('has correct initial state', () {
        expect(buildBloc().state, equals(DeleteVotesInitial()));
      });
    });

    group('DeleteVote', () {
      blocTest<DeleteVotesBloc, DeleteVotesState>(
        'emits [DeleteVotesLoading, DeleteVotesSuccess] when delete vote succeeds',
        setUp: () {
          when(() => deleteVotesUseCase.call(1)).thenAnswer((_) async {});
          when(() => deleteVotesUseCase.call(2)).thenAnswer((_) async {});
        },
        build: buildBloc,
        act: (bloc) => bloc.add(const DeleteVote('1')),
        expect: () => <DeleteVotesState>[
          DeleteVotesLoading(),
          DeleteVotesSuccess(),
        ],
        verify: (_) {
          verify(() => deleteVotesUseCase.call(1)).called(1);
          verify(() => deleteVotesUseCase.call(2)).called(1);
        },
      );

      blocTest<DeleteVotesBloc, DeleteVotesState>(
        'emits [DeleteVotesLoading, DeleteVotesError] when delete vote fails',
        setUp: () {
          when(
            () => deleteVotesUseCase.call(any()),
          ).thenAnswer((_) async => throw Exception());
        },
        build: buildBloc,
        act: (bloc) => bloc.add(const DeleteVote('1')),
        expect: () => [
          DeleteVotesLoading(),
          isA<DeleteVotesError>().having(
            (state) => state.exception,
            'error',
            isA<Exception>(),
          ),
        ],
      );
    });
  });
}
