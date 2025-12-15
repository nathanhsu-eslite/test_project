import 'package:cats_repository/src/favorite_repository/methods/delete_favorite.dart';
import 'package:data/data.dart' as data;
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockFavoriteDb extends Mock implements data.FavoriteInterface {}

void main() {
  late data.FavoriteInterface favoriteDb;
  late DeleteFavoriteRepo deleteFavorite;

  setUpAll(() {
    favoriteDb = MockFavoriteDb();
    deleteFavorite = DeleteFavoriteRepo(db: favoriteDb);
  });

  group('DeleteFavorite', () {
    const id = 1;
    test(
      'should return true when db.delete call is successful',
      () async {
        when(
          () => favoriteDb.delete(id),
        ).thenAnswer((_) async => true);

        final result = await deleteFavorite.handle(id);
        expect(result, isTrue);
      },
    );

    test('should return false when db.delete call fails', () async {
      when(
        () => favoriteDb.delete(id),
      ).thenAnswer((_) async => false);
      final result = await deleteFavorite.handle(id);
      expect(result, isFalse);
    });
  });
}
