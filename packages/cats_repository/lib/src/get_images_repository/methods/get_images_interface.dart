import 'package:cats_repository/src/get_images_repository/entities/cat_image_entity.dart';

abstract interface class GetImagesInterface {
  Future<List<CatImageEntity>> get(int limit);
}
