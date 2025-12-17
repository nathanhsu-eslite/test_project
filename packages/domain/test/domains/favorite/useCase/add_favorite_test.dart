import 'dart:io';

import 'package:data/data.dart';
import 'package:data/objectbox.g.dart';
import 'package:domain/src/domains/favorite/useCase/add_favorite.dart';
import 'package:flutter_test/flutter_test.dart';

import '../mock_data.dart';

void main() {
  late final Box<Favorite> box;
  late final FavoriteCatDB favoriteCat;
  late final Store store;
  late Directory testDir;

  setUpAll(() async {
    testDir = await Directory.systemTemp.createTemp('objectbox_test_');
    store = await openStore(directory: testDir.path);
    box = store.box<Favorite>();
    favoriteCat = FavoriteCatDB(store: store);
  });
  tearDown(() {
    box.removeAll();
  });
  group('AddFavoriteUC', () {
    late AddFavoriteUC addFavoriteUC;

    setUp(() {
      addFavoriteUC = AddFavoriteUC.create(db: favoriteCat);
    });

    test('favorite added should successfully', () async {
      addFavoriteUC.call(Data.mockFavorite);
      final result = await favoriteCat.query();
      expect(result, isA<List<Favorite>>());
      expect(result, isNotEmpty);
      expect(result[0].imageId, '1');
    });
  });
}
