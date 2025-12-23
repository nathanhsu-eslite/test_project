import 'package:equatable/equatable.dart';
import 'package:domain/domain.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

part 'vote_cat_event.dart';
part 'vote_cat_state.dart';

@injectable
class VoteCatBloc extends Bloc<VoteCatEvent, VoteCatState> {
  final VoteCatUseCase voteCatUseCase;

  VoteCatBloc({required this.voteCatUseCase}) : super(VoteCatInitial()) {
    on<VoteCat>((event, emit) async {
      emit(VoteCatLoading());
      try {
        await voteCatUseCase.call(event.imageId, event.subId);
        emit(VoteCatSuccess());
      } catch (e) {
        emit(VoteCatError(e)); // Emit the exception
      }
    });
  }
}
