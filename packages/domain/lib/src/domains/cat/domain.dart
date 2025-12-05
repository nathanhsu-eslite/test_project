import 'package:cats_repository/cats_repository.dart';

abstract class GetCatsImagesUseCase {
  Future<List<CatImageEntity>> call(int parameter);
}

abstract class GetCatsDetailUseCase {
  Future<CatDetailEntity> call(String parameter);
}
