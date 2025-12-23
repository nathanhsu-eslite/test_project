import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test_3_35_7/features/votes/blocs/delete_vote/delete_votes_bloc.dart';
import 'package:domain/domain.dart';

class MockDeleteVotesUseCase extends Mock implements DeleteVotesUseCase {}

void main() {
  group('DeleteVotesBloc', () {
    late DeleteVotesUseCase deleteVotesUseCase;

    setUp(() {
      deleteVotesUseCase = MockDeleteVotesUseCase();
    });

    DeleteVotesBloc buildBloc() {
      return DeleteVotesBloc(deleteVotesUseCase: deleteVotesUseCase);
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
          when(() => deleteVotesUseCase(1)).thenAnswer((_) async {});
        },
        build: buildBloc,
        act: (bloc) => bloc.add(const DeleteVote(1)),
        expect: () => <DeleteVotesState>[
          DeleteVotesLoading(),
          DeleteVotesSuccess(),
        ],
      );

      blocTest<DeleteVotesBloc, DeleteVotesState>(
        'emits [DeleteVotesLoading, DeleteVotesError] when delete vote fails',
        setUp: () {
          when(
            () => deleteVotesUseCase(1),
          ).thenAnswer((_) async => throw Exception());
        },
        build: buildBloc,
        act: (bloc) => bloc.add(const DeleteVote(1)),
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
