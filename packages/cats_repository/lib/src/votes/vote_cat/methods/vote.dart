import 'package:cats_repository/src/votes/votes.dart';
import 'package:data/data.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: VoteInterface)
class VoteRepo implements VoteInterface {
  final PublicApiClient publicApiClient;

  VoteRepo({required this.publicApiClient});
  @override
  Future<VotesDataEntity> handle(String imageId, String subId) async {
    final viewModel = await publicApiClient.voteCat({
      'image_id': imageId,
      'sub_id': subId,
      'value': 1,
    });
    return VotesDataEntity(
      id: viewModel.id,
      imageId: viewModel.imageId,
      subId: viewModel.subId,
      value: viewModel.value,
      url: null,
    );
  }
}
