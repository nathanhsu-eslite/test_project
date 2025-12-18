import 'package:domain/domain.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_3_35_7/features/auth/exception/auth_bloc_exception.dart';

part 'register_event.dart';
part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final RegisterUseCase _registerUseCase;

  RegisterBloc({required RegisterUseCase registerUseCase})
      : _registerUseCase = registerUseCase,
        super(RegisterInitial()) {
    on<RegisterSubmitted>(_onSubmitted);
  }

  Future<void> _onSubmitted(
    RegisterSubmitted event,
    Emitter<RegisterState> emit,
  ) async {
    if (event.username.trim().isEmpty || event.password.trim().isEmpty) {
      emit(
        RegisterFailure(
          error: InvalidRegisterInputAuthBlocException(),
        ),
      );

      return;
    }

    emit(RegisterInProgress());

    try {
      await _registerUseCase(
        userName: event.username,
        password: event.password,
      );
      emit(RegisterSuccess());
    } catch (e) {
      emit(RegisterFailure(error: e));
    }
  }
}
