import 'package:cats_repository/src/entities/cat_entity.dart';
import 'package:public_api/public_api.dart';

class CatsRepository {
  final CatApiClient _catApiClient;

  CatsRepository({required CatApiClient catApiClient})
    : _catApiClient = catApiClient;

  Future<List<CatModel>> fetchCatsImages(int limit) async => _catApiClient
      .fetchCatsImages(limit)
      .then((catList) {
        List<CatModel> cats = [];
        for (int i = 0; i < catList.length; i++) {
          cats.add(CatModel(catImage: catList[i], breedModel: null));
        }
        return cats;
      })
      .catchError((error) {
        throw Exception("Failed to fetch cat images: $error");
      });

  Future<CatModel> fetchCatDetail(String id) async {
    try {
      final data = await _catApiClient.fetchCatsDetail(id);
      if (data["breeds"] == null ||
          (data["breeds"] as List<BreedModel>).isEmpty) {
        throw Exception("No breed information available for cat id: $id");
      }
      return CatModel(
        catImage: data["cat_image"] as CatImage,
        breedModel: data["breeds"] as BreedModel,
      );
    } on Exception catch (_) {
      rethrow;
    }
  }
}
