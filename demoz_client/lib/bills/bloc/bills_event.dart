abstract class BillsEvent {}

class BillsLoad extends BillsEvent {}

class BillsRefresh extends BillsEvent {}

class BillsAddButtonClicked extends BillsEvent {}

abstract class BillCreationEvent {}

class BillCreationDone extends BillCreationEvent {
  final String title;
  final String description;
  final double amount;
  final int frequency;
  final DateTime startDate;

  BillCreationDone({
    required this.title,
    required this.description,
    required this.amount,
    required this.frequency,
    required this.startDate,
  });
}

class BillCreationCancel extends BillCreationEvent {}
