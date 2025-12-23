import 'package:cats_repository/cats_repository.dart';

abstract interface class VoteInterface {
  Future<VotesDataEntity> handle(String imageId, String subId);
}
