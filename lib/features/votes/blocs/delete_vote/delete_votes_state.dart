part of 'delete_votes_bloc.dart';

abstract class DeleteVotesState extends Equatable {
  const DeleteVotesState();

  @override
  List<Object> get props => [];
}

class DeleteVotesInitial extends DeleteVotesState {}

class DeleteVotesLoading extends DeleteVotesState {}

class DeleteVotesSuccess extends DeleteVotesState {}

class DeleteVotesError extends DeleteVotesState {
  final Object exception;

  const DeleteVotesError(this.exception);

  @override
  List<Object> get props => [exception];
}
