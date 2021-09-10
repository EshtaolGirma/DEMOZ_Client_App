import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:intl/intl.dart';

class LoansPlanModel extends Equatable {
  final int id;
  final String title;
  final double amount;
  final String borrower;

  LoansPlanModel(
      {required this.id,
      required this.title,
      required this.amount,
      required this.borrower});

  @override
  List<Object?> get props => [
        title,
        amount,
        borrower,
        id,
      ];

  factory LoansPlanModel.fromJson(Map<String, dynamic> json) {
    return LoansPlanModel(
      id: json['id'],
      title: json['Title'],
      amount: json['Amount'].toDouble(),
      borrower: json['Borrower'],
    );
  }

  LoansPlanModel.update({
    required this.id,
    required this.title,
    required this.amount,
    required this.borrower,
  });

  @override
  String toString() => '$id, $title, $amount, $borrower';
}

class LoansDetailModel extends Equatable {
  final List deposit;
  final String person;
  final String title;
  final String description;
  final double amount;
  final double collected;
  final double uncollected;
  final DateTime startDate;

  LoansDetailModel({
    required this.title,
    required this.description,
    required this.amount,
    required this.collected,
    required this.person,
    required this.uncollected,
    required this.deposit,
    required this.startDate,
  });

  LoansDetailModel.update({
    this.deposit = const [],
    this.uncollected = 0.0,
    required this.collected,
    required this.title,
    required this.person,
    required this.amount,
    required this.description,
    required this.startDate,
  });

  @override
  List<Object?> get props => [
        title,
        description,
        amount,
        collected,
        uncollected,
        startDate,
        deposit,
        person,
      ];

  factory LoansDetailModel.fromJson(Map<String, dynamic> json) {
    DateFormat inputFormat = DateFormat('yyyy-MM-dd');
    // final deposits = jsonDecode(json['Deposits']);
    return LoansDetailModel(
      title: json['Title'],
      description: json['Description'],
      amount: json['Brrowed amount'],
      startDate: inputFormat.parse(json['Loan given On'][2].toString() +
          '-' +
          json['Loan given On'][1].toString() +
          '-' +
          json['Loan given On'][0].toString()),
      deposit: json['loan collection list'],
      collected: json['Collected Amount'],
      uncollected: json['Uncollected Amount'],
      person: json['Borrower'],
    );
  }
  @override
  String toString() =>
      '$title, $amount, $collected, $uncollected, $startDate ,$description $deposit';
}

class SavingDepositModel extends Equatable {
  final double amount;
  final DateTime deposit_day;
  final String desc;

  SavingDepositModel({
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

  factory SavingDepositModel.fromJson(Map<String, dynamic> json) {
    DateFormat inputFormat = DateFormat('yyyy-MM-dd');
    return SavingDepositModel(
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
