part of 'find_favorite_bloc.dart';

enum FindFavoriteStatus { initial, loading, success, failure }

sealed class FindFavoriteState extends Equatable {
  final List<FavoriteCat> favorites;
  final FindFavoriteStatus status;
  final String? errorMessage;

  const FindFavoriteState({
    this.favorites = const [],
    required this.status,
    this.errorMessage,
  });
  copyWith();
  @override
  List<Object?> get props => [favorites, status, errorMessage];
}

final class FindFavoriteDataState extends FindFavoriteState {
  const FindFavoriteDataState({
    required super.status,
    super.favorites,
    super.errorMessage,
  });

  @override
  FindFavoriteDataState copyWith({
    FindFavoriteStatus? status,
    List<FavoriteCat>? favorites,
    String? errorMessage,
  }) {
    return FindFavoriteDataState(
      status: status ?? this.status,
      favorites: favorites ?? this.favorites,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
