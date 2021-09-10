abstract class LoansDetailEvent {}

class LoansEdit extends LoansDetailEvent {
  final int id;

  LoansEdit(this.id);
}

class LoansEditSave extends LoansDetailEvent {
  final int id;
  final String title;
  final String description;
  final String person;
  final double amount;
  final double collected;
  final DateTime startDate;

  LoansEditSave({
    required this.id,
    required this.title,
    required this.person,
    required this.description,
    required this.amount,
    required this.collected,
    required this.startDate,
  });
}

class LoansEditCancel extends LoansDetailEvent {
  final int id;

  LoansEditCancel(this.id);
}

class LoansDetailLoad extends LoansDetailEvent {
  final int id;

  LoansDetailLoad(this.id);
}

class RefershPager extends LoansDetailEvent {
  final int id;

  RefershPager(this.id);
}

class AddDepositr extends LoansDetailEvent {
  final int id;
  final double amount;
  final DateTime date;
  final String desc;

  AddDepositr({
    required this.id,
    required this.amount,
    required this.date,
    required this.desc,
  });
}
