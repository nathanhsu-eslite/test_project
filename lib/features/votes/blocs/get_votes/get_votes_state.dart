part of 'get_votes_bloc.dart';

enum GetVotesStatus { initial, loading, success, failure }

class GetVotesDataState extends Equatable {
  final Map<String, List<VotesDataEntity>> groupedVotes;
  final Object? error;
  final GetVotesStatus status;

  const GetVotesDataState({
    this.groupedVotes = const {},
    this.error,
    required this.status,
  });

  GetVotesDataState copyWith({
    Map<String, List<VotesDataEntity>>? groupedVotes,
    Object? error,
    GetVotesStatus? status,
  }) {
    return GetVotesDataState(
      groupedVotes: groupedVotes ?? this.groupedVotes,
      error: error ?? this.error,
      status: status ?? this.status,
    );
  }

  @override
  List<Object?> get props => [groupedVotes, error, status];
}
