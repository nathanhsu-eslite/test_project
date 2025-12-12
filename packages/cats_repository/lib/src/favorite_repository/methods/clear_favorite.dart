import 'package:data/data.dart';

import 'interface/interface.dart';

class ClearFavoriteRepo implements ClearFavoriteRepoInterface {
  final FavoriteInterface db;
  ClearFavoriteRepo({required this.db});

  @override
  Future<bool> handle() => db.clear();
}
