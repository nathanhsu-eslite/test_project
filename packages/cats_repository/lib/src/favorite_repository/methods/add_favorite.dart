import 'package:cats_repository/src/favorite_repository/methods/interface/add_favorite_interface.dart';
import 'package:data/data.dart';

class AddFavoriteRepo implements AddFavoriteRepoInterface {
  final FavoriteInterface db;

  AddFavoriteRepo({required this.db});

  @override
  Future<void> handle(Favorite favorite) async {
    await db.add(favorite);
  }
}
