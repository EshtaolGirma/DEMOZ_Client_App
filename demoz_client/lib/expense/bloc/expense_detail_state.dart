import 'package:demoz_client/expense/models/expense_category_summery.dart';

abstract class ExpenseDetailState {}

class DetailLoading extends ExpenseDetailState {}

class DetailLoaded extends ExpenseDetailState {
  final ExpenseCategoryDetail expenseDetailList;

  DetailLoaded(this.expenseDetailList);
}

class DetailUnloaded extends ExpenseDetailState {}

class DetailLoadFailed extends ExpenseDetailState {
  final String errorMsg;

  DetailLoadFailed(this.errorMsg);
}

class DetailEditing extends ExpenseDetailState {
  final ExpenseCategoryDetail expenseDetailList;

  DetailEditing(this.expenseDetailList);
}
