import 'package:cats_repository/cats_repository.dart';
import 'package:cats_repository/src/get_images_repository/methods/get_images_interface.dart';

import 'package:data/data.dart';

class GetImagesRepo implements GetImagesInterface {
  final PublicApiClient _apiClient;

  GetImagesRepo({required PublicApiClient apiClient}) : _apiClient = apiClient;

  @override
  Future<List<CatImageEntity>> get(int limit) => _apiClient
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
