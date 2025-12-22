part of 'delete_user_bloc.dart';

sealed class DeleteUserState extends Equatable {
  const DeleteUserState();

  @override
  List<Object> get props => [];
}

class DeleteUserInitial extends DeleteUserState {}

class DeleteUserInProgress extends DeleteUserState {}

class DeleteUserSuccess extends DeleteUserState {}

class DeleteUserFailure extends DeleteUserState {
  final Object error;

  const DeleteUserFailure({required this.error});

  @override
  List<Object> get props => [error];
}
