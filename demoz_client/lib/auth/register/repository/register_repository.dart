import 'package:demoz_client/auth/register/data_provider/register_data.dart';

class RegisterRepository {
  final RegisterDataProvider registerDataProvider;

  RegisterRepository({required this.registerDataProvider});

  Future<String> register(
      String f_name, String l_name, String email, String pass) async {
    return await registerDataProvider.register(f_name, l_name, email, pass);
  }
}
