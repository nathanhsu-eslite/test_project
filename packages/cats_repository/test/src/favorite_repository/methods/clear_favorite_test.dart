import 'package:cats_repository/src/favorite_repository/methods/clear_favorite.dart';
import 'package:data/data.dart' as data;
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockFavoriteDb extends Mock implements data.FavoriteInterface {}

void main() {
  late data.FavoriteInterface favoriteDb;
  late ClearFavoriteRepo clearFavorite;

  setUpAll(() {
    favoriteDb = MockFavoriteDb();
    clearFavorite = ClearFavoriteRepo(db: favoriteDb);
  });
  group('ClearFavorite', () {
    test(
      'should return true when db.clear call is successful',
      () async {
        when(
          () => favoriteDb.clear(),
        ).thenAnswer((_) async => true);

        final result = await clearFavorite.handle();
        expect(result, isTrue);
      },
    );

    test('should return false when db.clear call fails', () async {
      when(
        () => favoriteDb.clear(),
      ).thenAnswer((_) async => false);
      final result = await clearFavorite.handle();
      expect(result, isFalse);
    });
  });
}
