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

  group('ClearFavoriteUC', () {
    late ClearFavoriteUseCase useCase;

    setUp(() {
      useCase = ClearFavoriteUC.create(db: favoriteCat);
    });

    test('should clear all favorite items', () async {
      box.put(Data.mockFavorite);
      box.put(Data.mockFavorite2);

      // act
      final result = await useCase.call();

      // assert
      expect(result, isTrue);
    });
  });
}
