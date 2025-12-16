import 'package:cats_repository/cats_repository.dart';
import 'package:domain/domain.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'breeds_matcher_event.dart';
part 'breeds_matcher_state.dart';

class BreedsMatcherBloc extends Bloc<BreedsMatcherEvent, BreedsMatcherState> {
  BreedsMatcherBloc({required this.getMatchResultUC})
    : super(BreedsMatcherInitial()) {
    on<BreedsMatcherStarted>(_onBreedsMatcherStarted);
  }

  final GetMatchResultUseCase getMatchResultUC;
  static int limit = 15;

  Future<void> _onBreedsMatcherStarted(
    BreedsMatcherStarted event,
    Emitter<BreedsMatcherState> emit,
  ) async {
    try {
      if (state is BreedsMatcherInitial) {
        final matchResult = await getMatchResultUC.call(
          pref: event.userPreference,
          limit: limit,
        );
        emit(BreedsMatcherLoadInProgress());
        emit(BreedsMatcherLoadSuccess(matchResult: matchResult));
        return;
      }
      emit(BreedsMatcherLoadInProgress());
      final matchResult = await getMatchResultUC.call(
        pref: event.userPreference,
        limit: limit,
      );
      if (matchResult.isEmpty) {
        emit(BreedsMatcherLoadFailure(message: 'No match result'));
        return;
      }
      emit(BreedsMatcherLoadSuccess(matchResult: matchResult));
    } catch (e) {
      emit(BreedsMatcherLoadFailure(message: e.toString()));
    }
  }
}
