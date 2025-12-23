import 'package:cats_repository/cats_repository.dart';
import 'package:domain/src/domains/votes/domain.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: GetVotesUseCase)
class GetVotesUC implements GetVotesUseCase {
  final GetVotesInterface repo;

  GetVotesUC({required this.repo});

  @override
  Future<List<VotesDataEntity>> call() {
    return repo.handle();
  }
}
