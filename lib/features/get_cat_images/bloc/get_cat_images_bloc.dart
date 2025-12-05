import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_3_35_7/features/get_cat_images/models/my_image.dart';

import 'package:domain/domain.dart';

part 'get_cat_images_event.dart';
part 'get_cat_images_state.dart';

class GetCatImagesBloc extends Bloc<GetCatImagesEvent, GetCatImagesState> {
  GetCatImagesBloc({required this.getCatsImagesUseCase})
    : super(GetCatImagesInitialState()) {
    on<GetCatImages>(_onGetCatImages);
    on<CatImageRefreshed>(_onCatImageRefreshed);
  }
  final GetCatsImagesUseCase getCatsImagesUseCase;
  final int limit = 10;

  Future<void> _onGetCatImages(
    GetCatImages event,
    Emitter<GetCatImagesState> emit,
  ) async {
    final currentState = state;
    if (currentState is GetCatImagesSuccessState &&
        currentState.hasReachedMax) {
      return;
    }
    try {
      if (currentState is GetCatImagesInitialState) {
        emit(GetCatImagesLoadingState());
      }
      final rsp = await getCatsImagesUseCase(limit);
      final List<MyImage> images = rsp.map((entity) {
        return MyImage(
          id: entity.id,
          url: entity.url,
          width: entity.urlWidth,
          height: entity.urlHeight,
        );
      }).toList();
      if (currentState is GetCatImagesSuccessState) {
        emit(
          GetCatImagesSuccessState(
            currentState.images + images,
            hasReachedMax: images.length < limit,
          ),
        );
      } else {
        emit(
          GetCatImagesSuccessState(
            images,
            hasReachedMax: images.length < limit,
          ),
        );
      }
    } catch (e) {
      emit(
        GetCatImagesFailureState("Get cats images failed : ${e.toString()}"),
      );
    }
  }

  Future<void> _onCatImageRefreshed(
    CatImageRefreshed event,
    Emitter<GetCatImagesState> emit,
  ) async {
    try {
      emit(GetCatImagesLoadingState());
      final cats = await getCatsImagesUseCase(limit);
      emit(
        GetCatImagesSuccessState(
          cats
              .map(
                (e) => MyImage(
                  id: e.id,
                  url: e.url,
                  width: e.urlWidth,
                  height: e.urlHeight,
                ),
              )
              .toList(),
          hasReachedMax: cats.length < limit,
        ),
      );
    } catch (e) {
      emit(
        GetCatImagesFailureState("Get cats images failed : ${e.toString()}"),
      );
    }
  }
}
