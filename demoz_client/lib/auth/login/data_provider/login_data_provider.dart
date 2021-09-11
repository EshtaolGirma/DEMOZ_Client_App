import 'dart:convert';

import 'package:demoz_client/sharedPreferences.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class LoginDataProvider {
  final _baseUrl = 'http://0.0.0.0:8000/auth';
  final http.Client httpClient;

  var header_i;

  LoginDataProvider({required this.httpClient});

  Future<String> loginRoute(String email, String pass) async {
    final response =
        await httpClient.post(Uri.parse("$_baseUrl/login/$email/$pass/"));

    if (response.statusCode == 200) {
      final session = response.headers;
      final _prefs = sharedPreference();
      header_i = session['set-cookie'];
      final x = header_i.split(';')[0];
      await _prefs.saveSession('session');
      await _prefs.saveSession(x);

      final result = await _prefs.getsession();

      final respo = await httpClient.get(
          Uri.parse('http://0.0.0.0:8000/account/'),
          headers: {'cookie': '$result'});

      return '${respo.body}';
    } else {
      throw Exception('Failed to load Saving Plan');
    }
  }

  Future<String> logoutRoute() async {
    final _prefs = sharedPreference();
    final result = await _prefs.getsession();
    final response = await httpClient
        .post(Uri.parse("$_baseUrl/logout/"), headers: {'cookie': '$result'});
    if (response.statusCode == 200) {
      final result1 = jsonDecode(response.body);

      return '$result1';
    } else {
      throw Exception('Login Faild');
    }
  }
}
