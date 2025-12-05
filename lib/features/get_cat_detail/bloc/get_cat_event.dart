part of 'get_cat_bloc.dart';

sealed class GetCatDetailEvent {}

final class GetCatQueried extends GetCatDetailEvent {
  final String id;
  GetCatQueried(this.id);
}
