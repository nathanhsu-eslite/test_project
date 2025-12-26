part of 'delete_votes_bloc.dart';

abstract class DeleteVotesEvent extends Equatable {
  const DeleteVotesEvent();

  @override
  List<Object> get props => [];
}

class DeleteVote extends DeleteVotesEvent {
  final String imageId;

  const DeleteVote(this.imageId);

  @override
  List<Object> get props => [imageId];
}
