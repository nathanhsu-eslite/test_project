import 'package:cats_repository/cats_repository.dart';

abstract class GetVotesInterface {
  Future<List<VotesDataEntity>> handle();
}
