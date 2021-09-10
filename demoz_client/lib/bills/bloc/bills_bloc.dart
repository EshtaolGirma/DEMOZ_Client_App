import 'package:demoz_client/bills/bloc/bills_event.dart';
import 'package:demoz_client/bills/bloc/bills_state.dart';
import 'package:demoz_client/bills/models/bills_model.dart';
import 'package:demoz_client/bills/repository/bills_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BillsBloc extends Bloc<BillsEvent, BillsState> {
  final BillsRepository billsRepository;

  BillsBloc(BillsState initialState, this.billsRepository)
      : super(initialState);

  @override
  Stream<BillsState> mapEventToState(BillsEvent event) async* {
    if (event is BillsLoad) {
      yield BillsLoading();
      print('event');
      final bills = await billsRepository.getBillPlans();
      yield BillsPlanLoaded(bills);
    }
    if (event is BillsRefresh) {
      yield BillsUnloaded();
    }
  }
}

class BillCreationBloc extends Bloc<BillCreationEvent, BillCreationState> {
  final BillsRepository billRepository;
  BillCreationBloc(BillCreationState initialState, this.billRepository)
      : super(initialState);

  @override
  Stream<BillCreationState> mapEventToState(BillCreationEvent event) async* {
    if (event is BillCreationDone) {
      final new_date = BillDetailModel.update(
          title: event.title,
          description: event.description,
          frequency: event.frequency,
          amount: event.amount,
          startDate: event.startDate,
          next_pay_day: DateTime.now());
      try {
        final response = await billRepository.createBillPlan(new_date);
        print(response);
        yield BillCreationSave();
      } catch (e) {
        print(e);
      }
    }
  }
}
