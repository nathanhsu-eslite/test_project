part of 'clear_favorite_bloc.dart';

abstract class ClearFavoriteEvent extends Equatable {
  const ClearFavoriteEvent();

  @override
  List<Object> get props => [];
}

class DoClearFavoriteEvent extends ClearFavoriteEvent {}
