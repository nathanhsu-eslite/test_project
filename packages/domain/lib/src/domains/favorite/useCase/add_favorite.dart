import 'package:cats_repository/cats_repository.dart';
import 'package:data/data.dart';
import 'package:domain/src/domains/favorite/domain.dart';

class AddFavoriteUC implements AddFavoriteUseCase {
  final AddFavoriteRepoInterface addFavoriteRepo;
  AddFavoriteUC({required this.addFavoriteRepo});

  factory AddFavoriteUC.create({required FavoriteInterface db}) {
    final addFavoriteRepo = AddFavoriteRepo(db: db);
    return AddFavoriteUC(addFavoriteRepo: addFavoriteRepo);
  }

  @override
  Future<void> call(Favorite favorite) async =>
      addFavoriteRepo.handle(favorite);
}
