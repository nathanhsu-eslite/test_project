part of 'home_bloc.dart';

enum HomeStatus { initial, loading, success, failure }

class HomeState {
  const HomeState({
    this.status = HomeStatus.initial,
    this.cats = const <CatModel>[],
    this.hasReachedMax = false,
    this.error,
  });

  final HomeStatus status;
  final List<CatModel> cats;
  final bool hasReachedMax; //確認是否已經加載完所有資料
  final dynamic error;

  HomeState copyWith({
    HomeStatus? status,
    List<CatModel>? cats,
    bool? hasReachedMax,
    dynamic error,
  }) {
    return HomeState(
      status: status ?? this.status,
      cats: cats ?? this.cats,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      error: error ?? this.error,
    );
  }
}
