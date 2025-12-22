import 'package:domain/domain.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_3_35_7/features/auth/exception/auth_bloc_exception.dart';

part 'delete_user_event.dart';
part 'delete_user_state.dart';

class DeleteUserBloc extends Bloc<DeleteUserEvent, DeleteUserState> {
  final DeleteUserUseCase _deleteUserUseCase;

  DeleteUserBloc({required DeleteUserUseCase deleteUserUseCase})
    : _deleteUserUseCase = deleteUserUseCase,
      super(DeleteUserInitial()) {
    on<DeleteUserSubmitted>(_onSubmitted);
  }

  Future<void> _onSubmitted(
    DeleteUserSubmitted event,
    Emitter<DeleteUserState> emit,
  ) async {
    emit(DeleteUserInProgress());
    try {
      await _deleteUserUseCase(id: event.id);
      emit(DeleteUserSuccess());
    } catch (_) {
      emit(DeleteUserFailure(error: DeleteUserFailAuthBlocException()));
    }
  }
}
