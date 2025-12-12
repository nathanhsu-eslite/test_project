import 'package:bloc_test/bloc_test.dart';
import 'package:domain/domain.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test_3_35_7/features/favorite/blocs/get_all_favorite/get_all_favorite_bloc.dart';

import '../mock_data.dart';

class MockGetFavoriteUC extends Mock implements GetAllFavoriteUseCase {}

void main() {
  group('GetAllFavoriteBloc', () {
    late GetAllFavoriteUseCase getFavoriteUC;
    late GetAllFavoriteBloc getAllFavoriteBloc;

    setUp(() {
      getFavoriteUC = MockGetFavoriteUC();
      getAllFavoriteBloc = GetAllFavoriteBloc(getFavoriteUC: getFavoriteUC);
    });

    test('initial state is correct', () {
      expect(
        getAllFavoriteBloc.state,
        const GetAllFavoriteDataState(status: GetAllFavoriteStatus.initial),
      );
    });

    blocTest<GetAllFavoriteBloc, GetAllFavoriteState>(
      'emits [loading, success] when get favorites is successful',
      build: () {
        when(
          () => getFavoriteUC.call(),
        ).thenAnswer((_) async => [Data.favorite1, Data.favorite2]);
        return getAllFavoriteBloc;
      },
      act: (bloc) => bloc.add(DoGetAllFavoriteEvent()),
      expect: () => [
        const GetAllFavoriteDataState(status: GetAllFavoriteStatus.loading),
        GetAllFavoriteDataState(
          status: GetAllFavoriteStatus.success,
          favorites: [Data.favoriteCat1, Data.favoriteCat2],
        ),
      ],
    );

    blocTest<GetAllFavoriteBloc, GetAllFavoriteState>(
      'emits [loading, failure] when get favorites is unsuccessful',
      build: () {
        when(() => getFavoriteUC.call()).thenThrow(Exception('Error'));
        return getAllFavoriteBloc;
      },
      act: (bloc) => bloc.add(DoGetAllFavoriteEvent()),
      expect: () => [
        const GetAllFavoriteDataState(status: GetAllFavoriteStatus.loading),
        const GetAllFavoriteDataState(
          status: GetAllFavoriteStatus.failure,
          errorMessage: 'Exception: Error',
        ),
      ],
    );
  });
}
