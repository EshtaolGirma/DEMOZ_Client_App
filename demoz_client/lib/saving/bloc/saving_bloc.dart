import 'package:demoz_client/saving/bloc/saving_event.dart';
import 'package:demoz_client/saving/bloc/saving_state.dart';
import 'package:demoz_client/saving/models/saving_model.dart';
import 'package:demoz_client/saving/repository/saving_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SavingBloc extends Bloc<SavingEvent, SavingState> {
  final SavingRepository savingRepository;
  SavingBloc(SavingState initialState, this.savingRepository)
      : super(initialState);

  @override
  Stream<SavingState> mapEventToState(SavingEvent event) async* {
    if (event is SavingLoad) {
      yield SavingLoading();

      final savings = await savingRepository.getSavingPlan();
      yield SavingLoaded(savings);
    }
    if (event is SavingRefresh) {
      // await Future.delayed(Duration(seconds: 2));
      yield SavingUnLoaded();
    }
  }
}

class SavingCreationBloc
    extends Bloc<SavingCreationEvent, SavingCreationState> {
  final SavingRepository savingRepository;
  SavingCreationBloc(SavingCreationState initialState, this.savingRepository)
      : super(initialState);

  @override
  Stream<SavingCreationState> mapEventToState(
      SavingCreationEvent event) async* {
    if (event is SavingCreationDone) {
      final new_date = SavingDetailModel.update(
          title: event.title,
          goal: event.goal,
          saved: event.saved,
          description: event.description,
          frequency: event.frequency,
          amount: event.amount,
          startDate: event.startDate,
          endDate: event.endDate);
      try {
        final response = await savingRepository.createSavingPlan(new_date);
        print(response);
        yield SavingCreationSave();
      } catch (e) {
        print(e);
      }
    }
  }
}
