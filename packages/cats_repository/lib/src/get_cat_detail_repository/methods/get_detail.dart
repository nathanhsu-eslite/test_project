import 'package:public_api/public_api.dart';

class GetDetail {
  final CatApiClient _catApiClient;

  GetDetail({required CatApiClient catApiClient})
    : _catApiClient = catApiClient;

  Future<BreedModel?> fetchCatDetail(String id) async {
    try {
      final data = await _catApiClient.fetchCatData(id);
      if (data == null) {
        throw Exception("No breed information available for cat id: $id");
      }
      return data;
    } on Exception catch (_) {
      rethrow;
    }
  }
}
