import 'package:bloc_test/bloc_test.dart';
import 'package:domain/domain.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test_3_35_7/features/favorite/blocs/find_favorite/find_favorite_bloc.dart';

import '../mock_data.dart';

class MockFindFavoriteUC extends Mock implements FindFavoriteUseCase {}

void main() {
  group('FindFavoriteBloc', () {
    late FindFavoriteUseCase findFavoriteUC;
    late FindFavoriteBloc findFavoriteBloc;

    setUp(() {
      findFavoriteUC = MockFindFavoriteUC();
      findFavoriteBloc = FindFavoriteBloc(findFavoriteUC: findFavoriteUC);
    });

    test('initial state is correct', () {
      expect(
        findFavoriteBloc.state,
        const FindFavoriteDataState(status: FindFavoriteStatus.initial),
      );
    });

    blocTest<FindFavoriteBloc, FindFavoriteState>(
      'emits [loading, success] when find favorites is successful',
      build: () {
        when(
          () => findFavoriteUC.call(any()),
        ).thenAnswer((_) async => [Data.favorite2]);
        return findFavoriteBloc;
      },
      act: (bloc) => bloc.add(const FindFavoriteByName('breedName2')),
      expect: () => [
        const FindFavoriteDataState(status: FindFavoriteStatus.loading),
        FindFavoriteDataState(
          status: FindFavoriteStatus.success,
          favorites: [Data.favoriteCat2],
        ),
      ],
    );

    blocTest<FindFavoriteBloc, FindFavoriteState>(
      'emits [loading, failure] when find favorites is unsuccessful',
      build: () {
        when(() => findFavoriteUC.call(any())).thenThrow(Exception('Error'));
        return findFavoriteBloc;
      },
      act: (bloc) => bloc.add(const FindFavoriteByName('name')),
      expect: () => [
        const FindFavoriteDataState(status: FindFavoriteStatus.loading),
        const FindFavoriteDataState(
          status: FindFavoriteStatus.failure,
          errorMessage: 'Exception: Error',
        ),
      ],
    );
  });
}
