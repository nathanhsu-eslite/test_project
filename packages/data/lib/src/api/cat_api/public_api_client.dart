import 'package:data/src/api/cat_api/models/models.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';

part 'public_api_client.g.dart';

@lazySingleton
@RestApi(baseUrl: 'https://api.thecatapi.com/v1')
abstract class PublicApiClient {
  @factoryMethod
  factory PublicApiClient(Dio dio) = _PublicApiClient;

  @GET('/images/search')
  Future<List<ImageModel>> fetchCatsImages(
    @Query('limit') int limit, {
    @Query('has_breeds') bool hasBreeds = true,
  });

  @GET('/images/{id}')
  Future<ImageModel> fetchCatData(@Path('id') String id);

  @POST('/votes')
  Future<VoteModel> voteCat(@Body() Map<String, dynamic> body);

  @GET('/votes')
  Future<List<VoteModel>> fetchVotes();

  @DELETE('/votes/{id}')
  Future<void> deleteVote(@Path('id') int id);
}
