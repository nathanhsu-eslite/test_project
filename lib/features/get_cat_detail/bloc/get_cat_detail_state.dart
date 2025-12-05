part of 'get_cat_detail_bloc.dart';

sealed class GetCatDetailState {
  const GetCatDetailState();
}

final class GetCatDetailInitialState extends GetCatDetailState {}

final class GetCatDetailLoadingState extends GetCatDetailState {}

final class CatGetDetailFailureState extends GetCatDetailState {
  final String error;
  const CatGetDetailFailureState(this.error);
}

final class CatGetDetailSuccessState extends GetCatDetailState {
  final Cat detail;
  const CatGetDetailSuccessState(this.detail);
}
