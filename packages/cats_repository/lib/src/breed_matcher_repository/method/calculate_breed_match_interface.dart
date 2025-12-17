import '../entities/entities.dart';

abstract interface class CalculateBreedMatchInterface {
  // 執行配對
  Future<List<BreedMatchResult>> get(UserPreference pref, int limit);
}
