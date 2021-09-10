import 'package:demoz_client/bills/models/bills_model.dart';
import 'package:demoz_client/loans/bloc/loans_detail_event.dart';
import 'package:demoz_client/loans/bloc/loans_detail_state.dart';
import 'package:demoz_client/loans/models/loans_model.dart';
import 'package:demoz_client/loans/repository/loans_repository.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

class LoanDetailBloc extends Bloc<LoansDetailEvent, LoanDetailState> {
  final LoansRepository loansRepository;
  LoanDetailBloc(LoanDetailState initialState, this.loansRepository)
      : super(initialState);

  @override
  Stream<LoanDetailState> mapEventToState(LoansDetailEvent event) async* {
    if (event is LoansEdit) {
      final bills = await loansRepository.getLoanPlanDetails(event.id);
      yield LoanDetailEditing(bills, event.id);
    }
    if (event is LoansDetailLoad) {
      yield LoanDetailLoading();
      final bills = await loansRepository.getLoanPlanDetails(event.id);
      // print(bills);
      yield LoanDetailLoaded(bills, event.id);
    }
    if (event is LoansEditCancel) {
      yield LoanDetailLoading();
      final bills = await loansRepository.getLoanPlanDetails(event.id);
      yield LoanDetailLoaded(bills, event.id);
    }

    if (event is LoansEditSave) {
      final new_date = LoansDetailModel.update(
        title: event.title,
        description: event.description,
        person: event.person,
        collected: event.collected,
        amount: event.amount,
        startDate: event.startDate,
      );
      final bill = await loansRepository.updateLoanPlan(event.id, new_date);
      yield LoanDetailLoaded(bill, event.id);
    }

    if (event is RefershPager) {
      yield LoanDetailLoading();
      final bills = await loansRepository.getLoanPlanDetails(event.id);
      yield LoanDetailLoaded(bills, event.id);
    }

    if (event is AddDepositr) {
      // print(event.id);
      final deposit = BillDepositModel(
        amount: event.amount,
        deposit_day: event.date,
        desc: event.desc,
      );
      final result = await loansRepository.createDeposit(
        event.id,
        event.desc,
        event.amount,
        event.date,
      );
      print(result);
    }
  }
}
