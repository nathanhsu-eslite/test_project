import 'package:cats_repository/cats_repository.dart';
import 'package:data/data.dart';
import 'package:data/objectbox.g.dart';
import 'package:domain/domain.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path_provider_platform_interface/path_provider_platform_interface.dart';

import '../mock_data.dart';

class MockFindFavoriteRepo extends Mock implements FindFavoriteRepoInterface {}

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
