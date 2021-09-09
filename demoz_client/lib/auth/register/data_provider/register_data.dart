import 'dart:convert';

import 'package:demoz_client/sharedPreferences.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class RegisterDataProvider {
  final _baseUrl = 'http://0.0.0.0:8000/account/SignUp/';
  final http.Client httpClient;

  var header_i;

  RegisterDataProvider({required this.httpClient});

  Future<String> register(
      String f_name, String l_name, String email, String pass) async {
    final response = await httpClient.post(
      Uri.parse("$_baseUrl"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        "First_Name": "$f_name",
        "Last_Name": "$l_name",
        "Email": "$email",
        "Password": "$pass"
      }),
    );

    if (response.statusCode == 200) {
      final session = response.headers;
      final _prefs = sharedPreference();
      header_i = session['set-cookie'];
      final x = header_i.split(';')[0];
      await _prefs.saveSession('session');
      await _prefs.saveSession(x);

      return '${response.body}';
    } else {
      throw Exception('Failed to Register');
    }
  }
}
