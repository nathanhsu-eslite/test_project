import 'package:cats_repository/cats_repository.dart';

abstract interface class GetVotesUseCase {
  Future<List<VotesDataEntity>> call();
}

abstract interface class DeleteVotesUseCase {
  Future<void> call(int id);
}
