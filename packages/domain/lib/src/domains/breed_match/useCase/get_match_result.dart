import 'package:cats_repository/cats_repository.dart';
import 'package:data/data.dart';
import 'package:dio/dio.dart';
import 'package:domain/src/domains/breed_match/breed_match.dart';

class GetMatchResultUC implements GetMatchResultUseCase {
  final CalculateBreedMatchRepo calculateBreedMatchRepo;
  GetMatchResultUC({required this.calculateBreedMatchRepo});

  factory GetMatchResultUC.dio({required Dio dio}) {
    final api = PublicApiClient(dio);
    return GetMatchResultUC(
      calculateBreedMatchRepo: CalculateBreedMatchRepo(apiClient: api),
    );
  }
  @override
  Future<List<BreedMatchResult>> call({
    required UserPreference pref,
    required int limit,
  }) async => calculateBreedMatchRepo.get(pref, limit);
}
