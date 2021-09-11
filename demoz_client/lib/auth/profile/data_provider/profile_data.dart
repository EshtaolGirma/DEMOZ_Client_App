import 'dart:convert';

import 'package:demoz_client/auth/profile/models/profile_model.dart';
import 'package:demoz_client/bills/models/bills_model.dart';
import 'package:demoz_client/sharedPreferences.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class ProfileDataProvider {
  final _baseUrl = 'http://127.0.0.1:8000/account';
  final http.Client httpClient;

  ProfileDataProvider({required this.httpClient});

  Future<List> getUserInfo() async {
    final response = await httpClient.get(Uri.parse('$_baseUrl/'));
    if (response.statusCode == 200) {
      final result = jsonDecode(response.body);
      List userInfo = [result['user']];
      return result['user'].map((user) => ProfileModel.fromJson(user)).toList();
    } else {
      throw Exception('Failed to load Bills List');
    }
  }

  Future<String> updateUserInfo(String e, String p) async {
    final f_name = e.split(' ')[0];
    final l_name = e.split(' ')[1];
    final response = await httpClient.put(
      Uri.parse('$_baseUrl/'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        "First_Name": f_name,
        'Email': '',
        "Last_Name": l_name,
        "Password": p,
      }),
    );
    if (response.statusCode == 200) {
      return '';
    } else {
      throw Exception('Failed to load Saving Detail Plan');
    }
  }

  Future<String> logoutRoute() async {
    final _prefs = sharedPreference();
    final result = await _prefs.getsession();
    final response = await httpClient.post(
        Uri.parse("http://0.0.0.0:8000/auth/logout/"),
        headers: {'cookie': '$result'});
    if (response.statusCode == 200) {
      final result1 = jsonDecode(response.body);

      await _prefs.removeSession();

      return '$result1';
    } else {
      throw Exception('Login Faild');
    }
  }

  Future<String> deleteRoute() async {
    final _prefs = sharedPreference();
    final result = await _prefs.getsession();
    final response = await httpClient
        .delete(Uri.parse("$_baseUrl/"), headers: {'cookie': '$result'});
    if (response.statusCode == 200) {
      final result1 = jsonDecode(response.body);

      await _prefs.removeSession();

      return '$result1';
    } else {
      throw Exception('Login Faild');
    }
  }
}
