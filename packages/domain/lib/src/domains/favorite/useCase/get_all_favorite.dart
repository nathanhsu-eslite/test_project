import 'package:cats_repository/cats_repository.dart';
import 'package:data/data.dart';
import 'package:domain/src/domains/favorite/domain.dart';

class GetAllFavoriteUC implements GetAllFavoriteUseCase {
  final GetFavoriteRepoInterface getFavoriteRepo;
  GetAllFavoriteUC({required this.getFavoriteRepo});

  factory GetAllFavoriteUC.create({required FavoriteInterface db}) {
    final getFavoriteRepo = GetFavoriteRepo(db: db);
    return GetAllFavoriteUC(getFavoriteRepo: getFavoriteRepo);
  }

  @override
  Future<List<Favorite>> call() async => getFavoriteRepo.handle();
}
