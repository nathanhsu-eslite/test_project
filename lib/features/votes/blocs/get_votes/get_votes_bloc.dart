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
    Emitter<GetVotesState> emit,
  ) async {
    if (state.hasReachedMax) return;

    try {
      final isInitialLoad = state.status == GetVotesStatus.initial;
      if (isInitialLoad) {
        emit(state.copyWith(status: GetVotesStatus.loading));
      } else {
        emit(state.copyWith(status: GetVotesStatus.loadingMore));
      }

      final newVotes = await getVotesUseCase.call();

      if (newVotes.isEmpty) {
        if (isInitialLoad) {
          emit(
            state.copyWith(
              status: GetVotesStatus.failure,
              error: Exception('Votes are empty'),
            ),
          );
          return;
        } else {
          emit(
            state.copyWith(
              hasReachedMax: true,
              status: GetVotesStatus.success,
            ),
          );
          return;
        }
      }

      emit(
        state.copyWith(
          status: GetVotesStatus.success,
          votes: isInitialLoad ? newVotes : [...state.votes, ...newVotes],
          hasReachedMax: newVotes.isEmpty,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: GetVotesStatus.failure,
          error: e,
        ),
      );
    }
  }
}
