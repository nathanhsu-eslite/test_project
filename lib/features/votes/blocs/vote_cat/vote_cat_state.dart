part of 'vote_cat_bloc.dart';

abstract class VoteCatState extends Equatable {
  const VoteCatState();

  @override
  List<Object> get props => [];
}

class VoteCatInitial extends VoteCatState {}

class VoteCatLoading extends VoteCatState {}

class VoteCatSuccess extends VoteCatState {}

class VoteCatError extends VoteCatState {
  final Object exception;

  const VoteCatError(this.exception);

  @override
  List<Object> get props => [exception];
}
