import 'dart:convert';

import 'package:demoz_client/loans/models/loans_model.dart';
import 'package:demoz_client/sharedPreferences.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class LoansDataProvider {
  final _baseUrl = 'http://127.0.0.1:8000/loans';
  final http.Client httpClient;
  final _prefs = sharedPreference();
  LoansDataProvider({required this.httpClient});

  Future<List> getLoanPlans() async {
    final result = await _prefs.getsession();
    final response = await httpClient.get(
      Uri.parse('$_baseUrl/records/'),
      headers: {'cookie': '$result'},
    );
    if (response.statusCode == 200) {
      final result = jsonDecode(response.body);
      return result['List of loans']
          .map((loan) => LoansPlanModel.fromJson(loan))
          .toList();
    } else {
      throw Exception('Failed to load Loan detail');
    }
  }

  Future<List> getLoanPlanDetails(int id) async {
    final result = await _prefs.getsession();
    final response = await httpClient.get(
      Uri.parse("$_baseUrl/$id/"),
      headers: {'cookie': '$result'},
    );
    if (response.statusCode == 200) {
      final result = jsonDecode(response.body);

      return result['loan Detail']
          .map((loans) => LoansDetailModel.fromJson(loans))
          .toList();
    } else {
      throw Exception('Failed to load Loans Detail ');
    }
  }

  Future<List> updateLoanPlan(int id, LoansDetailModel loans) async {
    final result = await _prefs.getsession();
    final DateFormat formatter = DateFormat('yyyy-MM-dd');
    final String formatted1 = formatter.format(loans.startDate);
    final response = await httpClient.put(
      Uri.parse('$_baseUrl/$id/'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'cookie': '$result',
      },
      body: jsonEncode(<String, dynamic>{
        "amount_of_loan_given": loans.amount,
        "title": "${loans.title}",
        "description": "${loans.description}",
        "deal_done_on": "$formatted1",
        "borrower": "${loans.person}"
      }),
    );
    if (response.statusCode == 200) {
      final result = jsonDecode(response.body);
      return result['loan Detail']
          .map((loans) => LoansDetailModel.fromJson(loans))
          .toList();
    } else {
      throw Exception('Failed to load Saving Detail Plan');
    }
  }

  Future<List> createLoanPlan(LoansDetailModel loans) async {
    final result = await _prefs.getsession();
    final DateFormat formatter = DateFormat('yyyy-MM-dd');
    final String formatted1 = formatter.format(loans.startDate);
    final response = await httpClient.post(
      Uri.parse('$_baseUrl/records/'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'cookie': '$result',
      },
      body: jsonEncode(<String, dynamic>{
        "amount_of_loan_given": loans.amount,
        "title": "${loans.title}",
        "description": "${loans.description}",
        "deal_done_on": "$formatted1",
        "borrower": "${loans.person}"
      }),
    );

    if (response.statusCode == 200) {
      final result = jsonDecode(response.body);
      return [result];
    } else {
      throw Exception('Failed to load Saving Detail Plan');
    }
  }

  Future<String> createDeposit(
      int id, String desc, double amount, DateTime startDate) async {
    final result = await _prefs.getsession();
    final DateFormat formatter = DateFormat('yyyy-MM-dd');
    final String date = formatter.format(startDate);

    final response = await httpClient.post(
      Uri.parse('$_baseUrl/collection/$id/'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'cookie': '$result',
      },
      body: jsonEncode(<String, dynamic>{
        "collected_amount": amount,
        "transaction_date": date,
        "description": "${desc}"
      }),
    );

    if (response.statusCode == 200) {
      final result = jsonDecode(response.body);
      return '$result';
    } else {
      throw Exception('Failed to load Bill records');
    }
  }
}
