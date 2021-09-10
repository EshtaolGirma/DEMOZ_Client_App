abstract class BillsState {}

class BillsPlanLoaded extends BillsState {
  final List bills;

  BillsPlanLoaded(this.bills);
}

class BillsLoadFailed extends BillsState {
  final String errorMsg;

  BillsLoadFailed({required this.errorMsg});
}

class BillsLoading extends BillsState {}

class BillsUnloaded extends BillsState {}

abstract class BillCreationState {}

class BillCreationSave extends BillCreationState {}

class BillCreationCanceld extends BillCreationState {}

class BillFormEmpty extends BillCreationState {}
