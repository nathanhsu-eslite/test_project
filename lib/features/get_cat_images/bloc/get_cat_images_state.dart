part of 'get_cat_images_bloc.dart';

sealed class GetCatImagesState extends Equatable {
  const GetCatImagesState();

  @override
  List<Object> get props => [];
}

final class GetCatImagesInitialState extends GetCatImagesState {}

final class GetCatImagesLoadingState extends GetCatImagesState {}

final class GetCatImagesSuccessState extends GetCatImagesState {
  final List<MyImage> images;
  final bool hasReachedMax;
  const GetCatImagesSuccessState(this.images, {this.hasReachedMax = false});
  @override
  List<Object> get props => [images, hasReachedMax];
}

final class GetCatImagesFailureState extends GetCatImagesState {
  final String error;
  const GetCatImagesFailureState(this.error);
  @override
  List<Object> get props => [error];
}

final class GetCatImagesRefreshSuccess extends GetCatImagesState {
  final List<MyImage> images;
  const GetCatImagesRefreshSuccess(this.images);
  @override
  List<Object> get props => [images];
}

final class GetCatImagesRefreshFailed extends GetCatImagesState {
  final String error;
  const GetCatImagesRefreshFailed(this.error);
  @override
  List<Object> get props => [error];
}
