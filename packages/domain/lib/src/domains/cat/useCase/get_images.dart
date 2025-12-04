import 'package:cats_repository/cats_repository.dart';
import 'package:domain/src/domains/cat/domain.dart';

class GetCatsImages implements GetCatsImagesUseCase {
  final GetImages getImages;
  GetCatsImages({required this.getImages});

  @override
  Future<List<CatImageEntity>> call(int limit) async =>
      getImages.fetchCatsImages(limit);
}
