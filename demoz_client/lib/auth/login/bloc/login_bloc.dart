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

      // final bye = await loginRepository.logoutRoute();
      // print(bye);

      // reaching to the backend
      // yield LoginInprogress();
      // await Future.delayed(Duration(seconds: 2));

      // if (email == "hello@world.com") {
      //   if (password == "12345678") {
      //     // login successfuly
      //     yield LoggedIn();
      //   } else {
      //     // wrong password

      //     yield AuthFailed(errorMsg: 'Wrong password');
      //   }
      // } else {
      //   // account doesn't exists
      //   yield AuthFailed(errorMsg: 'Account does not exist');
      // }
      // await Future.delayed(Duration(seconds: 2));
      // yield LoggedOut();
    }
  }
}
