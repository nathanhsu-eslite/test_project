import 'package:data/data.dart';

abstract class ClearFavoriteUseCase {
  Future<bool> call();
}

abstract class FindFavoriteUseCase {
  Future<List<Favorite>> call(String breedName);
}

abstract class DeleteFavoriteUseCase {
  Future<bool> call(int id);
}

abstract class GetAllFavoriteUseCase {
  Future<List<Favorite>> call();
}
