import 'package:demoz_client/transaction/bloc/transaction_event.dart';
import 'package:demoz_client/transaction/bloc/transaction_state.dart';
import 'package:demoz_client/transaction/repository/transaction_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TransactionBloc extends Bloc<TransactionEvent, TransactionState> {
  final TransactionRepository transactionRepository;

  TransactionBloc({required this.transactionRepository})
      : assert(transactionRepository != null),
        super(TransactionUnloaded());

  @override
  Stream<TransactionState> mapEventToState(TransactionEvent event) async* {
    if (state is TransactionUnloaded) {
      try {
        yield TransactionLoading();
        final transactions = await transactionRepository.getCategorySummery();
        print(transactions);
        yield TransactionLoaded(transactions);
      } catch (_) {
        print(_);
      }
    }
  }
}

// class TransactionCategoryBloc
//     extends Bloc<TransactionCategoryDetailEvent, TransactionCategoryDetailState> {
//   final TransactionRepository TransactionRepository;

//   TransactionCategoryBloc({required this.TransactionRepository})
//       : super(TransactionDetailUnloaded());

//   @override
//   Stream<TransactionCategoryDetailState> mapEventToState(
//       TransactionCategoryDetailEvent event) async* {
//     if (event is TransactionDetailLoad) {
//       try {
//         final TransactionsDetail = await TransactionRepository.getCategoryDetail(
//             event.category_id, event.name);

//         yield TransactionDetailLoaded(TransactionsDetail);
//       } catch (_) {
//         print(_);
//       }
//     }

//     if (event is TransactionDetailClick) {
//       yield TransactionDetailClicked(event.Transaction_id, event.Transaction_cat);
//     }
//   }
// }
