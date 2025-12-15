import 'package:cats_repository/cats_repository.dart';
import 'package:domain/src/domains/favorite/useCase/add_favorite.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../mock_data.dart';

class MockAddFavoriteRepoInterface extends Mock
    implements AddFavoriteRepoInterface {}

void main() {
  group('AddFavoriteUC', () {
    late AddFavoriteRepoInterface mockAddFavoriteRepoInterface;
    late AddFavoriteUC addFavoriteUC;

    setUp(() {
      mockAddFavoriteRepoInterface = MockAddFavoriteRepoInterface();
      addFavoriteUC = AddFavoriteUC(
        addFavoriteRepo: mockAddFavoriteRepoInterface,
      );
    });

    test('favorite added should successfully', () async {
      // arrange
      when(
        () => mockAddFavoriteRepoInterface.handle(Data.mockFavorite),
      ).thenAnswer((_) async => Future.value());
      // act
      final result = await addFavoriteUC.call(Data.mockFavorite);
      expect(() => result, isA<void>());
      verify(
        () => mockAddFavoriteRepoInterface.handle(Data.mockFavorite),
      ).called(1);
    });

    test(
      'should throw an exception when underlying handle throws an exception',
      () async {
        // arrange
        when(
          () => mockAddFavoriteRepoInterface.handle(Data.mockFavorite),
        ).thenThrow(Exception('repo error'));
        // act
        final call = addFavoriteUC.call(Data.mockFavorite);
        // assert
        expect(() => call, throwsA(isA<Exception>()));
        verify(
          () => mockAddFavoriteRepoInterface.handle(Data.mockFavorite),
        ).called(1);
      },
    );
  });
}
