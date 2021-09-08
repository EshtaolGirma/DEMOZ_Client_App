import 'package:http/http.dart' as http;

class SavingDataProvider {
  final _baseUrl = 'http://127.0.0.1:8000/';
  final http.Client httpClient;

  SavingDataProvider(this.httpClient);

  Future<List> getSavingPlans(int id) async {
    final response =
        await httpClient.get(Uri.parse('$_baseUrl/'));
    if (response.statusCode == 200) {
      return [];
    } else {
      throw Exception('Failed to load expense detail');
    }
    // return ['go'];
  }
}
