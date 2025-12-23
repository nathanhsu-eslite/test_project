part of 'get_votes_bloc.dart';

enum GetVotesStatus { initial, loading, success, failure, loadingMore }

sealed class GetVotesState extends Equatable {
  final List<VotesDataEntity> votes;
  final bool hasReachedMax;
  final Object? error;
  final GetVotesStatus status;

  const GetVotesState({
    this.votes = const [],
    this.hasReachedMax = false,
    this.error,
    required this.status,
  });

  GetVotesState copyWith({
    List<VotesDataEntity>? votes,
    bool? hasReachedMax,
    Object? error,
    GetVotesStatus? status,
  });

  @override
  List<Object?> get props => [votes, hasReachedMax, error, status];
}

final class GetVotesDataState extends GetVotesState {
  const GetVotesDataState({
    required super.status,
    super.votes,
    super.hasReachedMax,
    super.error,
  });

  @override
  GetVotesDataState copyWith({
    GetVotesStatus? status,
    List<VotesDataEntity>? votes,
    bool? hasReachedMax,
    Object? error,
  }) {
    return GetVotesDataState(
      status: status ?? this.status,
      votes: votes ?? this.votes,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      error: error ?? this.error,
    );
  }
}
