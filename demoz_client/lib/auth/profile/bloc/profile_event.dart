abstract class ProfileEvent {}

class LoadedEvent extends ProfileEvent {
  final String fullname;
  final String email;
  final String password;
  final double expense;
  final double income;

  LoadedEvent(
      {required this.email,
      required this.password,
      required this.fullname,
      required this.expense,
      required this.income});
}

class LoadProfileEvent extends ProfileEvent {}

class EditProfile extends ProfileEvent {}

class SaveProfile extends ProfileEvent {
  final String full_name;
  final String pass;

  SaveProfile({
    required this.full_name,
    required this.pass,
  });
}

class LoggingOut extends ProfileEvent{}

class DeletingAccount extends ProfileEvent{}
