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

  group('FindFavoriteUC', () {
    late FindFavoriteUseCase useCase;

    setUp(() {
      useCase = FindFavoriteUC.create(db: favoriteCat);
    });

    test('should find favorite items', () async {
      box.put(Data.mockFavorite);
      box.put(Data.mockFavorite2);

      final result = await useCase.call("Siamese2");

      expect(result[0].breedName, "Siamese2");
      expect(result.length, 1);
    });
  });
}
