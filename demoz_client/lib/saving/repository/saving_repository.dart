import 'package:demoz_client/saving/data_provider/saving_data_provider.dart';
import 'package:demoz_client/saving/models/saving_model.dart';

class SavingRepository {
  final SavingDataProvider savingDataProvider;

  SavingRepository({required this.savingDataProvider});

  Future<List> getSavingPlan() async {
    return await savingDataProvider.getSavingPlan();
  }

  Future<List> getSavingPlanDetails(int id) async {
    return await savingDataProvider.getSavingPlanDetails(id);
  }

  Future<List> updateSavingPlan(int id, SavingDetailModel sa) async {
    return await savingDataProvider.updateSavingPlan(id, sa);
  }

  Future<List> createSavingPlan(SavingDetailModel save) async {
    return await savingDataProvider.createSavingPlan(save);
  }
}
