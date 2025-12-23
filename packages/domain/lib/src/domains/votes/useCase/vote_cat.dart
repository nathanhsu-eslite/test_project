import 'package:cats_repository/cats_repository.dart';
import 'package:domain/src/domains/votes/domain.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: VoteCatUseCase)
class VoteCatUC implements VoteCatUseCase {
  final VoteInterface repo;

  VoteCatUC({required this.repo});

  @override
  Future<VotesDataEntity> call(String imageId, String subId) {
    return repo.handle(imageId, subId);
  }
}
