import 'package:cats_repository/src/favorite_repository/methods/get_all_favorite.dart';
import 'package:data/data.dart' as data;
import 'package:data/data.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockFavoriteDb extends Mock implements data.FavoriteInterface {}

void main() {
  late data.FavoriteInterface favoriteDb;
  late GetFavoriteRepo getAllFavorite;

  setUpAll(() {
    favoriteDb = MockFavoriteDb();
    getAllFavorite = GetFavoriteRepo(db: favoriteDb);
  });

  group('GetAllFavorite', () {
    final favorite = Favorite(
      imageId: '',
      url: '',
      urlHeight: 1,
      urlWidth: 1,
      breedName: '',
    );
    final favorite1 = Favorite(
      imageId: '1',
      url: '',
      urlHeight: 1,
      urlWidth: 1,
      breedName: '',
    );

    test(
      'should return a list of favorites when db.query call is successful',
      () async {
        when(
          () => favoriteDb.query(),
        ).thenAnswer((_) async => [favorite, favorite1]);

        final result = await getAllFavorite.handle();
        expect(result, isA<List<data.Favorite>>());
        expect(result[1].imageId, '1');
      },
    );

    test('should return an empty list when no favorites are found', () async {
      when(() => favoriteDb.query()).thenAnswer((_) async => []);
      final result = await getAllFavorite.handle();
      expect(result, isA<List<data.Favorite>>());
      expect(result, isEmpty);
    });
  });
}
