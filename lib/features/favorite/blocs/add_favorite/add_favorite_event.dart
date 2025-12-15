part of 'add_favorite_bloc.dart';

abstract class AddFavoriteEvent extends Equatable {
  const AddFavoriteEvent();

  @override
  List<Object> get props => [];
}

class AddFavorite extends AddFavoriteEvent {
  final Cat catDetail;
  final MyImage image;

  const AddFavorite(this.catDetail, this.image);

  @override
  List<Object> get props => [catDetail, image];
}
