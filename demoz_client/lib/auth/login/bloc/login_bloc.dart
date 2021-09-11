import 'package:demoz_client/auth/login/bloc/login_event.dart';
import 'package:demoz_client/auth/login/bloc/login_state.dart';
import 'package:demoz_client/auth/login/repository/login_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginBloc extends Bloc<AuthEvent, AuthState> {
  final LoginRepository loginRepository;
  LoginBloc({required this.loginRepository}) : super(LoggedOut());

  @override
  Stream<AuthState> mapEventToState(AuthEvent event) async* {
    if (event is LoginEvent) {
      final email = event.email;
      final password = event.password;

      final result = await loginRepository.loginRoute(email, password);
      print(result);
      yield LoggedIn();
    }
  }
}
