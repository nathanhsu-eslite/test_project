import 'package:cats_repository/cats_repository.dart';
import 'package:data/data.dart';
import 'package:data/objectbox.g.dart';
import 'package:domain/domain.dart';
import 'package:domain/src/domains/favorite/domain.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path_provider_platform_interface/path_provider_platform_interface.dart';

import '../mock_data.dart';

class MockGetFavoriteRepo extends Mock implements GetFavoriteRepoInterface {}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  PathProviderPlatform.instance = MockPathProviderPlatform();
  late GetAllFavoriteUseCase useCase;
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

  group('GetAllFavoriteUC', () {
    setUp(() {
      useCase = GetAllFavoriteUC.create(db: favoriteCat);
    });

    test('should get all favorite items', () async {
      // arrange
      box.put(Data.mockFavorite);
      box.put(Data.mockFavorite2);

      // act
      final result = await useCase.call();

      // assert
      expect(result, isA<List<Favorite>>());
      expect(result.length, 2);
      expect(result[1].breedName, "Siamese2");
    });
  });
}
