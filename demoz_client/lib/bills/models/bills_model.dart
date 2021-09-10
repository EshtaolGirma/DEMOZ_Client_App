import 'package:equatable/equatable.dart';
import 'package:intl/intl.dart';

class BillPlanModel extends Equatable {
  final int id;
  final String title;
  final double amount;
  final DateTime next_pay_day;

  BillPlanModel(
      {required this.id,
      required this.title,
      required this.amount,
      required this.next_pay_day});

  @override
  List<Object?> get props => [
        title,
        amount,
        next_pay_day,
        id,
      ];

  factory BillPlanModel.fromJson(Map<String, dynamic> json) {
    DateFormat inputFormat = DateFormat('yyyy-MM-dd');
    return BillPlanModel(
      id: json['id'],
      title: json['title'],
      amount: json['bill_amount'].toDouble(),
      next_pay_day: inputFormat.parse(json['Deposit Date'][2].toString() +
          '-' +
          json['Deposit Date'][1].toString() +
          '-' +
          json['Deposit Date'][0].toString()),
    );
  }

  @override
  String toString() => '$id, $title, $amount, $next_pay_day';
}

class BillDetailModel extends Equatable {
  final String title;
  final double amount;
  final int frequency;
  final String description;
  final DateTime startDate;
  final DateTime next_pay_day;
  final List deposit;

  BillDetailModel({
    required this.title,
    required this.amount,
    required this.frequency,
    required this.description,
    required this.next_pay_day,
    required this.startDate,
    required this.deposit,
  });

  BillDetailModel.update({
    required this.title,
    required this.amount,
    required this.frequency,
    required this.description,
    required this.next_pay_day,
    required this.startDate,
    this.deposit = const [],
  });

  @override
  List<Object?> get props => [
        title,
        amount,
        next_pay_day,
        startDate,
        description,
        deposit,
      ];

  factory BillDetailModel.fromJson(Map<String, dynamic> json) {
    DateFormat inputFormat = DateFormat('yyyy-MM-dd');
    return BillDetailModel(
      title: json['Title'],
      frequency: json['Frequency'],
      amount: json['Payment Amount'].toDouble(),
      description: json['Description'],
      deposit: json['Payments'],
      startDate: inputFormat.parse(json['Bill Started On'][2].toString() +
          '-' +
          json['Bill Started On'][1].toString() +
          '-' +
          json['Bill Started On'][0].toString()),
      next_pay_day: inputFormat.parse(
          json['Next Payment date On'][2].toString() +
              '-' +
              json['Next Payment date On'][1].toString() +
              '-' +
              json['Next Payment date On'][0].toString()),
    );
  }

  @override
  String toString() =>
      '$title, $amount, $frequency, $description, $startDate $next_pay_day, $deposit';
}

class BillDepositModel extends Equatable {
  final double amount;
  final DateTime deposit_day;
  final String desc;

  BillDepositModel({
    required this.amount,
    required this.deposit_day,
    required this.desc,
  });

  @override
  List<Object?> get props => [
        desc,
        amount,
        deposit_day,
      ];

  factory BillDepositModel.fromJson(Map<String, dynamic> json) {
    DateFormat inputFormat = DateFormat('yyyy-MM-dd');
    return BillDepositModel(
      desc: json['description'],
      amount: json['Deposited Amount'],
      deposit_day: inputFormat.parse(json['Deposit Date'][2].toString() +
          '-' +
          json['Saving Started On'][1].toString() +
          '-' +
          json['Saving Started On'][0].toString()),
    );
  }
}
