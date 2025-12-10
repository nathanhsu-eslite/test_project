part of 'get_cat_bloc.dart';

sealed class GetCatDetailState extends Equatable {
  const GetCatDetailState();

  @override
  List<Object> get props => [];
}

final class GetCatDetailInitialState extends GetCatDetailState {}

final class GetCatDetailLoadingState extends GetCatDetailState {}

final class CatGetDetailFailureState extends GetCatDetailState {
  final String error;

  const CatGetDetailFailureState(this.error);

  @override
  List<Object> get props => [error];
}

final class CatGetDetailSuccessState extends GetCatDetailState {
  final Cat detail;

  const CatGetDetailSuccessState(this.detail);

  @override
  List<Object> get props => [detail];
}
