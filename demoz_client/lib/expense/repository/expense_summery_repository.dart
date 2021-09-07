import 'package:demoz_client/expense/data_provider/expense_data.dart';

class ExpenseRepository {
  final ExpenseDataProvider expenseDataProvider;

  ExpenseRepository({required this.expenseDataProvider});

  Future<List> getCategorySummery() async {
    return await expenseDataProvider.getCategorySummery();
  }

  Future<List> getCategoryDetail(int id, String name) async {
    return await expenseDataProvider.getCategoryDetail(id, name);
  }

  Future<List> getExpense(int id) async {
    return await expenseDataProvider.getExpense(id);
  }
}
