part of 'vote_cat_bloc.dart';

abstract class VoteCatEvent extends Equatable {
  const VoteCatEvent();

  @override
  List<Object> get props => [];
}

class VoteCat extends VoteCatEvent {
  final String imageId;
  final String subId;

  const VoteCat(this.imageId, this.subId);

  @override
  List<Object> get props => [imageId, subId];
}
