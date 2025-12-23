import 'package:cats_repository/cats_repository.dart';
import 'package:domain/src/domains/votes/domain.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: DeleteVotesUseCase)
class DeleteVotesUC implements DeleteVotesUseCase {
  final DeleteVotesInterface repo;

  DeleteVotesUC({required this.repo});

  @override
  Future<void> call(int id) {
    return repo.handle(id);
  }
}
