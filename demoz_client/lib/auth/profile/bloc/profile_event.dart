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

class LoadProfileEvent extends ProfileEvent {
  final String email;

  LoadProfileEvent({required this.email});
}
