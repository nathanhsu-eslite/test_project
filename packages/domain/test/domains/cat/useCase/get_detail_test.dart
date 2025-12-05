import 'package:cats_repository/cats_repository.dart';
import 'package:dio/dio.dart';
import 'package:domain/domain.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockGetDetailUC extends Mock implements GetCatDetailUC {}

class MockDio extends Mock implements Dio {}

void main() {
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
}
