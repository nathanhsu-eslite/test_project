import 'dart:io';

import 'package:data/objectbox.g.dart';
import 'package:data/src/db/favorite/favorite_cat_src.dart';
import 'package:data/src/db/favorite/schema/schema.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  late Directory testDir;

  late final Box<Favorite> box;
  late final FavoriteCatDB favoriteCat;
  late final Store store;

  setUpAll(() async {
    testDir = await Directory.systemTemp.createTemp('objectbox_test_');
    store = await openStore(directory: testDir.path);
    box = store.box<Favorite>();
    favoriteCat = FavoriteCatDB(store: store);
  });

  tearDown(() {
    box.removeAll();
  });

  group('FavoriteCat', () {
    test('get empty data', () async {
      final rsp = await favoriteCat.query();
      expect(rsp, isEmpty);
    });

    test('add ', () async {
      await favoriteCat.add(_Data.mockFavorite1);

      final favorites = await favoriteCat.query();
      expect(favorites, hasLength(1));
      expect(favorites.first.imageId, '1');
      expect(favorites.first.breedName, 'Siamese');
    });

    test('find by exact name', () async {
      await favoriteCat.add(_Data.mockFavorite1);
      await favoriteCat.add(_Data.mockFavorite2);
      final found = await favoriteCat.find('Siamese');
      expect(found, hasLength(1));
      expect(found.first.imageId, '1');
    });

    test('find by partial name', () async {
      await favoriteCat.add(_Data.mockFavorite1);
      await favoriteCat.add(_Data.mockFavorite2);
      final found = await favoriteCat.find('Per');
      expect(found, hasLength(1));
      expect(found.first.imageId, '2');
    });

    test('delete', () async {
      await favoriteCat.add(_Data.mockFavorite1);

      var favorites = await favoriteCat.query();
      expect(favorites, hasLength(1));
      final favoriteId = favorites.first.id;

      final success = await favoriteCat.delete(favoriteId);
      expect(success, isTrue);

      favorites = await favoriteCat.query();
      expect(favorites, isEmpty);
    });

    test('clear', () async {
      await favoriteCat.add(_Data.mockFavorite1);
      await favoriteCat.add(_Data.mockFavorite2);

      var favorites = await favoriteCat.query();
      expect(favorites, hasLength(2));

      final success = await favoriteCat.clear();
      expect(success, isTrue);

      favorites = await favoriteCat.query();
      expect(favorites, isEmpty);
    });
  });
}

class _Data {
  static Favorite mockFavorite1 = Favorite(
    url: 'http://1',
    urlHeight: 100,
    urlWidth: 100,
    imageId: '1',
    breedName: 'Siamese',
  );
  static Favorite mockFavorite2 = Favorite(
    url: 'http://2',
    urlHeight: 100,
    urlWidth: 100,
    imageId: '2',
    breedName: 'Persian',
  );
}
