abstract class TransactionDetailEvent {}

class DetailEdit extends TransactionDetailEvent {
  final int id;

  DetailEdit(this.id);
}

class DetailSave extends TransactionDetailEvent {
  final int id;
  final double amount;
  final DateTime date;
  final String description;
  final String accomplice;

  DetailSave(
      this.amount, this.date, this.description, this.accomplice, this.id);
}

class DetailCancle extends TransactionDetailEvent {
  final int id;

  DetailCancle(this.id);
}

class DetailLoad extends TransactionDetailEvent {
  final int id;

  DetailLoad(this.id);
}
