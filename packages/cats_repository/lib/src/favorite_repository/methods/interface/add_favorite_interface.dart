import 'package:data/data.dart';

abstract interface class AddFavoriteRepoInterface {
  Future<void> handle(Favorite favorite);
}
