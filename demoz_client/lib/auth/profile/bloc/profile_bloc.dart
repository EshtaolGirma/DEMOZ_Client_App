import 'package:demoz_client/auth/login/data_provider/login_data_provider.dart';
import 'package:demoz_client/auth/login/repository/login_repository.dart';
import 'package:demoz_client/auth/profile/bloc/profile_event.dart';
import 'package:demoz_client/auth/profile/bloc/profile_state.dart';
import 'package:demoz_client/auth/profile/repository/profile_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final ProfileRepository profileRepository;
  ProfileBloc({required this.profileRepository}) : super(LoadingProfile());

  @override
  Stream<ProfileState> mapEventToState(ProfileEvent event) async* {
    if (event is LoadProfileEvent) {
      final r = await profileRepository.getUserInfo();

      yield LoadedState(user: r);
    }
    if (event is EditProfile) {
      final r = await profileRepository.getUserInfo();
      yield EditinState(user: r);
    }

    if (event is SaveProfile) {
      await profileRepository.updateUserInfo(event.full_name, event.pass);
      final r = await profileRepository.getUserInfo();
      yield LoadedState(user: r);
    }
    if (event is LoggingOut) {
      await profileRepository.logoutRoute();

      yield LoggedOut();
    }

    if (event is DeletingAccount) {
      await profileRepository.deleteRoute();

      yield LoggedOut();
    }
  }
}
