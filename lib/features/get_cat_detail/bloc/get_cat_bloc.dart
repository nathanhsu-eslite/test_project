import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_3_35_7/features/get_cat_detail/models/cat.dart';

import 'package:domain/domain.dart';

import 'package:equatable/equatable.dart';

part 'get_cat_event.dart';
part 'get_cat_state.dart';

class GetCatBloc extends Bloc<GetCatDetailEvent, GetCatDetailState> {
  GetCatBloc({required this.getCatsDetailUseCase})
    : super(GetCatDetailInitialState()) {
    on<GetCatQueried>(_onGetCatDetail);
  }
  final GetCatsDetailUseCase getCatsDetailUseCase;

  Future<void> _onGetCatDetail(
    GetCatQueried event,
    Emitter<GetCatDetailState> emit,
  ) async {
    try {
      emit(GetCatDetailLoadingState());
      final rsp = await getCatsDetailUseCase(event.id);
      emit(
        CatGetDetailSuccessState(
          Cat(
            breedName: rsp.breedName,
            temperament: rsp.temperament,
            origin: rsp.origin,
            description: rsp.description,
            lifeSpan: rsp.lifeSpan,
          ),
        ),
      );
    } catch (e) {
      emit(CatGetDetailFailureState("Get cat detail failed : ${e.toString()}"));
    }
  }
}
