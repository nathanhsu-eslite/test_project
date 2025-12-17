part of 'breeds_matcher_bloc.dart';

sealed class BreedsMatcherState extends Equatable {
  const BreedsMatcherState();

  @override
  List<Object> get props => [];
}

class BreedsMatcherInitial extends BreedsMatcherState {}

class BreedsMatcherLoadInProgress extends BreedsMatcherState {}

class BreedsMatcherLoadSuccess extends BreedsMatcherState {
  const BreedsMatcherLoadSuccess({required this.matchResult});

  final List<BreedMatchResult> matchResult;

  @override
  List<Object> get props => [matchResult];
}

class BreedsMatcherLoadFailure extends BreedsMatcherState {
  const BreedsMatcherLoadFailure({required this.message});

  final String message;

  @override
  List<Object> get props => [message];
}
