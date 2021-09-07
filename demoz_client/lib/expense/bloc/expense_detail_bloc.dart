import 'package:demoz_client/expense/bloc/expense_detail_state.dart';
import 'package:demoz_client/expense/bloc/expense_detail_event.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ExpenseDetailBloc extends Bloc<ExpenseDetailEvent, ExpenseDetailState> {
  ExpenseDetailBloc(ExpenseDetailState initialState) : super(DetailUnloaded());

  @override
  Stream<ExpenseDetailState> mapEventToState(ExpenseDetailEvent event) async* {
    if (event is DetailLoad) {
      await Future.delayed(Duration(seconds: 6));
      yield DetailLoaded();
    }
    if (event is DetailEdit) {
      yield DetailEditing();
    }

    if (event is DetailSave) {
      yield DetailLoaded();
    }

    if (event is DetailCancle) {
      yield DetailLoaded();
    }
  }
}
