import 'package:domain/domain.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_3_35_7/features/favorite/favorite.dart';

part 'find_favorite_event.dart';
part 'find_favorite_state.dart';

class FindFavoriteBloc extends Bloc<FindFavoriteEvent, FindFavoriteState> {
  final FindFavoriteUseCase _findFavoriteUC;

  FindFavoriteBloc({required FindFavoriteUseCase findFavoriteUC})
    : _findFavoriteUC = findFavoriteUC,
      super(const FindFavoriteDataState(status: FindFavoriteStatus.initial)) {
    on<FindFavoriteByName>(_onFindFavoriteByName);
  }

  Future<void> _onFindFavoriteByName(
    FindFavoriteByName event,
    Emitter<FindFavoriteState> emit,
  ) async {
    emit(
      (state as FindFavoriteDataState).copyWith(
        status: FindFavoriteStatus.loading,
      ),
    );
    try {
      final favorites = await _findFavoriteUC.call(event.name);
      emit(
        (state as FindFavoriteDataState).copyWith(
          status: FindFavoriteStatus.success,
          favorites: favorites
              .map(
                (e) => FavoriteCat(
                  id: e.id,
                  imageId: e.imageId,
                  url: e.url,
                  urlHeight: e.urlHeight,
                  urlWidth: e.urlWidth,
                  breedName: e.breedName,
                ),
              )
              .toList(),
        ),
      );
    } catch (e) {
      emit(
        (state as FindFavoriteDataState).copyWith(
          status: FindFavoriteStatus.failure,
          errorMessage: e.toString(),
        ),
      );
    }
  }
}
