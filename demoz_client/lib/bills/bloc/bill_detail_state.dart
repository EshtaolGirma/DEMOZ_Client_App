abstract class BillDetailState {}

class BillDetailLoaded extends BillDetailState {
  final List list;
  final int id;

  BillDetailLoaded(this.list, this.id);
}

class BillDetailLoading extends BillDetailState {}

class BillDetailUnloaded extends BillDetailState {}

class BillDetailFailed extends BillDetailState {
  final String errorMsg;

  BillDetailFailed(this.errorMsg);
}

class BillDetailEditing extends BillDetailState {
  final List list;
  final int ids;

  BillDetailEditing(this.list, this.ids);
}
