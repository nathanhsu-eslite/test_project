import 'package:cats_repository/cats_repository.dart';
import 'package:domain/src/domains/cat/domain.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: GetCatsImagesUseCase)
class GetCatsImagesUC implements GetCatsImagesUseCase {
  final GetImagesInterface getImages;
  GetCatsImagesUC({required this.getImages});

  @override
  Future<List<CatImageEntity>> call(int limit) async => getImages.get(limit);
}
