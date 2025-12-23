import 'package:cats_repository/cats_repository.dart';
import 'package:data/data.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: GetVotesInterface)
class GetVotesRepo implements GetVotesInterface {
  final PublicApiClient publicApiClient;

  GetVotesRepo({required this.publicApiClient});

  @override
  Future<List<VotesDataEntity>> handle() async {
    final rsp = await publicApiClient.fetchVotes();

    return rsp
        .map(
          (e) => VotesDataEntity(
            id: e.id,
            imageId: e.imageId,
            subId: e.subId,
            value: e.value,
            url: e.voteImage!.url,
          ),
        )
        .toList();
  }
}
