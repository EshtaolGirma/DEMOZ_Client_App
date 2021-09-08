abstract class SavingEvent {}

class SavingLoad extends SavingEvent {}
class SavingRefresh extends SavingEvent{}
abstract class SavingCreationEvent {}

class SavingCreationDone extends SavingCreationEvent {
  final String title;
  final double goal;
  final double saved;
  final String description;
  final double amount;
  final int frequency;
  final DateTime startDate;
  final DateTime endDate;

  SavingCreationDone({
    required this.title,
    required this.goal,
    required this.saved,
    required this.description,
    required this.amount,
    required this.frequency,
    required this.startDate,
    required this.endDate,
  });
}

class SavingCreationCancel extends SavingCreationEvent {}
