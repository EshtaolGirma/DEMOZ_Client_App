import 'package:demoz_client/saving/data_provider/saving_data.dart';

class SavingRepository {
  final SavingDataProvider savingDataProvider;

  SavingRepository({required this.savingDataProvider});

  Future<List> getSavingPlans(int id) async {
    return await savingDataProvider.getSavingPlans(id);
  }

}
