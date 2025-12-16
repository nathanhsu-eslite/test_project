part of 'breeds_matcher_bloc.dart';

abstract class BreedsMatcherEvent extends Equatable {
  const BreedsMatcherEvent();

  @override
  List<Object> get props => [];
}

class BreedsMatcherStarted extends BreedsMatcherEvent {
  const BreedsMatcherStarted({required this.userPreference});
  final UserPreference userPreference;

  @override
  List<Object> get props => [userPreference];
}
