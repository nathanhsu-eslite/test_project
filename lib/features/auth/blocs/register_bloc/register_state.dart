part of 'register_bloc.dart';

sealed class RegisterState extends Equatable {
  const RegisterState();

  @override
  List<Object> get props => [];
}

class RegisterInitial extends RegisterState {}

class RegisterInProgress extends RegisterState {}

class RegisterSuccess extends RegisterState {
  final UserEntity user;

  const RegisterSuccess({required this.user});

  @override
  List<Object> get props => [user];
}

class RegisterFailure extends RegisterState {
  final Object error;

  const RegisterFailure({required this.error});

  @override
  List<Object> get props => [error];
}
