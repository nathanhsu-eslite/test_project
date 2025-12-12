import 'package:cats_repository/cats_repository.dart';
import 'package:data/data.dart';
import 'package:domain/src/domains/favorite/domain.dart';

class ClearFavoriteUC implements ClearFavoriteUseCase {
  final ClearFavoriteRepoInterface clearFavoriteRepo;
  ClearFavoriteUC({required this.clearFavoriteRepo});

  factory ClearFavoriteUC.create({required FavoriteInterface db}) {
    final clearFavoriteRepo = ClearFavoriteRepo(db: db);
    return ClearFavoriteUC(clearFavoriteRepo: clearFavoriteRepo);
  }

  @override
  Future<bool> call() async => clearFavoriteRepo.handle();
}
