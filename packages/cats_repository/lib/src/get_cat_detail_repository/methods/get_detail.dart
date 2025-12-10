import 'package:cats_repository/cats_repository.dart';
import 'package:data/data.dart';

class GetCatDetailRepo implements GetDetailInterface {
  final PublicApiClient _apiClient;

  GetCatDetailRepo({required PublicApiClient apiClient})
    : _apiClient = apiClient;

  @override
  Future<CatDetailEntity> get(String id) async {
    try {
      final imageModel = await _apiClient.fetchCatData(id);
      if (imageModel.breeds?.isEmpty == true) {
        throw Exception("No breed information available for cat id: $id");
      }
      final breedModel = imageModel.breeds!.first;
      return CatDetailEntity(
        breedName: breedModel.name,
        temperament: breedModel.temperament,
        origin: breedModel.origin,
        description: breedModel.description,
      );
    } on Exception catch (_) {
      rethrow;
    }
  }
}
