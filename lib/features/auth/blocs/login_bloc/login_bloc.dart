import 'package:domain/domain.dart';
import 'package:equatable/equatable.dart';
import 'package:data/data.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:test_3_35_7/features/auth/exception/auth_bloc_exception.dart';

part 'login_event.dart';
part 'login_state.dart';

@injectable
class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final LoginUseCase _loginUseCase;

  LoginBloc({required LoginUseCase loginUseCase})
    : _loginUseCase = loginUseCase,
      super(LoginInitial()) {
    on<LoginSubmitted>(_onSubmitted);
  }

  Future<void> _onSubmitted(
    LoginSubmitted event,
    Emitter<LoginState> emit,
  ) async {
    if (event.username.trim().isEmpty || event.password.trim().isEmpty) {
      emit(LoginFailure(error: InvalidLoginInputAuthBlocException()));

      return;
    }

    emit(LoginInProgress());
    try {
      final user = await _loginUseCase.call(
        userName: event.username,
        password: event.password,
      );
      if (user != null) {
        emit(LoginSuccess(user: user));
      } else {
        emit(LoginFailure(error: WrongPasswordAuthBlocException()));
      }
    } catch (e) {
      emit(LoginFailure(error: e));
    }
  }
}
