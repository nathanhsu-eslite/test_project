part of 'clear_favorite_bloc.dart';

sealed class ClearFavoriteState extends Equatable {
  const ClearFavoriteState();

  @override
  List<Object> get props => [];
}

class ClearFavoriteInitial extends ClearFavoriteState {}

class ClearFavoriteLoading extends ClearFavoriteState {}

class ClearFavoriteSuccess extends ClearFavoriteState {}

class ClearFavoriteFailure extends ClearFavoriteState {}
