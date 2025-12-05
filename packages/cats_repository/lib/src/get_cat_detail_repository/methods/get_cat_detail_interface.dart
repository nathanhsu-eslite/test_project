import 'package:cats_repository/src/get_cat_detail_repository/entities/cat_detail_entity.dart';

abstract interface class GetDetailInterface {
  Future<CatDetailEntity> get(String id);
}
