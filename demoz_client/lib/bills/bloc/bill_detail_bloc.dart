import 'package:demoz_client/bills/bloc/bill_detail_event.dart';
import 'package:demoz_client/bills/bloc/bill_detail_state.dart';
import 'package:demoz_client/bills/models/bills_model.dart';
import 'package:demoz_client/bills/repository/bills_repository.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

class BillDetailBloc extends Bloc<BillDetailEvent, BillDetailState> {
  final BillsRepository billsRepository;
  BillDetailBloc(BillDetailState initialState, this.billsRepository)
      : super(initialState);

  @override
  Stream<BillDetailState> mapEventToState(BillDetailEvent event) async* {
    if (event is BillEdit) {
      final bills = await billsRepository.getBillPlanDetails(event.id);
      yield BillDetailEditing(bills, event.id);
    }
    if (event is BillDetailLoad) {
      yield BillDetailLoading();
      final bills = await billsRepository.getBillPlanDetails(event.id);
      // print(bills);
      yield BillDetailLoaded(bills, event.id);
    }
    if (event is BillEditCancel) {
      yield BillDetailLoading();
      final bills = await billsRepository.getBillPlanDetails(event.id);
      yield BillDetailLoaded(bills, event.id);
    }

    if (event is BillEditSave) {
      final new_date = BillDetailModel.update(
        title: event.title,
        description: event.description,
        frequency: event.frequency,
        amount: event.amount,
        startDate: event.startDate,
        next_pay_day: DateTime.now(),
      );
      final bill = await billsRepository.updateBillPlan(event.id, new_date);
      yield BillDetailLoaded(bill, event.id);
    }

    if (event is RefershPage) {
      yield BillDetailLoading();
      final bills = await billsRepository.getBillPlanDetails(event.id);
      yield BillDetailLoaded(bills, event.id);
    }

    if (event is AddDeposit) {
      // print(event.id);
      final deposit = BillDepositModel(
        amount: event.amount,
        deposit_day: event.date,
        desc: event.desc,
      );
      final result = await billsRepository.createDeposit(
        event.id,
        event.desc,
        event.amount,
        event.date,
      );
      // print(result);
    }
  }
}
