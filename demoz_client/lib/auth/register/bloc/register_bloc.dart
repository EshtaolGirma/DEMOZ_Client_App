import 'package:demoz_client/auth/register/bloc/register_event.dart';
import 'package:demoz_client/auth/register/bloc/register_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterBloc extends Bloc<AuthEvent, AuthState> {
  RegisterBloc() : super(LoggedOut());

  @override
  Stream<AuthState> mapEventToState(AuthEvent event) async* {
    if (event is RegisterEvent) {
      final fname = event.fname;
      final lname = event.lname;
      final email = event.email;
      final password = event.password;
      final confirmPassword = event.confirmPassword;

      // reaching to the backend
      yield RegisterInprogress();
      await Future.delayed(Duration(seconds: 2));
      if (fname == "redi") {
        if (lname == "bef") {
          if (email == "hello@world.com") {
            if (password == "12345678" && confirmPassword == "12345678") {
              
              // login successfuly
              yield Registered();
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
  }
}
