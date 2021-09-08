abstract class SavingDetailEvent {}

class SavingEdit extends SavingDetailEvent {
  final int id;

  SavingEdit(this.id);
}

class SavingEditSave extends SavingDetailEvent {
  final int id;
  final String title;
  final double goal;
  final double saved;
  final String description;
  final double amount;
  final int frequency;
  final DateTime startDate;
  final DateTime endDate;

  SavingEditSave({
    required this.goal,
    required this.saved,
    required this.id,
    required this.title,
    required this.description,
    required this.amount,
    required this.frequency,
    required this.startDate,
    required this.endDate,
  });
}

class SavingEditCancle extends SavingDetailEvent {
  final int id;

  SavingEditCancle(this.id);
}

class SavingDetailLoad extends SavingDetailEvent {
  final int id;

  SavingDetailLoad(this.id);
}

class RefershPage extends SavingDetailEvent {
  final int id;

  RefershPage(this.id);
}
