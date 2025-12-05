import 'package:bloc_test/bloc_test.dart';
import 'package:cats_repository/cats_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test_3_35_7/features/get_cat_images/bloc/get_cat_images_bloc.dart';
import 'package:domain/domain.dart';
import 'package:test_3_35_7/features/get_cat_images/models/my_image.dart';

class MockGetCatsImagesUC extends Mock implements GetCatsImagesUC {}

void main() {
  group('GetCatImagesBloc', () {
    late GetCatImagesBloc getCatImagesBloc;
    late MockGetCatsImagesUC mockGetCatsImagesUC;

    setUp(() {
      mockGetCatsImagesUC = MockGetCatsImagesUC();
      getCatImagesBloc = GetCatImagesBloc(getCatsImagesUC: mockGetCatsImagesUC);
    });

    test('initial state is GetCatImagesInitialState', () {
      expect(getCatImagesBloc.state, GetCatImagesInitialState());
    });

    group('GetCatImages', () {
      final catImagesEntity = [
        CatImageEntity(id: '1', url: 'url1', urlWidth: 100, urlHeight: 100),
        CatImageEntity(id: '2', url: 'url2', urlWidth: 200, urlHeight: 200),
      ];

      final myImages = [
        MyImage(id: '1', url: 'url1', width: 100, height: 100),
        MyImage(id: '2', url: 'url2', width: 200, height: 200),
      ];

      blocTest<GetCatImagesBloc, GetCatImagesState>(
        'emits [GetCatImagesLoadingState, GetCatImagesSuccessState] when GetCatImages is added and succeeds',
        setUp: () {
          when(
            () => mockGetCatsImagesUC(5),
          ).thenAnswer((_) async => catImagesEntity);
        },
        build: () => getCatImagesBloc,
        act: (bloc) => bloc.add(GetCatImages()),
        expect: () => [
          GetCatImagesLoadingState(),
          GetCatImagesSuccessState(myImages),
        ],
      );

      blocTest<GetCatImagesBloc, GetCatImagesState>(
        'emits [GetCatImagesLoadingState, GetCatImagesFailureState] when GetCatImages is added and fails',
        setUp: () {
          when(
            () => mockGetCatsImagesUC(5),
          ).thenThrow(Exception('Failed to fetch cat images'));
        },
        build: () => getCatImagesBloc,
        act: (bloc) => bloc.add(GetCatImages()),
        expect: () => [
          GetCatImagesLoadingState(),
          GetCatImagesFailureState(
            'Get cats images failed : Exception: Failed to fetch cat images',
          ),
        ],
      );
    });

    group('CatImageRefreshed', () {
      final catImagesEntity = [
        CatImageEntity(id: '3', url: 'url3', urlWidth: 300, urlHeight: 300),
      ];

      final myImages = [MyImage(id: '3', url: 'url3', width: 300, height: 300)];

      blocTest<GetCatImagesBloc, GetCatImagesState>(
        'emits [GetCatImagesLoadingState, GetCatImagesSuccessState] when CatImageRefreshed is added and succeeds',
        setUp: () {
          when(
            () => mockGetCatsImagesUC(5),
          ).thenAnswer((_) async => catImagesEntity);
        },
        build: () => getCatImagesBloc,
        act: (bloc) => bloc.add(CatImageRefreshed()),
        expect: () => [
          GetCatImagesLoadingState(),
          GetCatImagesSuccessState(myImages),
        ],
      );

      blocTest<GetCatImagesBloc, GetCatImagesState>(
        'emits [GetCatImagesLoadingState, GetCatImagesFailureState] when CatImageRefreshed is added and fails',
        setUp: () {
          when(
            () => mockGetCatsImagesUC(5),
          ).thenThrow(Exception('Failed to refresh cat images'));
        },
        build: () => getCatImagesBloc,
        act: (bloc) => bloc.add(CatImageRefreshed()),
        expect: () => [
          GetCatImagesLoadingState(),
          GetCatImagesFailureState(
            'Get cats images failed : Exception: Failed to refresh cat images',
          ),
        ],
      );
    });
  });
}
