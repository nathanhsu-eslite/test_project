part of 'get_cat_detail_bloc.dart';

sealed class GetCatDetailEvent {}

final class GetCatDetail extends GetCatDetailEvent {
  final String id;
  GetCatDetail(this.id);
}
