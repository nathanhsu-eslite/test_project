import 'package:cats_repository/cats_repository.dart';
import 'package:domain/src/domains/cat/domain.dart';

class GetCatDetail implements GetCatsDetailUseCase {
  final GetDetail getDetail;
  GetCatDetail({required this.getDetail});

  Future<CatDetailEntity> fetchCatDetail(String id) async =>
      await getDetail.fetchCatDetail(id);

  @override
  Future<CatDetailEntity> call(String id) async =>
      await getDetail.fetchCatDetail(id);
}
