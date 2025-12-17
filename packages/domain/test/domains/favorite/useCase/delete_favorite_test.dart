import 'dart:io';

import 'package:data/data.dart';
import 'package:data/objectbox.g.dart';
import 'package:domain/domain.dart';
import 'package:flutter_test/flutter_test.dart';

import '../mock_data.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

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
  group('DeleteFavoriteUC', () {
    late DeleteFavoriteUseCase useCase;

    setUp(() {
      useCase = DeleteFavoriteUC.create(db: favoriteCat);
    });

    test('should delete favorite items', () async {
      final id = box.put(Data.mockFavorite);
      box.put(Data.mockFavorite2);

      final result = await useCase.call(id);
      final favorites = await favoriteCat.query();

      expect(result, isTrue);
      expect(favorites.length, 1);
      expect(favorites[0].breedName, "Siamese2");
    });
  });
}
