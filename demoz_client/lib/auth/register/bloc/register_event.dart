abstract class AuthEvent {}

class RegisterEvent extends AuthEvent {
  final String fname;
  final String lname;
  final String email;
  final String password;
  final String confirmPassword;

  RegisterEvent({required this.email, required this.password, required this.confirmPassword, required this.fname, required this.lname});
}
