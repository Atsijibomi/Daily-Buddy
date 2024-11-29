import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dialy_buddy/data_layer/repository/fact_repo.dart';
import 'package:dialy_buddy/domain_layer/entities/fact.dart';
import 'package:dialy_buddy/utils/service_locator.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'fact_event.dart';
part 'fact_state.dart';

class FactBloc extends Bloc<FactEvent, FactState> {
  FactBloc() : super(FactInitial()) {
    on<GetFactEvent>(onGetFact);
    on<ResetFactEvent>(onResetFact);
  }

  FutureOr<void> onGetFact(GetFactEvent event, Emitter<FactState> emit) async {
    emit(FactLoading());
    try {
      final fact = await sl<FactRepository>().getFact();
      print('This is bloc');
      print(fact.fact);
      emit(FactLoaded(fact: fact));
    } catch (e) {
      emit(FactError(message: 'Failed to get fact'));
    }
  }

  FutureOr<void> onResetFact(ResetFactEvent event, Emitter<FactState> emit) {
    emit(FactInitial());
  }
}
