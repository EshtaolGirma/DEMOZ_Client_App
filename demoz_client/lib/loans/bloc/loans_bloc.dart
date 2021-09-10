import 'package:demoz_client/loans/bloc/loans_event.dart';
import 'package:demoz_client/loans/bloc/loans_state.dart';
import 'package:demoz_client/loans/models/loans_model.dart';
import 'package:demoz_client/loans/repository/loans_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoansBloc extends Bloc<LoansEvent, LoansState> {
  final LoansRepository loansRepository;

  LoansBloc(LoansState initialState, this.loansRepository)
      : super(initialState);

  @override
  Stream<LoansState> mapEventToState(LoansEvent event) async* {
    if (event is LoansLoad) {
      yield LoansLoading();
      print('event');
      final loans = await loansRepository.getLoanPlans();
      yield LoansLoaded(loans);
    }
    if (event is LoansRefresh) {
      yield LoansUnloaded();
    }
  }
}

class LoanCreationBloc extends Bloc<LoansCreationEvent, LoansCreationState> {
  LoansRepository loanRepository;
  LoanCreationBloc(LoansCreationState initialState, this.loanRepository)
      : super(initialState);

  @override
  Stream<LoansCreationState> mapEventToState(LoansCreationEvent event) async* {
    if (event is LoansCreationDone) {
      final new_date = LoansDetailModel.update(
        collected : event.collected,
    title : event.title,
    person : event.person,
    amount : event.amount,
    description : event.description,
    startDate : event.startDate,
      );
      try {
        final response = await loanRepository.createLoanPlan(new_date);
        print(response);
        yield LoansCreationSave();
      } catch (e) {
        print(e);
      }
    }
  }
}
