part of 'delete_favorite_bloc.dart';

abstract class DeleteFavoriteState extends Equatable {
  const DeleteFavoriteState();

  @override
  List<Object> get props => [];
}

class DeleteFavoriteInitial extends DeleteFavoriteState {}

class DeleteFavoriteLoading extends DeleteFavoriteState {}

class DeleteFavoriteSuccess extends DeleteFavoriteState {}

class DeleteFavoriteFailure extends DeleteFavoriteState {
  final String message;

  const DeleteFavoriteFailure(this.message);

  @override
  List<Object> get props => [message];
}
