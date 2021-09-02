
import 'package:demoz_client/auth/login/bloc/login_event.dart';
import 'package:demoz_client/auth/login/bloc/login_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(LoggedOut());

  @override
  Stream<AuthState> mapEventToState(AuthEvent event) async* {
    if (event is LoginEvent) {
      final email = event.email;
      final password = event.password;

      // reaching to the backend
      yield LoginInprogress();
      await Future.delayed(Duration(seconds: 2));

      if (email == "hello@world.com") {
        if (password == "123456") {
          // login successfuly
          yield LoggedIn();
        } else {
          // wrong password

          yield AuthFailed(errorMsg: 'Wrong password');
        }
      } else {
        // account doesn't exists
        yield AuthFailed(errorMsg: 'Account does not exist');
      }
      await Future.delayed(Duration(seconds: 2));
      yield LoggedOut();
    }
  }
}
