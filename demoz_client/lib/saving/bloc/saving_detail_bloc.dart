import 'dart:convert';

import 'package:demoz_client/saving/bloc/saving_detail_event.dart';
import 'package:demoz_client/saving/bloc/saving_detail_state.dart';
import 'package:demoz_client/saving/models/saving_model.dart';
import 'package:demoz_client/saving/repository/saving_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SavingDetailBloc extends Bloc<SavingDetailEvent, SavingDetailState> {
  final SavingRepository savingRepository;
  SavingDetailBloc(SavingDetailState initialState, this.savingRepository)
      : super(initialState);

  @override
  Stream<SavingDetailState> mapEventToState(SavingDetailEvent event) async* {
    if (event is SavingEdit) {
      final savings = await savingRepository.getSavingPlanDetails(event.id);
      yield SavingDetailEditing(savings);
    }
    if (event is SavingDetailLoad) {
      yield SavingDetailLoading();
      final savings = await savingRepository.getSavingPlanDetails(event.id);

      yield SavingDetailLoaded(savings, event.id);
    }
    if (event is SavingEditCancle) {
      yield SavingDetailLoading();
      final savings = await savingRepository.getSavingPlanDetails(event.id);

      yield SavingDetailLoaded(savings, event.id);
    }

    if (event is SavingEditSave) {
      final new_date = SavingDetailModel.update(
          title: event.title,
          goal: event.goal,
          saved: event.saved,
          description: event.description,
          frequency: event.frequency,
          amount: event.amount,
          startDate: event.startDate,
          endDate: event.endDate);
      final saving =
          await savingRepository.updateSavingPlan(event.id, new_date);
      // print(saving);
      yield SavingDetailLoaded(saving, event.id);
    }
    if (event is RefershPage) {
      yield SavingDetailLoading();
      final savings = await savingRepository.getSavingPlanDetails(event.id);
      yield SavingDetailLoaded(savings, event.id);
    }

    if (event is AddDeposit) {
      print(event.id);
      final deposit = SavingDepositModel(
        amount: event.amount,
        deposit_day: event.date,
        desc: event.desc,
      );
      final result = await savingRepository.createDeposit(event.id, deposit);
      print(result);
    }

    // if (event is DeleteDeposit) {
    //   yield DeletedDeposit();
    // }
  }
}
