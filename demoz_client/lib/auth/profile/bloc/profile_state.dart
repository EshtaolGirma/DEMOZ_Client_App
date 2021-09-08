abstract class ProfileState {}

class LoadingProfile extends ProfileState {}

class LoadedState extends ProfileState {
  final String fullname;

  LoadedState({required this.fullname});
}

class LoadFailed extends ProfileState {
  final String errorMsg;

  LoadFailed({required this.errorMsg});
}
