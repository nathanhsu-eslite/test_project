import 'package:cats_repository/cats_repository.dart';
import 'package:dio/dio.dart';
import 'package:domain/src/domains/cat/domain.dart';
import 'package:public_api/public_api.dart';

class GetCatsImagesUC implements GetCatsImagesUseCase {
  final GetImagesRepo getImages;
  GetCatsImagesUC({required this.getImages});

  factory GetCatsImagesUC.dio({required Dio dio}) {
    final api = PublicApiClient(dio);
    return GetCatsImagesUC(getImages: GetImagesRepo(apiClient: api));
  }

  @override
  Future<List<CatImageEntity>> call(int limit) async => getImages.get(limit);
}
