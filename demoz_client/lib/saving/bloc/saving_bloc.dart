import 'package:demoz_client/saving/bloc/saving_event.dart';
import 'package:demoz_client/saving/bloc/saving_state.dart';
import 'package:demoz_client/saving/repository/saving_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SavingBloc extends Bloc<SavingEvent, SavingState> {
  final SavingRepository savingRepository;

  SavingBloc(SavingState initialState, this.savingRepository)
      : super(initialState);

  @override
  Stream<SavingState> mapEventToState(SavingEvent event) async* {
    if (state is SavingUnloaded) {
      try {
        yield SavingLoading();
        await Future.delayed(Duration(seconds: 6));
        // final savings = await savingRepository.getSavingPlans(id);

        yield SavingPlanLoaded();
      } catch (_) {
        print(_);
      }
    }
  }
}
