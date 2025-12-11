import 'package:dio/dio.dart';
import 'package:public_api/src/models/models.dart';
import 'package:retrofit/retrofit.dart';

part 'public_api_client.g.dart';

@RestApi(
  baseUrl: 'https://api.thecatapi.com/v1',
  headers: {'x-api-key': String.fromEnvironment('API_KEY')},
)
abstract class PublicApiClient {
  factory PublicApiClient(Dio dio) = _PublicApiClient;

  @GET('/images/search')
  Future<List<ImageModel>> fetchCatsImages(
    @Query('limit') int limit, {
    @Query('has_breeds') bool hasBreeds = true,
  });

  @GET('/images/{id}')
  Future<ImageModel> fetchCatData(@Path('id') String id);
}
