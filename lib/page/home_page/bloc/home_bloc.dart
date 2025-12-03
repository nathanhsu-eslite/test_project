import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:public_api/public_api.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc({required this.catApi}) : super(const HomeState()) {
    on<HomeCatsFetched>(_onCatsFetched);
    on<HomeCatsRefreshed>(_onCatsRefreshed);
  }

  final CatApiClient catApi;
  final int _limit = 5; //獲取資料的數量
  bool _isFetching = false; //防止連續重複加載資料

  Future<void> _onCatsFetched(
    HomeCatsFetched event,
    Emitter<HomeState> emit,
  ) async {
    if (state.hasReachedMax || _isFetching) return;

    try {
      _isFetching = true;
      if (state.status == HomeStatus.initial) {
        final cats = await catApi.fetchCats(_limit);
        return emit(
          state.copyWith(
            status: HomeStatus.success,
            cats: cats,
            hasReachedMax: false,
          ),
        );
      }

      emit(state.copyWith(status: HomeStatus.loading));

      final cats = await catApi.fetchCats(_limit);
      emit(
        cats.isEmpty
            ? state.copyWith(hasReachedMax: true, status: HomeStatus.success)
            : state.copyWith(
                status: HomeStatus.success,
                cats: List.of(state.cats)..addAll(cats),
                hasReachedMax: false,
              ),
      );
    } catch (e) {
      emit(state.copyWith(status: HomeStatus.failure, error: e));
    } finally {
      _isFetching = false;
    }
  }

  Future<void> _onCatsRefreshed(
    HomeCatsRefreshed event,
    Emitter<HomeState> emit,
  ) async {
    if (_isFetching) return;
    try {
      _isFetching = true;
      emit(
        state.copyWith(
          status: HomeStatus.loading,
          hasReachedMax: false,
          cats: [],
        ),
      );

      final cats = await catApi.fetchCats(_limit);
      emit(
        state.copyWith(
          status: HomeStatus.success,
          cats: cats,
          hasReachedMax: false,
        ),
      );
    } catch (e) {
      emit(state.copyWith(status: HomeStatus.failure, error: e));
    } finally {
      _isFetching = false;
    }
  }
}
