import 'package:demoz_client/loans/data_provider/loans_data.dart';
import 'package:demoz_client/loans/models/loans_model.dart';

class LoansRepository {
  final LoansDataProvider loansDataProvider;

  LoansRepository({required this.loansDataProvider});

  Future<List> getLoanPlans() async {
    return await loansDataProvider.getLoanPlans();
  }

  Future<List> getLoanPlanDetails(int id) async {
    return await loansDataProvider.getLoanPlanDetails(id);
  }

  Future<List> updateLoanPlan(int id, LoansDetailModel sa) async {
    return await loansDataProvider.updateLoanPlan(id, sa);
  }

  Future<List> createLoanPlan(LoansDetailModel save) async {
    return await loansDataProvider.createLoanPlan(save);
  }

  Future<String> createDeposit(
      int id, String desc, double amount, DateTime startDate) async {
    return await loansDataProvider.createDeposit(id, desc, amount, startDate);
  }
}
