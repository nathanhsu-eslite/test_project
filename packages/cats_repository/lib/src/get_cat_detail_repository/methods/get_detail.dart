import 'package:cats_repository/cats_repository.dart';
import 'package:public_api/public_api.dart';

class GetCatDetailRepo implements GetDetailInterface {
  final CatApiClient _catApiClient;

  GetCatDetailRepo({required CatApiClient catApiClient})
    : _catApiClient = catApiClient;

  @override
  Future<CatDetailEntity> get(String id) async {
    try {
      final breedModel = await _catApiClient.fetchCatData(id);
      if (breedModel == null) {
        throw Exception("No breed information available for cat id: $id");
      }
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
