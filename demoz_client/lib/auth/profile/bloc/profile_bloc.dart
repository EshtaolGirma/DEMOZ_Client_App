
import 'package:demoz_client/profile/bloc/profile_event.dart';
import 'package:demoz_client/profile/bloc/profile_state.dart';
import 'package:demoz_client/profile/repository/profile_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final ProfileRepository profileRepository;
  ProfileBloc({required this.profileRepository}) : super(LoadingProfile());

  @override
  Stream<ProfileState> mapEventToState(ProfileEvent event) async* {
    if (event is LoadProfileEvent) {
      String email = event.email;
      await Future.delayed(Duration(seconds: 3));
      // var r = await profileRepository.LoadMyProfilePage(email);
      yield LoadedState(fullname: 'rdtvvb');
    }
  }
}
