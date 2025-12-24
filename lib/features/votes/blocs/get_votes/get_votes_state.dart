part of 'get_votes_bloc.dart';

enum GetVotesStatus { initial, loading, success, failure }

sealed class GetVotesState extends Equatable {
  final List<VotesDataEntity> votes;
  final Object? error;
  final GetVotesStatus status;

  const GetVotesState({
    this.votes = const [],
    this.error,
    required this.status,
  });

  GetVotesState copyWith({
    List<VotesDataEntity>? votes,
    Object? error,
    GetVotesStatus? status,
  });

  @override
  List<Object?> get props => [votes, error, status];
}

final class GetVotesDataState extends GetVotesState {
  const GetVotesDataState({required super.status, super.votes, super.error});

  @override
  GetVotesDataState copyWith({
    GetVotesStatus? status,
    List<VotesDataEntity>? votes,
    Object? error,
  }) {
    return GetVotesDataState(
      status: status ?? this.status,
      votes: votes ?? this.votes,
      error: error ?? this.error,
    );
  }
}
