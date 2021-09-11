import 'dart:convert';

import 'package:demoz_client/bills/models/bills_model.dart';
import 'package:demoz_client/sharedPreferences.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class BillsDataProvider {
  final _baseUrl = 'http://127.0.0.1:8000/bills';
  final http.Client httpClient;
  final _prefs = sharedPreference();
  BillsDataProvider({required this.httpClient});

  Future<List> getBillPlans() async {
    final result = await _prefs.getsession();
    final response = await httpClient.get(
      Uri.parse('$_baseUrl/'),
      headers: {'cookie': '$result'},
    );
    if (response.statusCode == 200) {
      final result = jsonDecode(response.body);
      return result['Bills']
          .map((bills) => BillPlanModel.fromJson(bills))
          .toList();
    } else {
      throw Exception('Failed to load Bills List');
    }
  }

  Future<List> getBillPlanDetails(int id) async {
    final result = await _prefs.getsession();
    final response = await httpClient.get(
      Uri.parse("$_baseUrl/$id/"),
      headers: {'cookie': '$result'},
    );
    if (response.statusCode == 200) {
      final result = jsonDecode(response.body);
      return result['Bill']
          .map((billDetail) => BillDetailModel.fromJson(billDetail))
          .toList();
    } else {
      throw Exception('Failed to load Bills Detail ');
    }
  }

  Future<List> updateBillPlan(int id, BillDetailModel bill) async {
    final result = await _prefs.getsession();
    final DateFormat formatter = DateFormat('yyyy-MM-dd');
    final String formatted1 = formatter.format(bill.startDate);
    final response = await httpClient.put(
      Uri.parse('$_baseUrl/$id/'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'cookie': '$result',
      },
      body: jsonEncode(<String, dynamic>{
        "payment_amount": bill.amount,
        "bill_title": "${bill.title}",
        "bill_description": "${bill.description}",
        "frequency": bill.frequency,
        "starting_date": "$formatted1",
      }),
    );
    if (response.statusCode == 200) {
      final result = jsonDecode(response.body);
      return result['Bill']
          .map((billDetail) => BillDetailModel.fromJson(billDetail))
          .toList();
    } else {
      throw Exception('Failed to load Saving Detail Plan');
    }
  }

  Future<List> createBillPlan(BillDetailModel bill) async {
    final result = await _prefs.getsession();
    final DateFormat formatter = DateFormat('yyyy-MM-dd');
    final String formatted1 = formatter.format(bill.startDate);
    final response = await httpClient.post(
      Uri.parse('$_baseUrl/'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'cookie': '$result',
      },
      body: jsonEncode(<String, dynamic>{
        "payment_amount": bill.amount,
        "bill_title": "${bill.title}",
        "bill_description": "${bill.description}",
        "frequency": bill.frequency,
        "starting_date": "$formatted1",
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
      Uri.parse('$_baseUrl/payment/$id/'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'cookie': '$result'
      },
      body: jsonEncode(<String, dynamic>{
        "bill_amount": amount,
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
