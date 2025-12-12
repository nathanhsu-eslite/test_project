import 'package:data/data.dart';
import 'package:domain/domain.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_3_35_7/features/get_cat_detail/models/cat.dart';
import 'package:test_3_35_7/features/get_cat_images/models/my_image.dart';

part 'add_favorite_event.dart';
part 'add_favorite_state.dart';

class AddFavoriteBloc extends Bloc<AddFavoriteEvent, AddFavoriteState> {
  final AddFavoriteUseCase _addFavoriteUseCase;

  AddFavoriteBloc({required AddFavoriteUseCase addFavoriteUseCase})
    : _addFavoriteUseCase = addFavoriteUseCase,
      super(AddFavoriteInitial()) {
    on<AddFavorite>(_onAddFavorite);
  }

  Future<void> _onAddFavorite(
    AddFavorite event,
    Emitter<AddFavoriteState> emit,
  ) async {
    emit(AddFavoriteLoading());
    try {
      final favorite = Favorite(
        imageId: event.image.id,
        url: event.image.url,
        urlHeight: event.image.height,
        urlWidth: event.image.width,
        breedName: event.catDetail.breedName,
      );
      await _addFavoriteUseCase.call(favorite);

      emit(AddFavoriteSuccess());
    } catch (e) {
      emit(AddFavoriteFailure(e.toString()));
    }
  }
}
