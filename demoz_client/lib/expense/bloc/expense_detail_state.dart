abstract class ExpenseDetailState {}

class DetailLoading extends ExpenseDetailState {}

class DetailLoaded extends ExpenseDetailState {}

class DetailUnloaded extends ExpenseDetailState {}

class DetailLoadFailed extends ExpenseDetailState {
  final String errorMsg;

  DetailLoadFailed(this.errorMsg);
}

class DetailEditing extends ExpenseDetailState {}
