import 'package:equatable/equatable.dart';
import 'package:domain/domain.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

part 'delete_votes_event.dart';
part 'delete_votes_state.dart';

@injectable
class DeleteVotesBloc extends Bloc<DeleteVotesEvent, DeleteVotesState> {
  final DeleteVotesUseCase deleteVotesUseCase;

  DeleteVotesBloc({required this.deleteVotesUseCase})
    : super(DeleteVotesInitial()) {
    on<DeleteVote>((event, emit) async {
      emit(DeleteVotesLoading());
      try {
        await deleteVotesUseCase.call(event.id);
        emit(DeleteVotesSuccess());
      } catch (e) {
        emit(DeleteVotesError(e)); // Emit the exception
      }
    });
  }
}
