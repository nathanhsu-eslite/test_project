import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_3_35_7/features/get_cat_detail/models/cat.dart';

import 'package:domain/domain.dart';

import 'package:equatable/equatable.dart';

part 'get_cat_detail_event.dart';
part 'get_cat_detail_state.dart';

class GetCatDetailBloc extends Bloc<GetCatDetailEvent, GetCatDetailState> {
  GetCatDetailBloc(this.getCatDetailUC) : super(GetCatDetailInitialState()) {
    on<GetCatDetail>(_onGetCatDetail);
  }
  final GetCatDetailUC getCatDetailUC;

  Future<void> _onGetCatDetail(
    GetCatDetail event,
    Emitter<GetCatDetailState> emit,
  ) async {
    try {
      emit(GetCatDetailLoadingState());
      final rsp = await getCatDetailUC(event.id);
      emit(
        CatGetDetailSuccessState(
          Cat(
            breedName: rsp.breedName,
            temperament: rsp.temperament,
            origin: rsp.origin,
            description: rsp.description,
          ),
        ),
      );
    } catch (e) {
      emit(CatGetDetailFailureState("Get cat detail failed : ${e.toString()}"));
    }
  }
}
