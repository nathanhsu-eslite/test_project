part of 'delete_favorite_bloc.dart';

abstract class DeleteFavoriteEvent extends Equatable {
  const DeleteFavoriteEvent();

  @override
  List<Object> get props => [];
}

class DeleteFavoriteById extends DeleteFavoriteEvent {
  final int id;

  const DeleteFavoriteById(this.id);

  @override
  List<Object> get props => [id];
}
