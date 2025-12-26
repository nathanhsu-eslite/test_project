import 'package:cats_repository/cats_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:domain/domain.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

part 'get_votes_event.dart';
part 'get_votes_state.dart';

@injectable
class GetVotesBloc extends Bloc<GetVotesEvent, GetVotesDataState> {
  final GetVotesUseCase getVotesUseCase;

  GetVotesBloc({required this.getVotesUseCase})
    : super(const GetVotesDataState(status: GetVotesStatus.initial)) {
    on<GetVotes>(_onGetVotes);
  }

  Future<void> _onGetVotes(
    GetVotes event,
    Emitter<GetVotesDataState> emit,
  ) async {
    // Only emit loading state if it's the initial load
    if (state.status == GetVotesStatus.initial) {
      emit(state.copyWith(status: GetVotesStatus.loading));
    }

    try {
      final isInitialLoad = state.status == GetVotesStatus.initial;
      if (isInitialLoad) {
        emit(state.copyWith(status: GetVotesStatus.loading));
      }

      final newVotes = await getVotesUseCase.call();
      final groupedVotes = <String, List<VotesDataEntity>>{};
      for (var vote in newVotes) {
        (groupedVotes[vote.imageId] ??= []).add(vote);
      }
      emit(
        state.copyWith(
          status: GetVotesStatus.success,
          groupedVotes: groupedVotes,
        ),
      );
    } catch (e) {
      emit(state.copyWith(status: GetVotesStatus.failure, error: e));
    }
  }
}
