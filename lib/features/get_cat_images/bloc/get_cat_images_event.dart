part of 'get_cat_images_bloc.dart';

sealed class GetCatImagesEvent {}

final class GetCatImages extends GetCatImagesEvent {}

final class CatImageRefreshed extends GetCatImagesEvent {}
