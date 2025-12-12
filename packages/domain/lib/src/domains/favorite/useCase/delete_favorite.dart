import 'package:cats_repository/cats_repository.dart';
import 'package:data/data.dart';
import 'package:domain/src/domains/favorite/domain.dart';

class DeleteFavoriteUC implements DeleteFavoriteUseCase {
  final DeleteFavoriteRepoInterface deleteFavoriteRepo;
  DeleteFavoriteUC({required this.deleteFavoriteRepo});

  factory DeleteFavoriteUC.create({required FavoriteInterface db}) {
    final deleteFavoriteRepo = DeleteFavoriteRepo(db: db);
    return DeleteFavoriteUC(deleteFavoriteRepo: deleteFavoriteRepo);
  }

  @override
  Future<bool> call(id) async => deleteFavoriteRepo.handle(id);
}
