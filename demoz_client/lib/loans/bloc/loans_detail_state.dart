abstract class LoanDetailState {}

class LoanDetailLoaded extends LoanDetailState {
  final List loans;
  final int id;

  LoanDetailLoaded(this.loans, this.id);
}

class LoanDetailLoading extends LoanDetailState {}

class LoanDetailUnloaded extends LoanDetailState {}

class LoanDetailFailed extends LoanDetailState {
  final String errorMsg;

  LoanDetailFailed(this.errorMsg);
}

class LoanDetailEditing extends LoanDetailState {
  final List list;
  final int ids;

  LoanDetailEditing(this.list, this.ids);
}
