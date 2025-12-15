import 'package:data/data.dart';

import 'interface/get_all_favorite_interface.dart';

class GetFavoriteRepo implements GetFavoriteRepoInterface {
  final FavoriteInterface db;
  GetFavoriteRepo({required this.db});

  @override
  Future<List<Favorite>> handle() async => db.query();
}
