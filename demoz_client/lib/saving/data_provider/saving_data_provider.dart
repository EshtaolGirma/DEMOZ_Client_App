import 'dart:convert';

import 'package:demoz_client/saving/models/saving_model.dart';
import 'package:demoz_client/sharedPreferences.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class SavingDataProvider {
  final _baseUrl = 'http://127.0.0.1:8000/saving';
  final http.Client httpClient;
  final _prefs = sharedPreference();
  SavingDataProvider({required this.httpClient});

  Future<List> getSavingPlan() async {
    final result = await _prefs.getsession();
    final response = await httpClient.get(
      Uri.parse("$_baseUrl/plans/"),
      headers: {'cookie': '$result'},
    );

    if (response.statusCode == 200) {
      final savingPlans = jsonDecode(response.body);
      return savingPlans['Saving Plans']
          .map((saving) => SavingPlanModel.fromJson(saving))
          .toList();
    } else {
      throw Exception('Failed to load Saving Plan');
    }
  }

  Future<List> getSavingPlanDetails(int id) async {
    final result = await _prefs.getsession();
    final response = await httpClient.get(
      Uri.parse("$_baseUrl/plan/$id/"),
      headers: {'cookie': '$result'},
    );
    if (response.statusCode == 200) {
      final savingPlans = jsonDecode(response.body);
      return savingPlans['Plan']
          .map((savingDetail) => SavingDetailModel.fromJson(savingDetail))
          .toList();
      // return [savingPlans['Plan']];
    } else {
      throw Exception('Failed to load Saving Detail Plan');
    }
  }

  Future<List> updateSavingPlan(int id, SavingDetailModel save) async {
    final result = await _prefs.getsession();
    final DateFormat formatter = DateFormat('yyyy-MM-dd');
    final String formatted1 = formatter.format(save.startDate);
    final String formatted2 = formatter.format(save.endDate);
    final response = await httpClient.put(
      Uri.parse('$_baseUrl/plan/$id/'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'cookie': '$result'
      },
      body: jsonEncode(<String, dynamic>{
        "saving_goal": save.goal,
        "initial_amount": save.saved,
        "one_time_deposit": save.amount,
        "title": "${save.title}",
        "description": "${save.description}",
        "frequency": save.frequency,
        "starting_date": "$formatted1",
        "ending_date": "$formatted2"
      }),
    );

    if (response.statusCode == 200) {
      final result = jsonDecode(response.body);
      return result['Plan']
          .map((savingDetail) => SavingDetailModel.fromJson(savingDetail))
          .toList();
      // return [result];
    } else {
      throw Exception('Failed to load Saving Detail Plan');
    }
  }

  Future<List> createSavingPlan(SavingDetailModel save) async {
    final result = await _prefs.getsession();
    final DateFormat formatter = DateFormat('yyyy-MM-dd');
    final String formatted1 = formatter.format(save.startDate);
    final String formatted2 = formatter.format(save.endDate);
    final response = await httpClient.post(
      Uri.parse('$_baseUrl/plans/'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'cookie': '$result'
      },
      body: jsonEncode(<String, dynamic>{
        "saving_goal": save.goal,
        "initial_amount": save.saved,
        "one_time_deposit": save.amount,
        "title": "${save.title}",
        "description": "${save.description}",
        "frequency": save.frequency,
        "starting_date": "$formatted1",
        "ending_date": "$formatted2"
      }),
    );

    if (response.statusCode == 200) {
      final result = jsonDecode(response.body);
      return [result];
    } else {
      throw Exception('Failed to load Saving Detail Plan');
    }
  }

  Future<String> createDeposit(int id, SavingDepositModel depo) async {
    final result = await _prefs.getsession();
    final DateFormat formatter = DateFormat('yyyy-MM-dd');
    final String date = formatter.format(depo.deposit_day);

    final response = await httpClient.post(
      Uri.parse('$_baseUrl/transaction/$id/'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'cookie': '$result'
      },
      body: jsonEncode(<String, dynamic>{
        "deposited_amount": depo.amount,
        "deposit_day": date,
        "description": "${depo.desc}"
      }),
    );

    if (response.statusCode == 200) {
      final result = jsonDecode(response.body);
      return '$result';
    } else {
      throw Exception('Failed to load Saving Detail Plan');
    }
  }
}
