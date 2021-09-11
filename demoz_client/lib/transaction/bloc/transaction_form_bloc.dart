import 'package:demoz_client/transaction/bloc/transaction_form_event.dart';
import 'package:demoz_client/transaction/bloc/transaction_form_state.dart';
import 'package:demoz_client/transaction/repository/transaction_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TransactionDetailBloc
    extends Bloc<TransactionDetailEvent, TransactionDetailState> {
  final TransactionRepository transactionRepository;
  TransactionDetailBloc(this.transactionRepository) : super(DetailUnloaded());

  @override
  Stream<TransactionDetailState> mapEventToState(
      TransactionDetailEvent event) async* {
    if (event is DetailLoad) {
      final details = await transactionRepository.getCategorySummery();
      yield DetailLoaded(details[0]);
    }

    if (event is DetailSave) {
      final updated = await transactionRepository.createExpenseDeposit(
        event.id,
        event.amount,
        event.date,
        event.description,
        event.accomplice,
      );
      final details = await transactionRepository.getCategorySummery();
      yield DetailLoaded(details[0]);
    }

    if (event is DetailCancle) {
      final details = await transactionRepository.getCategorySummery();
      yield DetailLoaded(details[0]);
    }
  }
}
