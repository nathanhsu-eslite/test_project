import 'package:data/data.dart';

abstract interface class GetFavoriteRepoInterface {
  Future<List<Favorite>> handle();
}
