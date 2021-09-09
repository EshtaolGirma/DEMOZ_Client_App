abstract class SavingDetailState {}

class SavingDetailLoaded extends SavingDetailState {
  final List list;
  final int id;

  SavingDetailLoaded(this.list, this.id);
}

class SavingDetailLoading extends SavingDetailState {}

class SavingDetailUnloaded extends SavingDetailState {}

class SavingDetailFailed extends SavingDetailState {
  final String errorMsg;

  SavingDetailFailed(this.errorMsg);
}

class SavingDetailEditing extends SavingDetailState {
  final List list;

  SavingDetailEditing(this.list);
}

abstract class SavingDepositState {}

class DeletedDeposit extends SavingDepositState {}

class EditingDeposit extends SavingDepositState {}

class DepositIdel extends SavingDepositState {}
