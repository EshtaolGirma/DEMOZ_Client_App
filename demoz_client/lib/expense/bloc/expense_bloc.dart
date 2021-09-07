import 'package:demoz_client/expense/bloc/expense_event.dart';
import 'package:demoz_client/expense/bloc/expense_state.dart';
import 'package:demoz_client/expense/repository/expense_summery_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ExpenseBloc extends Bloc<ExpenseEvent, ExpenseState> {
  final ExpenseRepository expenseRepository;

  ExpenseBloc({required this.expenseRepository})
      : assert(expenseRepository != null),
        super(ExpenseUnloaded());

  // ExpenseBloc(ExpenseState initialState) : super(ExpenseUnloaded());

  @override
  Stream<ExpenseState> mapEventToState(ExpenseEvent event) async* {
    if (state is ExpenseUnloaded) {
      try {
        yield ExpenseLoading();
        // await Future.delayed(Duration(seconds: 2));
        final expenses = await expenseRepository.getCategorySummery();

        yield ExpenseLoaded(expenses);
      } catch (_) {
        print(_);
      }
    }
  }
}

class ExpenseCategoryBloc
    extends Bloc<ExpenseCategoryDetailEvent, ExpenseCategoryDetailState> {
  final ExpenseRepository expenseRepository;

  ExpenseCategoryBloc({required this.expenseRepository})
      : assert(expenseRepository != null),
        super(ExpenseDetailUnloaded());

  @override
  Stream<ExpenseCategoryDetailState> mapEventToState(
      ExpenseCategoryDetailEvent event) async* {
    if (event is ExpenseDetailLoad) {
      try {
        final expensesDetail = await expenseRepository.getCategoryDetail(
            event.category_id, event.name);

        yield ExpenseDetailLoaded(expensesDetail);
        // print(event.category);
        // print(expensesDetail);
      } catch (_) {
        print(_);
      }
    }

    if (event is ExpenseDetailClick) {
      final expensesDetail = await expenseRepository.getExpense(event.expense);
      print(expensesDetail);
      yield ExpenseDetailClicked(expensesDetail);
    }
  }

  // ExpenseBloc(ExpenseState initialState) : super(ExpenseUnloaded());

}
