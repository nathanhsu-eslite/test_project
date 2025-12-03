part of 'home_bloc.dart';

abstract class HomeEvent {
  const HomeEvent();
}

class HomeCatsFetched extends HomeEvent {
  const HomeCatsFetched();
}

class HomeCatsRefreshed extends HomeEvent {
  const HomeCatsRefreshed();
}
