import 'package:demoz_client/expense/models/expense_category_summery.dart';

abstract class ExpenseState {}

class ExpenseLoading extends ExpenseState {}

class ExpenseLoaded extends ExpenseState {
  final List<dynamic> expenseList;

  ExpenseLoaded(this.expenseList);
}

class ExpenseUnloaded extends ExpenseState {}

class ExpenseLoadFailed extends ExpenseState {
  final String errorMsg;

  ExpenseLoadFailed({required this.errorMsg});
}

abstract class ExpenseCategoryDetailState {}

class ExpenseDetailLoading extends ExpenseCategoryDetailState {}

class ExpenseDetailUnloaded extends ExpenseCategoryDetailState {}

class ExpenseDetailLoaded extends ExpenseCategoryDetailState {
  final List<dynamic> expenseDetailList;

  ExpenseDetailLoaded(this.expenseDetailList);
}

class ExpenseDetailLoadFailed extends ExpenseCategoryDetailState {
  final String errorMsg;

  ExpenseDetailLoadFailed({required this.errorMsg});
}

class ExpenseDetailClicked extends ExpenseCategoryDetailState {
  final List<dynamic> detail;

  ExpenseDetailClicked(this.detail);
}
