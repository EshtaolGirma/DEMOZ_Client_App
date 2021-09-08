import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:intl/intl.dart';

class SavingPlanModel extends Equatable {
  final int id;
  final String title;
  final double goal;
  final double saved;

  SavingPlanModel(
      {required this.id,
      required this.title,
      required this.goal,
      required this.saved});

  @override
  List<Object?> get props => [
        title,
        goal,
        saved,
        id,
      ];

  factory SavingPlanModel.fromJson(Map<String, dynamic> json) {
    return SavingPlanModel(
      id: json['id'],
      title: json['title'],
      goal: json['Goal'].toDouble(),
      saved: json['Saved'].toDouble(),
    );
  }

  @override
  String toString() => '$id, $title, $goal, $saved';
}

class SavingDetailModel extends Equatable {
  final List deposit;
  final String title;
  final String description;
  final double saved;
  final double goal;
  final int frequency;
  final double amount;
  final DateTime startDate;
  final DateTime endDate;

  SavingDetailModel({
    required this.deposit,
    required this.title,
    required this.goal,
    required this.frequency,
    required this.amount,
    required this.description,
    required this.saved,
    required this.startDate,
    required this.endDate,
  });

  SavingDetailModel.update({
    this.deposit = const [],
    required this.title,
    required this.goal,
    required this.frequency,
    required this.amount,
    required this.description,
    required this.saved,
    required this.startDate,
    required this.endDate,
  });

  @override
  List<Object?> get props => [
        title,
        goal,
        description,
        saved,
        frequency,
        amount,
        startDate,
        endDate,
        deposit,
      ];

  factory SavingDetailModel.fromJson(Map<String, dynamic> json) {
    DateFormat inputFormat = DateFormat('yyyy-MM-dd');
    // final deposits = jsonDecode(json['Deposits']);
    return SavingDetailModel(
      title: json['Title'],
      description: json['Description'],
      goal: json['Goal'].toDouble(),
      saved: json['Saved Amount'].toDouble(),
      frequency: json['Frequency of Deposit'],
      amount: json['Amount to Deposit'],
      startDate: inputFormat.parse(json['Saving Started On'][2].toString() +
          '-' +
          json['Saving Started On'][1].toString() +
          '-' +
          json['Saving Started On'][0].toString()),
      endDate: inputFormat.parse(json['Saving Ending On'][2].toString() +
          '-' +
          json['Saving Ending On'][1].toString() +
          '-' +
          json['Saving Ending On'][0].toString()),
      deposit: json['Deposits'],
    );
  }
  @override
  String toString() =>
      '$title, $goal, $saved, $frequency, $amount, $startDate, $endDate ,$description $deposit';
}

class SavingDepositModel extends Equatable {
  final double amount;
  final DateTime deposit_day;
  final int id;

  SavingDepositModel({
    required this.amount,
    required this.deposit_day,
    required this.id,
  });

  @override
  // TODO: implement props
  List<Object?> get props => [
        id,
        amount,
        deposit_day,
      ];

  factory SavingDepositModel.fromJson(Map<String, dynamic> json) {
    DateFormat inputFormat = DateFormat('yyyy-MM-dd');
    return SavingDepositModel(
      id: json['id'],
      amount: json['Deposited Amount'],
      deposit_day: inputFormat.parse(json['Deposit Date'][2].toString() +
          '-' +
          json['Saving Started On'][1].toString() +
          '-' +
          json['Saving Started On'][0].toString()),
    );
  }
}
