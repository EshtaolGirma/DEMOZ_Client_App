import 'dart:convert';
import 'dart:math';

import 'package:demoz_client/expense/models/expense_category_summery.dart';
import 'package:demoz_client/sharedPreferences.dart';
import 'package:http/http.dart' as http;

class ExpenseDataProvider {
  final _baseUrl = 'http://127.0.0.1:8000/transactions';
  final http.Client httpClient;

  final _prefs = sharedPreference();
  ExpenseDataProvider(this.httpClient);

  Future<List> getCategorySummery() async {
    final result = await _prefs.getsession();
    final response = await httpClient.get(
      Uri.parse('$_baseUrl/get/category/summery/'),
      headers: {'cookie': '$result'},
    );

    if (response.statusCode == 200) {
      final expese_category_summery = jsonDecode(response.body);
      return expese_category_summery['summery']
          .map((expense) => ExpenseCategorySummery.fromJson(expense))
          .toList();
    } else {
      throw Exception('Failed to load expense summery');
    }
  }

  Future<List> getCategoryDetail(int id, String name) async {
    final result = await _prefs.getsession();
    final response = await httpClient.get(
      Uri.parse('$_baseUrl/get/category/detail/$id'),
      headers: {'cookie': '$result'},
    );
    if (response.statusCode == 200) {
      final expese_category_detail = jsonDecode(response.body);
      return expese_category_detail['$name']
          .map((expenseDetail) => ExpenseCategoryDetail.fromJson(expenseDetail))
          .toList();
    } else {
      throw Exception('Failed to load expense detail');
    }
  }

  Future<List> getExpense(int id) async {
    final result = await _prefs.getsession();
    final response = await httpClient.get(
      Uri.parse('$_baseUrl/get/$id'),
      headers: {'cookie': '$result'},
    );
    if (response.statusCode == 200) {
      final expense_detail = jsonDecode(response.body);
      return expense_detail['Expense Detail']
          .map((expenseDetail) => ExpenseCategoryDetail.fromJson(expenseDetail))
          .toList();
    } else {
      throw Exception('Failed to load expense detail');
    }
  }

  Future<List> getUserContact(int id) async {
    final result = await _prefs.getsession();
    final response = await httpClient.get(
      Uri.parse('http://127.0.0.1:8000/account/contacts/'),
      headers: {'cookie': '$result'},
    );

    if (response.statusCode == 200) {
      final contacts = jsonDecode(response.body);

      return contacts['Contacts'];
    } else {
      throw Exception('Failed to load Contacts');
    }
  }

  Future<List> updateExpenseDetail(int id, double amount, DateTime date,
      String description, String accomplice) async {
    int year = date.year;
    int month = date.month;
    int day = date.day;
    final result = await _prefs.getsession();
    final response = await httpClient.put(
      Uri.parse('$_baseUrl/update/$id'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'cookie': '$result'
      },
      body: jsonEncode(<String, String>{
        "spent_amount": '$amount',
        "expense_day": "$year-$month-$day",
        "spent_with": "$accomplice",
        "description": "$description",
      }),
    );

    if (response.statusCode == 200) {
      final expense_detail = jsonDecode(response.body);
      return expense_detail['Expense Detail']
          .map((expenseDetail) => ExpenseCategoryDetail.fromJson(expenseDetail))
          .toList();
    } else {
      throw Exception('Failed to load expense detail');
    }
  }
}
