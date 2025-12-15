import 'package:data/data.dart';

abstract interface class FindFavoriteRepoInterface {
  Future<List<Favorite>> handle(String breedName);
}
