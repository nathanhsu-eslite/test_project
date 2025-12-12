import 'package:domain/domain.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'delete_favorite_event.dart';
part 'delete_favorite_state.dart';

class DeleteFavoriteBloc
    extends Bloc<DeleteFavoriteEvent, DeleteFavoriteState> {
  final DeleteFavoriteUseCase _deleteFavoriteUC;

  DeleteFavoriteBloc({required DeleteFavoriteUseCase deleteFavoriteUC})
    : _deleteFavoriteUC = deleteFavoriteUC,
      super(DeleteFavoriteInitial()) {
    on<DeleteFavoriteById>(_onDeleteFavoriteById);
  }

  Future<void> _onDeleteFavoriteById(
    DeleteFavoriteById event,
    Emitter<DeleteFavoriteState> emit,
  ) async {
    emit(DeleteFavoriteLoading());
    try {
      final success = await _deleteFavoriteUC.call(event.id);
      if (success) {
        emit(DeleteFavoriteSuccess());
      } else {
        emit(const DeleteFavoriteFailure('Failed to delete favorite'));
      }
    } catch (e) {
      emit(DeleteFavoriteFailure(e.toString()));
    }
  }
}
