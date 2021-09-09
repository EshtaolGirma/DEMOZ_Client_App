import 'package:demoz_client/auth/register/bloc/register_event.dart';
import 'package:demoz_client/auth/register/bloc/register_state.dart';
import 'package:demoz_client/auth/register/repository/register_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterBloc extends Bloc<AuthEvent, AuthState> {
  final RegisterRepository registerRepository;
  RegisterBloc({required this.registerRepository}) : super(LoggedOut());

  @override
  Stream<AuthState> mapEventToState(AuthEvent event) async* {
    if (event is RegisterEvent) {
      final fname = event.fname;
      final lname = event.lname;
      final email = event.email;
      final password = event.password;

      final confirmPassword = event.confirmPassword;
      print('$fname, $lname, $email, $password');

      if (password == confirmPassword) {
        final result =
            await registerRepository.register(fname, lname, email, password);

        print(result);
        yield Registered();
      }
    }
  }
}
