part of 'get_cat_images_bloc.dart';

sealed class GetCatImagesState {
  const GetCatImagesState();
}

final class GetCatImagesInitialState extends GetCatImagesState {}

final class GetCatImagesLoadingState extends GetCatImagesState {}

final class GetCatImagesSuccessState extends GetCatImagesState {
  final List<MyImage> images;
  const GetCatImagesSuccessState(this.images);
}

final class GetCatImagesFailureState extends GetCatImagesState {
  final String error;
  const GetCatImagesFailureState(this.error);
}

final class GetCatImagesRefreshSuccess extends GetCatImagesState {
  final List<MyImage> images;
  const GetCatImagesRefreshSuccess(this.images);
}

final class GetCatImagesRefreshFailed extends GetCatImagesState {
  final String error;
  const GetCatImagesRefreshFailed(this.error);
}
