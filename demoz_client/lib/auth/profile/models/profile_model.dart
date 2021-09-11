import 'package:equatable/equatable.dart';

class ProfileModel extends Equatable {
  final String full_name;
  final String email;
  final double income;
  final double expense;

  ProfileModel({
    required this.full_name,
    required this.email,
    required this.income,
    required this.expense,
  });

  @override
  // TODO: implement props
  List<Object?> get props => [
        full_name,
        email,
        income,
        expense,
      ];
  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    return ProfileModel(
      full_name: json['Full Name'],
      email: json['Email'],
      income: json['Income'],
      expense: json['Expense'],
    );
  }

  @override
  String toString() => '$full_name, $email, $income, $expense';
}
