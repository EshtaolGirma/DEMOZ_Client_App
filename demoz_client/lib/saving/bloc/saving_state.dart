abstract class SavingState {}

class SavingPlanLoaded extends SavingState {}

class SavingLoadFailed extends SavingState {
  final String errorMsg;

  SavingLoadFailed({required this.errorMsg});
}

class SavingLoading extends SavingState {}

class SavingUnloaded extends SavingState {}
