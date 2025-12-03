import 'package:cats_repository/cats_repository.dart';
import 'package:public_api/public_api.dart';

class GetImages {
  final CatApiClient _catApiClient;

  GetImages({required CatApiClient catApiClient})
    : _catApiClient = catApiClient;

  Future<List<CatImageEntity>> fetchCatsImages(int limit) async => _catApiClient
      .fetchCatsImages(limit)
      .then((catList) {
        List<CatImageEntity> cats = [];
        for (int i = 0; i < catList.length; i++) {
          final catModel = catList[i];
          cats.add(
            CatImageEntity(
              id: catModel.id,
              url: catModel.url,
              urlHeight: catModel.urlHeight,
              urlWidth: catModel.urlWidth,
            ),
          );
        }
        return cats;
      })
      .catchError((error) {
        throw Exception("Failed to fetch cat images: $error");
      });
}
