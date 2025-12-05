import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_3_35_7/features/get_cat_images/models/my_image.dart';

import 'package:domain/domain.dart';

part 'get_cat_images_event.dart';
part 'get_cat_images_state.dart';

class GetCatImagesBloc extends Bloc<GetCatImagesEvent, GetCatImagesState> {
  GetCatImagesBloc({required this.getCatsImagesUC})
    : super(GetCatImagesInitialState()) {
    on<GetCatImages>(_onGetCatImages);
    on<CatImageRefreshed>(_onCatImageRefreshed);
  }
  final GetCatsImagesUC getCatsImagesUC;
  bool _isFetching = false;
  final int limit = 5;

  Future<void> _onGetCatImages(
    GetCatImages event,
    Emitter<GetCatImagesState> emit,
  ) async {
    if (_isFetching) return;
    try {
      _isFetching = true;
      emit(GetCatImagesLoadingState());
      final rsp = await getCatsImagesUC(limit);
      final List<MyImage> images = rsp.map((entity) {
        return MyImage(
          id: entity.id,
          url: entity.url,
          width: entity.urlWidth,
          height: entity.urlHeight,
        );
      }).toList();
      emit(GetCatImagesSuccessState(images));
    } catch (e) {
      emit(
        GetCatImagesFailureState("Get cats images failed : ${e.toString()}"),
      );
    } finally {
      _isFetching = false;
    }
  }

  Future<void> _onCatImageRefreshed(
    CatImageRefreshed event,
    Emitter<GetCatImagesState> emit,
  ) async {
    if (_isFetching) return;
    try {
      _isFetching = true;
      emit(GetCatImagesLoadingState());
      final cats = await getCatsImagesUC(limit);
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
        ),
      );
    } catch (e) {
      emit(
        GetCatImagesFailureState("Get cats images failed : ${e.toString()}"),
      );
    } finally {
      _isFetching = false;
    }
  }
}
