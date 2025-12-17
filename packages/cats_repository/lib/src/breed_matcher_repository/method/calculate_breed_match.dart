import 'package:cats_repository/src/breed_matcher_repository/method/calculate_breed_match_interface.dart';
import 'package:data/data.dart';

import '../entities/entities.dart';

class CalculateBreedMatchRepo implements CalculateBreedMatchInterface {
  final PublicApiClient _apiClient;

  CalculateBreedMatchRepo({required PublicApiClient apiClient})
    : _apiClient = apiClient;

  // 執行配對
  @override
  Future<List<BreedMatchResult>> get(UserPreference pref, int limit) async {
    try {
      List<BreedMatchResult> results = [];
      final allCats = await _apiClient.fetchCatsImages(limit);

      for (var cat in allCats) {
        // 評分標準數量
        final breed = cat.breeds!.first;

        // 1. 計算各項指標的差異 (絕對值)
        final differences = [
          (breed.energyLevel - pref.desiredEnergyLevel).abs(),
          (breed.affectionLevel - pref.desiredAffectionLevel).abs(),
          (breed.childFriendly - pref.desiredChildFriendly).abs(),
          (breed.dogFriendly - pref.desiredDogFriendly).abs(),
          (breed.strangerFriendly - pref.desiredStrangerFriendly).abs(),
          (breed.socialNeeds - pref.desiredSocialNeeds).abs(),
          (breed.grooming - pref.desiredGrooming).abs(),
        ];
        int criteriaCount = differences.length;
        // 2. 轉換為分數 (滿分 100)
        double totalDiff = differences.reduce((a, b) => a + b).toDouble();
        // 假設每個屬性最大差異為 4 (5-1)，總最大差異為 4 * criteriaCount
        double maxPossibleDiff = 4.0 * criteriaCount;
        double matchPercentage = 100 - ((totalDiff / maxPossibleDiff) * 100);
        //鎖定範圍在 0-100
        matchPercentage = matchPercentage.clamp(0.0, 100.0);
        matchPercentage = double.parse(matchPercentage.toStringAsFixed(2));

        results.add(BreedMatchResult(catModel: cat, score: matchPercentage));
      }

      // 3. 排序：分數高到低
      results.sort((a, b) => b.score.compareTo(a.score));

      // 4. 只回傳前 5 名
      return results.take(7).toList();
    } on Exception catch (_) {
      rethrow;
    }
  }
}
