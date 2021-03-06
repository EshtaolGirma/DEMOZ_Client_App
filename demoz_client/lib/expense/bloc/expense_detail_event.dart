abstract class ExpenseDetailEvent {}

class DetailEdit extends ExpenseDetailEvent {
  final int id;

  DetailEdit(this.id);
}

class DetailSave extends ExpenseDetailEvent {
  final int id;
  final double amount;
  final DateTime date;
  final String description;
  final String accomplice;

  DetailSave(
      this.amount, this.date, this.description, this.accomplice, this.id);
}

class DetailCancle extends ExpenseDetailEvent {
  final int id;

  DetailCancle(this.id);
}

class DetailLoad extends ExpenseDetailEvent {
  final int id;

  DetailLoad(this.id);
}
