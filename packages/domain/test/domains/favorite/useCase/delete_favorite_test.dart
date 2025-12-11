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
