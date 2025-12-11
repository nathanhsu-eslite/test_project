import 'package:cats_repository/cats_repository.dart';
import 'package:data/data.dart';
import 'package:domain/src/domains/favorite/domain.dart';

class FindFavoriteUC implements FindFavoriteUseCase {
  final FindFavoriteRepoInterface findFavoriteRepo;
  FindFavoriteUC({required this.findFavoriteRepo});

  factory FindFavoriteUC.create({required FavoriteInterface db}) {
    final findFavoriteRepo = FindFavoriteRepo(db: db);
    return FindFavoriteUC(findFavoriteRepo: findFavoriteRepo);
  }

  @override
  Future<List<Favorite>> call(breedName) async =>
      findFavoriteRepo.handle(breedName);
}
