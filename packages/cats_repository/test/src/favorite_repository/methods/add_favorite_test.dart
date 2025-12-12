import 'package:cats_repository/src/favorite_repository/methods/add_favorite.dart';
import 'package:data/data.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockFavoriteInterface extends Mock implements FavoriteInterface {}

void main() {
  group('AddFavoriteRepo', () {
    late FavoriteInterface mockFavoriteInterface;
    late AddFavoriteRepo addFavoriteRepo;

    setUp(() {
      mockFavoriteInterface = MockFavoriteInterface();
      addFavoriteRepo = AddFavoriteRepo(db: mockFavoriteInterface);
    });

    final tFavorite = Favorite(
      imageId: '1',
      url: 'test_url',
      urlHeight: 100,
      urlWidth: 100,
      breedName: 'test_breed',
    );

    test('should return true when favorite is added successfully', () async {
      // arrange
      when(
        () => mockFavoriteInterface.add(tFavorite),
      ).thenAnswer((_) async => true);
      // act
      await addFavoriteRepo.handle(tFavorite);
      // assert

      verify(() => mockFavoriteInterface.add(tFavorite)).called(1);
    });

    test(
      'should throw an exception when underlying add throws an exception',
      () async {
        // arrange
        when(
          () => mockFavoriteInterface.add(tFavorite),
        ).thenThrow(Exception('database error'));
        // act
        final call = addFavoriteRepo.handle(tFavorite);
        // assert
        expect(() => call, throwsA(isA<Exception>()));
        verify(() => mockFavoriteInterface.add(tFavorite)).called(1);
      },
    );
  });
}
