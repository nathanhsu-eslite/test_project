part of 'add_favorite_bloc.dart';

abstract class AddFavoriteState extends Equatable {
  const AddFavoriteState();

  @override
  List<Object> get props => [];
}

class AddFavoriteInitial extends AddFavoriteState {}

class AddFavoriteLoading extends AddFavoriteState {}

class AddFavoriteSuccess extends AddFavoriteState {}

class AddFavoriteFailure extends AddFavoriteState {
  final String message;

  const AddFavoriteFailure(this.message);

  @override
  List<Object> get props => [message];
}
