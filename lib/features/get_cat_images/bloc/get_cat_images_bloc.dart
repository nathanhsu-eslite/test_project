import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:test_3_35_7/features/get_cat_images/exception/exception.dart';
import 'package:test_3_35_7/features/get_cat_images/models/my_image.dart';

import 'package:domain/domain.dart';

part 'get_cat_images_event.dart';
part 'get_cat_images_state.dart';

@injectable
class GetCatImagesBloc extends Bloc<GetCatImagesEvent, GetCatImagesDataState> {
  GetCatImagesBloc({required this.getCatsImagesUseCase})
    : super(const GetCatImagesDataState(status: CatImagesStatus.initial)) {
    on<GetCatImages>(_onGetCatImages);
    on<CatImageRefreshed>(_onCatImageRefreshed);
  }
  final GetCatsImagesUseCase getCatsImagesUseCase;
  final int limit = 7;

  Future<void> _onCatImageRefreshed(
    CatImageRefreshed event,
    Emitter<GetCatImagesState> emit,
  ) async {
    try {
      emit(state.copyWith(status: CatImagesStatus.loading));

      final rsp = await getCatsImagesUseCase.call(limit);
      final newImages = rsp.map((entity) {
        return MyImage(
          id: entity.id,
          url: entity.url,
          width: entity.urlWidth,
          height: entity.urlHeight,
        );
      }).toList();

      if (newImages.isEmpty) {
        emit(
          state.copyWith(
            status: CatImagesStatus.failure,
            error: ImagesIsEmptyBlocException(),
          ),
        );
        return;
      }

      emit(
        state.copyWith(
          status: CatImagesStatus.success,
          images: newImages,
          hasReachedMax: newImages.length < limit,
        ),
      );
    } on GetCatImagesBlocException catch (e) {
      emit(state.copyWith(status: CatImagesStatus.failure, error: e));
    } catch (e) {
      emit(
        state.copyWith(
          status: CatImagesStatus.failure,
          error: Exception('An unexpected error occurred: ${e.toString()}'),
        ),
      );
    }
  }

  Future<void> _onGetCatImages(
    GetCatImages event,
    Emitter<GetCatImagesState> emit,
  ) async {
    if (state.hasReachedMax) return;

    try {
      final isInitialLoad = state.status == CatImagesStatus.initial;
      if (isInitialLoad) {
        emit(state.copyWith(status: CatImagesStatus.loading));
      } else {
        emit(state.copyWith(status: CatImagesStatus.loadingMore));
      }

      final rsp = await getCatsImagesUseCase.call(limit);
      final newImages = rsp.map((entity) {
        return MyImage(
          id: entity.id,
          url: entity.url,
          width: entity.urlWidth,
          height: entity.urlHeight,
        );
      }).toList();

      if (newImages.isEmpty) {
        if (isInitialLoad) {
          emit(
            state.copyWith(
              status: CatImagesStatus.failure,
              error: ImagesIsEmptyBlocException(),
            ),
          );
          return;
        } else {
          emit(
            state.copyWith(
              hasReachedMax: true,
              status: CatImagesStatus.success,
            ),
          );
          return;
        }
      }

      emit(
        state.copyWith(
          status: CatImagesStatus.success,
          images: isInitialLoad ? newImages : [...state.images, ...newImages],
          hasReachedMax: newImages.length < limit,
        ),
      );
    } on GetCatImagesBlocException catch (e) {
      emit(state.copyWith(status: CatImagesStatus.failure, error: e));
    } catch (e) {
      emit(
        state.copyWith(
          status: CatImagesStatus.failure,
          error: Exception('An unexpected error occurred: ${e.toString()}'),
        ),
      );
    }
  }
}
