part of 'get_votes_bloc.dart';

abstract class GetVotesEvent extends Equatable {
  const GetVotesEvent();

  @override
  List<Object> get props => [];
}

class GetVotes extends GetVotesEvent {}
