import 'package:cats_repository/cats_repository.dart';
import 'package:domain/src/domains/cat/useCase/get_detail.dart';
import 'package:domain/src/domains/cat/useCase/get_images.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

// Mocks
class MockGetDetail extends Mock implements GetDetail {}

class MockGetImages extends Mock implements GetImages {}

void main() {
  group('Cat Use Cases', () {
    // Mocks
    late MockGetDetail mockGetDetail;
    late MockGetImages mockGetImages;

    // Use Cases
    late GetCatDetail getCatDetailUseCase;
    late GetCatsImages getCatsImagesUseCase;

    setUp(() {
      mockGetDetail = MockGetDetail();
      mockGetImages = MockGetImages();
      getCatDetailUseCase = GetCatDetail(getDetail: mockGetDetail);
      getCatsImagesUseCase = GetCatsImages(getImages: mockGetImages);
    });

    group('GetCatDetail', () {
      test('should get cat detail from the repository', () async {
        // arrange
        const catId = '1';
        final catDetailEntity = CatDetailEntity(
          breedName: "breedName",
          temperament: "temperament",
          origin: "origin",
          description: "description",
        );
        when(
          () => mockGetDetail.fetchCatDetail(catId),
        ).thenAnswer((_) async => catDetailEntity);
        // act
        final result = await getCatDetailUseCase.call(catId);
        // assert
        expect(result, catDetailEntity);
        verify(() => mockGetDetail.fetchCatDetail(catId));
        verifyNoMoreInteractions(mockGetDetail);
      });
    });

    group('GetCatsImages', () {
      test('should get cat images from the repository', () async {
        // arrange
        const limit = 2;
        final catImageEntities = [
          CatImageEntity(id: '1', url: 'https://1', urlWidth: 0, urlHeight: 0),
          CatImageEntity(
            id: '2',
            url: 'https://2',
            urlHeight: 10,
            urlWidth: 10,
          ),
        ];
        when(
          () => mockGetImages.fetchCatsImages(limit),
        ).thenAnswer((_) async => catImageEntities);
        // act
        final result = await getCatsImagesUseCase.call(limit);
        // assert
        expect(result, catImageEntities);
        expect(result[1].url, catImageEntities[1].url);
        verify(() => mockGetImages.fetchCatsImages(limit));
        verifyNoMoreInteractions(mockGetImages);
      });
    });
  });
}
