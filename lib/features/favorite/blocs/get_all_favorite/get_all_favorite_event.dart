part of 'get_all_favorite_bloc.dart';

abstract class GetAllFavoriteEvent extends Equatable {
  const GetAllFavoriteEvent();

  @override
  List<Object> get props => [];
}

class DoGetAllFavoriteEvent extends GetAllFavoriteEvent {}
