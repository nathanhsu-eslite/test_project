import 'package:cats_repository/src/favorite_repository/methods/find_favorite.dart';
import 'package:data/data.dart' as data;
import 'package:data/data.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockFavoriteDb extends Mock implements data.FavoriteInterface {}

void main() {
  late data.FavoriteInterface favoriteDb;
  late FindFavoriteRepo findFavorite;

  setUpAll(() {
    favoriteDb = MockFavoriteDb();
    findFavorite = FindFavoriteRepo(db: favoriteDb);
  });

  group('FindFavorite', () {
    const breedName = 'Abyssinian';
    final favorite = Favorite(
      imageId: '',
      url: '',
      urlHeight: 1,
      urlWidth: 1,
      breedName: 'Abyssinian',
    );
    test(
      'should return a list of favorites when db.find call is successful',
      () async {
        when(
          () => favoriteDb.find(breedName),
        ).thenAnswer((_) async => [favorite]);

        final result = await findFavorite.handle(breedName);
        expect(result, isA<List<data.Favorite>>());
        expect(result, equals([favorite]));
      },
    );

    test('should return an empty list when no favorites are found', () async {
      when(() => favoriteDb.find(breedName)).thenAnswer((_) async => []);
      final result = await findFavorite.handle(breedName);
      expect(result, isA<List<data.Favorite>>());
      expect(result, isEmpty);
    });
  });
}
