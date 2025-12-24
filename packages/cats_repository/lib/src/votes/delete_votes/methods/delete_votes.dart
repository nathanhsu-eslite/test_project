import 'package:cats_repository/src/votes/delete_votes/methods/delete_votes_interface.dart';
import 'package:data/data.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: DeleteVotesInterface)
class DeleteVotesRepo implements DeleteVotesInterface {
  final PublicApiClient apiClient;

  DeleteVotesRepo({required this.apiClient});
  @override
  Future<void> handle(int id) async => await apiClient.deleteVote(id);
}
