import 'dart:convert';
import 'dart:math';

import 'package:demoz_client/expense/models/expense_category_summery.dart';
import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;

class ExpenseDataProvider {
  final _baseUrl = 'http://127.0.0.1:8000/transactions';
  final http.Client httpClient;

  ExpenseDataProvider(this.httpClient);

  Future<List> getCategorySummery() async {
    final response =
        await httpClient.get(Uri.parse('$_baseUrl/get/category/summery/'));

    if (response.statusCode == 200) {
      final expese_category_summery = jsonDecode(response.body);
      return expese_category_summery['summery']
          .map((expense) => ExpenseCategorySummery.fromJson(expense))
          .toList();

      // return expese_category_summery['summery'];
    } else {
      throw Exception('Failed to load expense summery');
    }
  }

  Future<List> getCategoryDetail(int id, String name) async {
    final response =
        await httpClient.get(Uri.parse('$_baseUrl/get/category/detail/$id'));
    if (response.statusCode == 200) {
      final expese_category_detail = jsonDecode(response.body);
      return expese_category_detail['$name']
          .map((expenseDetail) => ExpenseCategoryDetail.fromJson(expenseDetail))
          .toList();
    } else {
      throw Exception('Failed to load expense detail');
    }
    // return ['go'];
  }

  Future<List> getExpense(int id) async {
    final response = await httpClient.get(Uri.parse('$_baseUrl/get/$id'));
    if (response.statusCode == 200) {
      final expense_detail = jsonDecode(response.body);
      return expense_detail['Expense Detail']
          .map((expenseDetail) => ExpenseCategoryDetail.fromJson(expenseDetail))
          .toList();

      // return [expense_detail['Expense Detail']];
    } else {
      throw Exception('Failed to load expense detail');
    }
    // return ['go'];
  }
}
