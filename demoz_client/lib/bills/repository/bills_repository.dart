import 'package:demoz_client/bills/data_provider/bills_data.dart';
import 'package:demoz_client/bills/models/bills_model.dart';

class BillsRepository {
  final BillsDataProvider billsDataProvider;

  BillsRepository({required this.billsDataProvider});

  Future<List> getBillPlans() async {
    return await billsDataProvider.getBillPlans();
  }

  Future<List> getBillPlanDetails(int id) async {
    return await billsDataProvider.getBillPlanDetails(id);
  }

  Future<List> updateBillPlan(int id, BillDetailModel sa) async {
    return await billsDataProvider.updateBillPlan(id, sa);
  }

  Future<List> createBillPlan(BillDetailModel save) async {
    return await billsDataProvider.createBillPlan(save);
  }

  Future<String> createDeposit(
      int id, String desc, double amount, DateTime startDate) async {
    return await billsDataProvider.createDeposit(id, desc, amount, startDate);
  }
}
