part of 'find_favorite_bloc.dart';

abstract class FindFavoriteEvent extends Equatable {
  const FindFavoriteEvent();

  @override
  List<Object> get props => [];
}

class FindFavoriteByName extends FindFavoriteEvent {
  final String name;

  const FindFavoriteByName(this.name);

  @override
  List<Object> get props => [name];
}