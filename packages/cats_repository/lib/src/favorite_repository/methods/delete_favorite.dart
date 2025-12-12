import 'package:data/data.dart';

import 'interface/interface.dart';

class DeleteFavoriteRepo implements DeleteFavoriteRepoInterface {
  final FavoriteInterface db;
  DeleteFavoriteRepo({required this.db});

  @override
  Future<bool> handle(id) async => db.delete(id);
}
