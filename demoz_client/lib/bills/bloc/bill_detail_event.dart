abstract class BillDetailEvent {}

class BillEdit extends BillDetailEvent {
  final int id;

  BillEdit(this.id);
}

class BillEditSave extends BillDetailEvent {
  final int id;
  final String title;
  final String description;
  final double amount;
  final int frequency;
  final DateTime startDate;

  BillEditSave({
    required this.id,
    required this.title,
    required this.description,
    required this.amount,
    required this.frequency,
    required this.startDate,
  });
}

class BillEditCancel extends BillDetailEvent {
  final int id;

  BillEditCancel(this.id);
}

class BillDetailLoad extends BillDetailEvent {
  final int id;

  BillDetailLoad(this.id);
}

class RefershPage extends BillDetailEvent {
  final int id;

  RefershPage(this.id);
}

class AddDeposit extends BillDetailEvent {
  final int id;
  final double amount;
  final DateTime date;
  final String desc;

  AddDeposit({
    required this.id,
    required this.amount,
    required this.date,
    required this.desc,
  });
}
