part of 'delete_user_bloc.dart';

abstract class DeleteUserEvent extends Equatable {
  const DeleteUserEvent();

  @override
  List<Object> get props => [];
}

class DeleteUserSubmitted extends DeleteUserEvent {
  final int id;

  const DeleteUserSubmitted({required this.id});

  @override
  List<Object> get props => [id];
}
