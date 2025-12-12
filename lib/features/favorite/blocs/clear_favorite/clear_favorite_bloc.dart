import 'package:domain/domain.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'clear_favorite_event.dart';
part 'clear_favorite_state.dart';

class ClearFavoriteBloc extends Bloc<ClearFavoriteEvent, ClearFavoriteState> {
  final ClearFavoriteUseCase _clearFavoriteUC;

  ClearFavoriteBloc({required ClearFavoriteUseCase clearFavoriteUC})
    : _clearFavoriteUC = clearFavoriteUC,
      super(ClearFavoriteInitial()) {
    on<DoClearFavoriteEvent>(_onDoClearFavorite);
  }

  Future<void> _onDoClearFavorite(
    DoClearFavoriteEvent event,
    Emitter<ClearFavoriteState> emit,
  ) async {
    emit(ClearFavoriteLoading());
    try {
      final isSuccess = await _clearFavoriteUC.call();
      if (isSuccess) {
        emit(ClearFavoriteSuccess());
        return;
      }
      emit(ClearFavoriteFailure());
    } catch (e) {
      emit(ClearFavoriteFailure());
    }
  }
}
