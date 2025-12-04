import 'package:cats_repository/cats_repository.dart';
import 'package:dio/dio.dart';
import 'package:domain/src/domains/cat/domain.dart';
import 'package:public_api/public_api.dart';

class GetCatDetailUC implements GetCatsDetailUseCase {
  final GetCatDetailRepo getDetailRepo;
  GetCatDetailUC({required this.getDetailRepo});

  factory GetCatDetailUC.dio({required Dio dio}) {
    final api = CatApiClient(dio);
    return GetCatDetailUC(getDetailRepo: GetCatDetailRepo(catApiClient: api));
  }

  @override
  Future<CatDetailEntity> call(String id) async => await getDetailRepo.get(id);
}
