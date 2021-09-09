

import 'package:demoz_client/auth/profile/data_provider/profile_data.dart';

class ProfileRepository {
  final ProfileDataProvider profileDataProvider;

  ProfileRepository({required this.profileDataProvider});

  Future LoadMyProfilePage(String email) async {}
}
