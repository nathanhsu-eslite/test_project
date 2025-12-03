import 'package:public_api/public_api.dart';

class GetImages {
  final CatApiClient _catApiClient;

  GetImages({required CatApiClient catApiClient})
    : _catApiClient = catApiClient;

  Future<List<ImageModel>> fetchCatsImages(int limit) async => _catApiClient
      .fetchCatsImages(limit)
      .then((catList) {
        List<ImageModel> cats = [];
        for (int i = 0; i < catList.length; i++) {
          cats.add(catList[i]);
        }
        return cats;
      })
      .catchError((error) {
        throw Exception("Failed to fetch cat images: $error");
      });
}
