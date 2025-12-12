import 'package:bloc_test/bloc_test.dart';
import 'package:domain/domain.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test_3_35_7/features/favorite/blocs/clear_favorite/clear_favorite_bloc.dart';

class MockClearFavoriteUC extends Mock implements ClearFavoriteUseCase {}

void main() {
  group('ClearFavoriteBloc', () {
    late ClearFavoriteUseCase clearFavoriteUC;
    late ClearFavoriteBloc clearFavoriteBloc;

    setUp(() {
      clearFavoriteUC = MockClearFavoriteUC();
      clearFavoriteBloc = ClearFavoriteBloc(clearFavoriteUC: clearFavoriteUC);
    });

    test('initial state is correct', () {
      expect(clearFavoriteBloc.state, ClearFavoriteInitial());
    });

    blocTest<ClearFavoriteBloc, ClearFavoriteState>(
      'emits [loading, success] when clear favorites is successful',
      build: () {
        when(() => clearFavoriteUC.call()).thenAnswer((_) async => true);
        return clearFavoriteBloc;
      },
      act: (bloc) => bloc.add(DoClearFavoriteEvent()),
      expect: () => [ClearFavoriteLoading(), ClearFavoriteSuccess()],
    );

    blocTest<ClearFavoriteBloc, ClearFavoriteState>(
      'emits [loading, failure] when clear favorites returns false',
      build: () {
        when(() => clearFavoriteUC.call()).thenAnswer((_) async => false);
        return clearFavoriteBloc;
      },
      act: (bloc) => bloc.add(DoClearFavoriteEvent()),
      expect: () => [ClearFavoriteLoading(), ClearFavoriteFailure()],
    );

    blocTest<ClearFavoriteBloc, ClearFavoriteState>(
      'emits [loading, failure] when clear favorites is unsuccessful',
      build: () {
        when(() => clearFavoriteUC.call()).thenThrow(Exception('Error'));
        return clearFavoriteBloc;
      },
      act: (bloc) => bloc.add(DoClearFavoriteEvent()),
      expect: () => [ClearFavoriteLoading(), ClearFavoriteFailure()],
    );
  });
}
