import 'package:bloc_test/bloc_test.dart';
import 'package:cats_repository/cats_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test_3_35_7/features/get_cat_detail/bloc/get_cat_detail_bloc.dart';
import 'package:domain/domain.dart';
import 'package:test_3_35_7/features/get_cat_detail/models/cat.dart';

class MockGetCatDetailUC extends Mock implements GetCatDetailUC {}

void main() {
  group('GetCatDetailBloc', () {
    late GetCatDetailBloc getCatDetailBloc;
    late MockGetCatDetailUC mockGetCatDetailUC;

    setUp(() {
      mockGetCatDetailUC = MockGetCatDetailUC();
      getCatDetailBloc = GetCatDetailBloc(mockGetCatDetailUC);
    });

    test('initial state is GetCatDetailInitialState', () {
      expect(getCatDetailBloc.state, GetCatDetailInitialState());
    });

    group('GetCatDetail', () {
      final catDetailEntity = CatDetailEntity(
        breedName: 'Abyssinian',
        temperament: 'Active, Energetic, Independent, Intelligent, Gentle',
        origin: 'Egypt',
        description:
            'The Abyssinian is easy to care for, and a joy to have in your home. They’re affectionate cats and love both people and other animals.',
      );

      final cat = Cat(
        breedName: 'Abyssinian',
        temperament: 'Active, Energetic, Independent, Intelligent, Gentle',
        origin: 'Egypt',
        description:
            'The Abyssinian is easy to care for, and a joy to have in your home. They’re affectionate cats and love both people and other animals.',
      );

      blocTest<GetCatDetailBloc, GetCatDetailState>(
        'emits [GetCatDetailLoadingState, CatGetDetailSuccessState] when GetCatDetail is added and succeeds',
        setUp: () {
          when(
            () => mockGetCatDetailUC.call('id'),
          ).thenAnswer((_) async => catDetailEntity);
        },
        build: () => getCatDetailBloc,
        act: (bloc) => bloc.add(GetCatDetail('id')),
        expect: () => [
          GetCatDetailLoadingState(),
          CatGetDetailSuccessState(cat),
        ],
      );

      blocTest<GetCatDetailBloc, GetCatDetailState>(
        'emits [GetCatDetailLoadingState, CatGetDetailFailureState] when GetCatDetail is added and fails',
        setUp: () {
          when(
            () => mockGetCatDetailUC.call('id'),
          ).thenThrow(Exception('Failed to fetch cat detail'));
        },
        build: () => getCatDetailBloc,

        act: (bloc) => bloc.add(GetCatDetail('id')),
        expect: () => [
          GetCatDetailLoadingState(),
          CatGetDetailFailureState(
            'Get cat detail failed : Exception: Failed to fetch cat detail',
          ),
        ],
      );
    });
  });
}
