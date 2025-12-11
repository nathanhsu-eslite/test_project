import 'dart:io';

import 'package:data/objectbox.g.dart';
import 'package:data/src/db/favorite/favorite_cat_src.dart';
import 'package:data/src/db/favorite/schema/schema.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path_provider_platform_interface/path_provider_platform_interface.dart';

class MockPathProviderPlatform extends PathProviderPlatform {
  @override
  Future<String?> getApplicationDocumentsPath() async {
    return Directory.systemTemp.path;
  }
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  PathProviderPlatform.instance = MockPathProviderPlatform();

  late final Box<Favorite> box;
  late final FavoriteCatDB favoriteCat;
  late final Store store;

  setUpAll(() async {
    final path = await getApplicationDocumentsDirectory();
    store = await openStore(directory: path.path);
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
    test('add and query', () async {
      box.put(_Data.mockFavorite);

      final favorites = await favoriteCat.query();
      expect(favorites, hasLength(1));
      expect(favorites.first.imageId, '1');
      expect(favorites.first.breedName, 'Siamese');
    });

    test('find', () async {
      box.put(_Data.mockFavorite);
      box.put(_Data.mockFavorite2);
      final found = await favoriteCat.find('Siamese');
      expect(found, hasLength(1));
      expect(found.first.imageId, '1');
    });

    test('delete', () async {
      box.put(_Data.mockFavorite);

      var favorites = await favoriteCat.query();
      expect(favorites, hasLength(1));
      final favoriteId = favorites.first.id;

      final success = await favoriteCat.delete(favoriteId);
      expect(success, isTrue);

      favorites = await favoriteCat.query();
      expect(favorites, isEmpty);
    });

    test('clear', () async {
      box.put(_Data.mockFavorite);
      box.put(_Data.mockFavorite2);

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
  static Favorite mockFavorite = Favorite(
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
    breedName: 'Siamese2',
  );
}
