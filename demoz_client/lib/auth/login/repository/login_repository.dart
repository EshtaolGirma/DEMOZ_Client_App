import 'package:demoz_client/auth/login/data_provider/login_data_provider.dart';

class LoginRepository {
  final LoginDataProvider loginDataProvider;

  LoginRepository({required this.loginDataProvider});

  Future<String> loginRoute(String email, String pass) async {
    return await loginDataProvider.loginRoute(email, pass);
  }
}
