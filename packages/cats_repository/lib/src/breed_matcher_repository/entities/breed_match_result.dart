import 'package:data/data.dart';

class BreedMatchResult {
  final ImageModel catModel;
  final double score; // 0.0 - 100.0 (契合度百分比)

  BreedMatchResult({required this.catModel, required this.score});
}
