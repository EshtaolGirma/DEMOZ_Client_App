abstract class TransactionState {}

class TransactionLoading extends TransactionState {}

class TransactionLoaded extends TransactionState {
  final List<dynamic> transactionList;

  TransactionLoaded(this.transactionList);
}

class TransactionUnloaded extends TransactionState {}

class TransactionLoadFailed extends TransactionState {
  final String errorMsg;

  TransactionLoadFailed({required this.errorMsg});
}
