import 'package:equatable/equatable.dart';
import 'package:domain/domain.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

part 'delete_votes_event.dart';
part 'delete_votes_state.dart';

@injectable
class DeleteVotesBloc extends Bloc<DeleteVotesEvent, DeleteVotesState> {
  final DeleteVotesUseCase deleteVotesUseCase;
  final GetVotesUseCase getVotesUseCase;

  DeleteVotesBloc({
    required this.deleteVotesUseCase,
    required this.getVotesUseCase,
  }) : super(DeleteVotesInitial()) {
    on<DeleteVote>((event, emit) async {
      emit(DeleteVotesLoading());
      try {
        final allVotes = await getVotesUseCase.call();
        // Find votes matching the imageId
        final votesToDelete = allVotes.where(
          (vote) => vote.imageId == event.imageId,
        );

        final deleteFutures = votesToDelete
            .map((vote) => deleteVotesUseCase.call(vote.id))
            .toList();

        await Future.wait(deleteFutures);
        emit(DeleteVotesSuccess());
      } catch (e) {
        emit(DeleteVotesError(e));
      }
    });
  }
}
