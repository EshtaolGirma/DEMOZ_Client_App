abstract class LoansState {}

class LoansLoaded extends LoansState {
  final List loans;

  LoansLoaded(this.loans);
}

class LoansLoadFailed extends LoansState {
  final String errorMsg;

  LoansLoadFailed({required this.errorMsg});
}

class LoansLoading extends LoansState {}

class LoansUnloaded extends LoansState {}

abstract class LoansCreationState {}

class LoansCreationSave extends LoansCreationState {}

class LoansCreationCanceld extends LoansCreationState {}

class LoansFormEmpty extends LoansCreationState {}
