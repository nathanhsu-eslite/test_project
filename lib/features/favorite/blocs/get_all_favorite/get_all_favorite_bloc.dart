import 'package:domain/domain.dart';
// import 'package:data/data.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_3_35_7/features/favorite/favorite.dart';

part 'get_all_favorite_event.dart';
part 'get_all_favorite_state.dart';

class GetAllFavoriteBloc
    extends Bloc<GetAllFavoriteEvent, GetAllFavoriteState> {
  final GetAllFavoriteUseCase _getFavoriteUC;

  GetAllFavoriteBloc({required GetAllFavoriteUseCase getFavoriteUC})
    : _getFavoriteUC = getFavoriteUC,
      super(
        const GetAllFavoriteDataState(status: GetAllFavoriteStatus.initial),
      ) {
    on<DoGetAllFavoriteEvent>(_onDoGetAllFavorite);
  }

  Future<void> _onDoGetAllFavorite(
    DoGetAllFavoriteEvent event,
    Emitter<GetAllFavoriteState> emit,
  ) async {
    emit(
      (state as GetAllFavoriteDataState).copyWith(
        status: GetAllFavoriteStatus.loading,
      ),
    );
    try {
      final favorites = await _getFavoriteUC.call();
      emit(
        (state as GetAllFavoriteDataState).copyWith(
          status: GetAllFavoriteStatus.success,
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
        (state as GetAllFavoriteDataState).copyWith(
          status: GetAllFavoriteStatus.failure,
          errorMessage: e.toString(),
        ),
      );
    }
  }
}
