import 'package:demoz_client/expense/bloc/expense_detail_state.dart';
import 'package:demoz_client/expense/bloc/expense_detail_event.dart';

import 'package:demoz_client/expense/repository/expense_summery_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class ExpenseDetailBloc extends Bloc<ExpenseDetailEvent, ExpenseDetailState> {
  final ExpenseRepository expenseRepository;
  ExpenseDetailBloc(this.expenseRepository) : super(DetailUnloaded());

  @override
  Stream<ExpenseDetailState> mapEventToState(ExpenseDetailEvent event) async* {
    if (event is DetailLoad) {
      final details = await expenseRepository.getExpense(event.id);
      yield DetailLoaded(details[0]);
    }
    if (event is DetailEdit) {
      final details = await expenseRepository.getExpense(event.id);

      yield DetailEditing(details[0]);
    }

    if (event is DetailSave) {
      final updated = await expenseRepository.updateExpenseDetail(
        event.id,
        event.amount,
        event.date,
        event.description,
        event.accomplice,
      );
      final details = await expenseRepository.getExpense(1);
      yield DetailLoaded(details[0]);
    }

    if (event is DetailCancle) {
      final details = await expenseRepository.getExpense(event.id);
      yield DetailLoaded(details[0]);
    }
  }
}
