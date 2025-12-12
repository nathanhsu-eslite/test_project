import 'package:data/data.dart';
import 'package:test_3_35_7/features/favorite/models/favorite_cat.dart';

class Data {
  static Favorite favorite1 = Favorite(
    imageId: '1',
    url: 'url1',
    urlHeight: 1,
    urlWidth: 1,
    breedName: 'breedName',
  );
  static Favorite favorite2 = Favorite(
    imageId: '2',
    url: 'url2',
    urlHeight: 2,
    urlWidth: 2,
    breedName: 'breedName2',
  );
  static FavoriteCat favoriteCat1 = FavoriteCat(
    id: 0,
    imageId: '1',
    url: 'url1',
    urlHeight: 1,
    urlWidth: 1,
    breedName: 'breedName',
  );
  static FavoriteCat favoriteCat2 = FavoriteCat(
    id: 0,
    imageId: '2',
    url: 'url2',
    urlHeight: 2,
    urlWidth: 2,
    breedName: 'breedName2',
  );
}
