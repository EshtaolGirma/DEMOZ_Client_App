import 'package:demoz_client/auth/profile/data_provider/profile_data.dart';

class ProfileRepository {
  final ProfileDataProvider profileDataProvider;

  ProfileRepository({required this.profileDataProvider});

  Future<List> getUserInfo() async {
    return await profileDataProvider.getUserInfo();
  }

  Future<String> updateUserInfo(String e, String p) async {
    return await profileDataProvider.updateUserInfo(e, p);
  }

  Future<String> logoutRoute() async {
    return await profileDataProvider.logoutRoute();
  }

  Future<String> deleteRoute() async {
    return await profileDataProvider.deleteRoute();
  }
}
