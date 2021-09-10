// abstract class LoansEvent {}

// class LoansLoad extends LoansEvent {}

// class LoansClick extends LoansEvent {}

// class LoansAddButtonClicked extends LoansEvent {}

abstract class LoansEvent {}

class LoansLoad extends LoansEvent {}

class LoansRefresh extends LoansEvent {}

class LoansAddButtonClicked extends LoansEvent {}

abstract class LoansCreationEvent {}

class LoansCreationDone extends LoansCreationEvent {
  final String title;
  final double collected;

  final String description;
  final double amount;
  final String person;
  final DateTime startDate;

  LoansCreationDone( {
    required this.collected,
    required this.title,
    required this.description,
    required this.amount,
    required this.person,
    required this.startDate,
  });
}

class LoansCreationCancel extends LoansCreationEvent {}
