import 'package:demoz_client/transaction/models/transaction_model.dart';

abstract class TransactionDetailState {}

class DetailLoading extends TransactionDetailState {}

class DetailLoaded extends TransactionDetailState {
  final CategorySummery transactionDetailList;

  DetailLoaded(this.transactionDetailList);
}

class DetailUnloaded extends TransactionDetailState {}

class DetailLoadFailed extends TransactionDetailState {
  final String errorMsg;

  DetailLoadFailed(this.errorMsg);
}

class DetailEditing extends TransactionDetailState {
  final TransactionCategoryDetail transactionDetailList;

  DetailEditing(this.transactionDetailList);
}
