import 'package:cats_repository/cats_repository.dart';

abstract class GetMatchResultUseCase {
  Future<List<BreedMatchResult>> call({
    required UserPreference pref,
    required int limit,
  });
}
