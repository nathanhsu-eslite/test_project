import 'package:bloc_test/bloc_test.dart';
import 'package:cats_repository/cats_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test_3_35_7/features/votes/blocs/vote_cat/vote_cat_bloc.dart';
import 'package:domain/domain.dart';

class MockVoteCatUseCase extends Mock implements VoteCatUseCase {}

void main() {
  group('VoteCatBloc', () {
    late VoteCatUseCase voteCatUseCase;

    setUp(() {
      voteCatUseCase = MockVoteCatUseCase();
    });

    VoteCatBloc buildBloc() {
      return VoteCatBloc(voteCatUseCase: voteCatUseCase);
    }

    group('constructor', () {
      test('works properly', () => expect(buildBloc, returnsNormally));

      test('has correct initial state', () {
        expect(buildBloc().state, equals(VoteCatInitial()));
      });
    });

    group('VoteCat', () {
      blocTest<VoteCatBloc, VoteCatState>(
        'emits [VoteCatLoading, VoteCatSuccess] when vote cat succeeds',
        setUp: () {
          when(() => voteCatUseCase.call('imageId', 'subId')).thenAnswer(
            (_) async => VotesDataEntity(
              id: 1,
              imageId: 'imageId',
              subId: 'subId',
              value: 1,
            ),
          );
        },
        build: buildBloc,
        act: (bloc) => bloc.add(const VoteCat('imageId', 'subId')),
        expect: () => <VoteCatState>[VoteCatLoading(), VoteCatSuccess()],
      );

      blocTest<VoteCatBloc, VoteCatState>(
        'emits [VoteCatLoading, VoteCatError] when vote cat fails',
        setUp: () {
          when(
            () => voteCatUseCase('imageId', 'subId'),
          ).thenAnswer((_) async => throw Exception());
        },
        build: buildBloc,
        act: (bloc) => bloc.add(const VoteCat('imageId', 'subId')),
        expect: () => [
          VoteCatLoading(),
          isA<VoteCatError>().having(
            (p0) => p0.exception,
            'exception',
            isA<Exception>(),
          ),
        ],
      );
    });
  });
}
