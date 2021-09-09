import 'package:shared_preferences/shared_preferences.dart';

class sharedPreference {
  Future saveSession(String session) async {
    final preferences = await SharedPreferences.getInstance();
    await preferences.setString('session', session);
    return "Session Saved";
  }

  Future getsession() async {
    final preferences = await SharedPreferences.getInstance();
    String? session = await preferences.getString('session');
    
    return session;
  }

  Future removeSession() async {
    final preferences = await SharedPreferences.getInstance();
    await preferences.clear();
    return "Session removed";
  }
}