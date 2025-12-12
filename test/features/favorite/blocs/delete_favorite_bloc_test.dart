import 'package:bloc_test/bloc_test.dart';
import 'package:domain/domain.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test_3_35_7/features/favorite/blocs/delete_favorite/delete_favorite_bloc.dart';

class MockDeleteFavoriteUC extends Mock implements DeleteFavoriteUseCase {}

void main() {
  group('DeleteFavoriteBloc', () {
    late DeleteFavoriteUseCase deleteFavoriteUC;
    late DeleteFavoriteBloc deleteFavoriteBloc;

    setUp(() {
      deleteFavoriteUC = MockDeleteFavoriteUC();
      deleteFavoriteBloc = DeleteFavoriteBloc(
        deleteFavoriteUC: deleteFavoriteUC,
      );
    });

    test('initial state is correct', () {
      expect(deleteFavoriteBloc.state, DeleteFavoriteInitial());
    });

    blocTest<DeleteFavoriteBloc, DeleteFavoriteState>(
      'emits [loading, success] when delete favorite is successful',
      build: () {
        when(() => deleteFavoriteUC.call(any())).thenAnswer((_) async => true);
        return deleteFavoriteBloc;
      },
      act: (bloc) => bloc.add(const DeleteFavoriteById(1)),
      expect: () => [DeleteFavoriteLoading(), DeleteFavoriteSuccess()],
    );

    blocTest<DeleteFavoriteBloc, DeleteFavoriteState>(
      'emits [loading, failure] when delete favorite returns false',
      build: () {
        when(() => deleteFavoriteUC.call(any())).thenAnswer((_) async => false);
        return deleteFavoriteBloc;
      },
      act: (bloc) => bloc.add(const DeleteFavoriteById(1)),
      expect: () => [
        DeleteFavoriteLoading(),
        const DeleteFavoriteFailure('Failed to delete favorite'),
      ],
    );

    blocTest<DeleteFavoriteBloc, DeleteFavoriteState>(
      'emits [loading, failure] when delete favorite is unsuccessful',
      build: () {
        when(() => deleteFavoriteUC.call(any())).thenThrow(Exception('Error'));
        return deleteFavoriteBloc;
      },
      act: (bloc) => bloc.add(const DeleteFavoriteById(1)),
      expect: () => [
        DeleteFavoriteLoading(),
        const DeleteFavoriteFailure('Exception: Error'),
      ],
    );
  });
}
