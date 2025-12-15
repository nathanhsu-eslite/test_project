part of 'get_all_favorite_bloc.dart';

enum GetAllFavoriteStatus { initial, loading, success, failure }

sealed class GetAllFavoriteState extends Equatable {
  final List<FavoriteCat> favorites;
  final GetAllFavoriteStatus status;
  final String? errorMessage;

  const GetAllFavoriteState({
    this.favorites = const [],
    required this.status,
    this.errorMessage,
  });
  copyWith();
  @override
  List<Object?> get props => [favorites, status, errorMessage];
}

final class GetAllFavoriteDataState extends GetAllFavoriteState {
  const GetAllFavoriteDataState({
    required super.status,
    super.favorites,
    super.errorMessage,
  });

  @override
  GetAllFavoriteDataState copyWith({
    GetAllFavoriteStatus? status,
    List<FavoriteCat>? favorites,
    String? errorMessage,
  }) {
    return GetAllFavoriteDataState(
      status: status ?? this.status,
      favorites: favorites ?? this.favorites,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
