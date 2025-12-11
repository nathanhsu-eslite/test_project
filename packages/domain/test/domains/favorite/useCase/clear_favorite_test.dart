import 'package:data/data.dart';
import 'package:data/objectbox.g.dart';
import 'package:domain/domain.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path_provider_platform_interface/path_provider_platform_interface.dart';

import '../mock_data.dart';

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
