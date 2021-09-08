abstract class SavingState {}

class SavingLoaded extends SavingState {
  final List<dynamic> savingPlans;

  SavingLoaded(this.savingPlans);
}

class SavingUnLoaded extends SavingState {}

class SavingLoading extends SavingState {}

class SavingFailed extends SavingState {
  final String errorMsg;

  SavingFailed(this.errorMsg);
}

abstract class SavingCreationState {}

class SavingCreationSave extends SavingCreationState {}

class SavingCreationCanceld extends SavingCreationState {}

class SavingFormEmpty extends SavingCreationState {}
