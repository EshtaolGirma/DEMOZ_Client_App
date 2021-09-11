abstract class ProfileState {}

class LoadingProfile extends ProfileState {}

class EditinState extends ProfileState {
  final List user;

  EditinState({required this.user});
}

class LoadedState extends ProfileState {
  final List user;

  LoadedState({required this.user});
}

class LoadFailed extends ProfileState {
  final String errorMsg;

  LoadFailed({required this.errorMsg});
}

class LoggedOut extends ProfileState {}

class DeteledAccount extends ProfileState {}
