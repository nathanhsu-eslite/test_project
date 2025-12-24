part of 'get_cat_images_bloc.dart';

enum CatImagesStatus { initial, loading, success, failure, loadingMore }

sealed class GetCatImagesState extends Equatable {
  final List<MyImage> images;
  final bool hasReachedMax;
  final Exception? error;
  final CatImagesStatus status;

  const GetCatImagesState({
    this.images = const [],
    this.hasReachedMax = false,
    this.error,
    required this.status,
  });
  GetCatImagesState copyWith();
  @override
  List<Object?> get props => [images, hasReachedMax, error, status];
}

final class GetCatImagesDataState extends GetCatImagesState {
  const GetCatImagesDataState({
    required super.status,
    super.images,
    super.hasReachedMax,
    super.error,
  });

  // 複製方法
  @override
  GetCatImagesDataState copyWith({
    CatImagesStatus? status,
    List<MyImage>? images,
    bool? hasReachedMax,
    Exception? error,
  }) {
    return GetCatImagesDataState(
      status: status ?? this.status,
      images: images ?? this.images,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      error: error ?? this.error,
    );
  }

  @override
  List<Object?> get props => [images, status, hasReachedMax, error];
}
