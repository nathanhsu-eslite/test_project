import 'package:cats_repository/cats_repository.dart';
import 'package:dio/dio.dart';
import 'package:domain/src/domains/cat/useCase/get_detail.dart';
import 'package:domain/src/domains/cat/useCase/get_images.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

// Mocks
class MockGetDetailUC extends Mock implements GetCatDetailUC {}

class MockGetImagesUC extends Mock implements GetCatsImagesUC {}

class MockDio extends Mock implements Dio {}

void main() {
  group('Cat Use Cases', () {
    group('GetCatDetail', () {
      late MockGetDetailUC mockGetDetailUC;
      setUp(() {
        mockGetDetailUC = MockGetDetailUC();
      });
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
          () => mockGetDetailUC.call(catId),
        ).thenAnswer((_) async => catDetailEntity);
        // act
        final result = await mockGetDetailUC.call(catId);
        // assert
        expect(result, catDetailEntity);
        verify(() => mockGetDetailUC.call(catId));
        verifyNoMoreInteractions(mockGetDetailUC);
      });
    });

    group('GetCatsImages', () {
      late MockGetImagesUC mockGetImages;

      setUp(() {
        mockGetImages = MockGetImagesUC();
      });
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
          () => mockGetImages.call(limit),
        ).thenAnswer((_) async => catImageEntities);
        // act
        final result = await mockGetImages.call(limit);
        // assert
        expect(result, catImageEntities);
        expect(result[1].url, catImageEntities[1].url);
        verify(() => mockGetImages.call(limit));
        verifyNoMoreInteractions(mockGetImages);
      });
    });
  });
}
