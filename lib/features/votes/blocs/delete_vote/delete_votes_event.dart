part of 'delete_votes_bloc.dart';

abstract class DeleteVotesEvent extends Equatable {
  const DeleteVotesEvent();

  @override
  List<Object> get props => [];
}

class DeleteVote extends DeleteVotesEvent {
  final int id;

  const DeleteVote(this.id);

  @override
  List<Object> get props => [id];
}
