import 'package:cats_repository/cats_repository.dart';
import 'package:dio/dio.dart';
import 'package:domain/src/domains/cat/cat.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

// Mocks
class MockGetDetailUC extends Mock implements GetCatDetailUC {}

class MockGetImagesUC extends Mock implements GetCatsImagesUC {}

class MockDio extends Mock implements Dio {}

void main() {
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
        CatImageEntity(id: '2', url: 'https://2', urlHeight: 10, urlWidth: 10),
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
}
