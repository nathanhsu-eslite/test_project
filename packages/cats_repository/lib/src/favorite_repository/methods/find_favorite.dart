import 'package:data/data.dart';

import 'interface/interface.dart';

class FindFavoriteRepo implements FindFavoriteRepoInterface {
  final FavoriteInterface db;
  FindFavoriteRepo({required this.db});

  @override
  Future<List<Favorite>> handle(breedName) async => db.find(breedName);
}
