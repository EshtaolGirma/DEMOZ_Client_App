import 'package:demoz_client/expense/data_provider/expense_data.dart';
import 'package:demoz_client/transaction/date_provider/transaction_data.dart';

class TransactionRepository {
  final TransactionDataProvider transactionDataProvider;

  TransactionRepository({required this.transactionDataProvider});

  Future<List> getCategorySummery() async {
    return await transactionDataProvider.getCategorySummery();
  }

  Future<String> createExpenseDeposit(int id, double amount, DateTime date,
      String description, String accomplice) async {
    return await transactionDataProvider.createExpenseDeposit(
        id, amount, date, description, accomplice);
  }
}
