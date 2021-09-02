abstract class AuthState {}

class RegisterInprogress extends AuthState {}

class Registered extends AuthState {}

class LoggedOut extends AuthState {}

class AuthFailed extends AuthState {
  final String errorMsg;

  AuthFailed({required this.errorMsg});
}
