import 'package:cats_repository/cats_repository.dart';
import 'package:cats_repository/src/get_images_repository/methods/get_images_interface.dart';
import 'package:public_api/public_api.dart';

class GetImagesRepo implements GetImagesInterface {
  final CatApiClient _catApiClient;

  GetImagesRepo({required CatApiClient catApiClient})
    : _catApiClient = catApiClient;

  @override
  Future<List<CatImageEntity>> get(int limit) => _catApiClient
      .fetchCatsImages(limit)
      .then((catList) {
        List<CatImageEntity> cats = [];
        if (catList.isEmpty) {
          throw Exception("No cat images found");
        }
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
