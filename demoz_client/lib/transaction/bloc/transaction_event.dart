abstract class TransactionEvent {}

class TransactionLoad extends TransactionEvent {}

abstract class TransactionCategoryDetailEvent {}

class TransactionDetailLoad extends TransactionCategoryDetailEvent {
  final int category_id;
  final String name;

  TransactionDetailLoad(this.category_id, this.name);
}

class TransactionDetailClick extends TransactionCategoryDetailEvent {
  final int Transaction_id;
  final String Transaction_cat;

  TransactionDetailClick(this.Transaction_id, this.Transaction_cat);
}
