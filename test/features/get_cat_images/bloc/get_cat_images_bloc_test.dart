import 'package:bloc_test/bloc_test.dart';
import 'package:cats_repository/cats_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test_3_35_7/features/get_cat_images/bloc/get_cat_images_bloc.dart';
import 'package:domain/domain.dart';
import 'package:test_3_35_7/features/get_cat_images/exception/exception.dart';
import 'package:test_3_35_7/features/get_cat_images/models/my_image.dart';

class MockGetCatsImagesUseCase extends Mock implements GetCatsImagesUseCase {}

void main() {
  group('GetCatImagesBloc', () {
    late GetCatImagesBloc getCatImagesBloc;
    late MockGetCatsImagesUseCase mockGetCatsImagesUC;

    setUp(() {
      mockGetCatsImagesUC = MockGetCatsImagesUseCase();
      getCatImagesBloc = GetCatImagesBloc(
        getCatsImagesUseCase: mockGetCatsImagesUC,
      );
    });

    test('initial state is GetCatImagesInitialState', () {
      expect(getCatImagesBloc.state.status, CatImagesStatus.initial);
    });

    group('GetCatImages', () {
      final catImagesEntity = [
        CatImageEntity(id: '1', url: 'url1', urlWidth: 100, urlHeight: 100),
        CatImageEntity(id: '2', url: 'url2', urlWidth: 200, urlHeight: 200),
      ];
      final newCatImagesEntity = [
        CatImageEntity(id: '3', url: 'url3', urlWidth: 100, urlHeight: 100),
        CatImageEntity(id: '4', url: 'url4', urlWidth: 200, urlHeight: 200),
      ];
      final myImages = [
        MyImage(id: '1', url: 'url1', width: 100, height: 100),
        MyImage(id: '2', url: 'url2', width: 200, height: 200),
      ];
      final newImages = [
        MyImage(id: '3', url: 'url3', width: 100, height: 100),
        MyImage(id: '4', url: 'url4', width: 200, height: 200),
      ];

      blocTest<GetCatImagesBloc, GetCatImagesDataState>(
        'emits [GetCatImagesLoadingState, GetCatImagesSuccessState] when GetCatImages is added and succeeds',
        setUp: () {
          when(
            () => mockGetCatsImagesUC(7),
          ).thenAnswer((_) async => catImagesEntity);
        },
        build: () => getCatImagesBloc,
        act: (bloc) => bloc.add(GetCatImages()),
        expect: () => [
          const GetCatImagesDataState(status: CatImagesStatus.loading),
          GetCatImagesDataState(
            status: CatImagesStatus.success,
            images: myImages,
            hasReachedMax: true,
          ),
        ],
      );

      blocTest<GetCatImagesBloc, GetCatImagesDataState>(
        'emits [GetCatImagesSuccessState] with hasReachedMax true when the last batch of images is fetched',
        setUp: () {
          when(
            () => mockGetCatsImagesUC(7),
          ).thenAnswer((_) async => newCatImagesEntity);
        },
        build: () => getCatImagesBloc,
        seed: () => GetCatImagesDataState(
          status: CatImagesStatus.success,
          images: myImages,
          error: null,
        ),
        act: (bloc) => bloc.add(GetCatImages()),
        expect: () => [
          GetCatImagesDataState(
            status: CatImagesStatus.loadingMore,
            images: myImages,
            error: null,
          ),
          GetCatImagesDataState(
            status: CatImagesStatus.success,
            images: [...myImages, ...newImages],
            hasReachedMax: true,
          ),
        ],
      );

      blocTest<GetCatImagesBloc, GetCatImagesDataState>(
        'emits success with hasReachedMax true when loading more returns empty',
        setUp: () {
          when(() => mockGetCatsImagesUC(7)).thenAnswer((_) async => []);
        },
        seed: () => GetCatImagesDataState(
          status: CatImagesStatus.success,
          images: myImages,
          error: null,
        ),
        build: () => getCatImagesBloc,
        act: (bloc) => bloc.add(GetCatImages()),
        expect: () => [
          GetCatImagesDataState(
            status: CatImagesStatus.loadingMore,
            images: myImages,
          ),
          GetCatImagesDataState(
            status: CatImagesStatus.success,
            images: myImages,
            hasReachedMax: true,
          ),
        ],
      );

      blocTest<GetCatImagesBloc, GetCatImagesDataState>(
        'emits failure when initial load returns empty',
        setUp: () {
          when(() => mockGetCatsImagesUC(7)).thenAnswer((_) async => []);
        },
        build: () => getCatImagesBloc,
        act: (bloc) => bloc.add(GetCatImages()),
        expect: () => [
          const GetCatImagesDataState(status: CatImagesStatus.loading),
          GetCatImagesDataState(
            status: CatImagesStatus.failure,
            error: ImagesIsEmptyBlocException(),
          ),
        ],
      );

      blocTest<GetCatImagesBloc, GetCatImagesDataState>(
        'emits [loading, success] with new images when refreshed',
        setUp: () {
          when(() => mockGetCatsImagesUC(7))
              .thenAnswer((_) async => newCatImagesEntity);
        },
        seed: () => GetCatImagesDataState(
          status: CatImagesStatus.success,
          images: myImages,
        ),
        build: () => getCatImagesBloc,
        act: (bloc) => bloc.add(CatImageRefreshed()),
        expect: () => [
          GetCatImagesDataState(
            status: CatImagesStatus.loading,
            images: myImages,
          ),
          GetCatImagesDataState(
            status: CatImagesStatus.success,
            images: newImages,
            hasReachedMax: newCatImagesEntity.length < 7,
          ),
        ],
      );
    });
  });
}
