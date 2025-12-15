import 'package:cats_repository/cats_repository.dart';
import 'package:data/data.dart';
import 'package:dio/dio.dart';
import 'package:domain/src/domains/cat/domain.dart';

class GetCatDetailUC implements GetCatsDetailUseCase {
  final GetCatDetailRepo getDetailRepo;
  GetCatDetailUC({required this.getDetailRepo});

  factory GetCatDetailUC.dio({required Dio dio}) {
    final api = PublicApiClient(dio);
    return GetCatDetailUC(getDetailRepo: GetCatDetailRepo(apiClient: api));
  }

  @override
  Future<CatDetailEntity> call(String id) async => await getDetailRepo.get(id);
}
