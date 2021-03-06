import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

@immutable
class ExpenseCategorySummery extends Equatable {
  ExpenseCategorySummery({
    required this.category,
    required this.total,
    required this.budget,
  });

  final String category;
  final double total;
  final double budget;

  @override
  List<Object> get props => [
        category,
        total,
        budget,
      ];

  factory ExpenseCategorySummery.fromJson(Map<String, dynamic> json) {
    return ExpenseCategorySummery(
      category: json['category'],
      total: json['total'].toDouble(),
      budget: json['budget'] != null ? json['budget'] : 0,
    );
  }

  @override
  String toString() => '$category, $total, $budget';
}

@immutable
class ExpenseCategoryDetail extends Equatable {
  ExpenseCategoryDetail({
    required this.id,
    required this.description,
    required this.amount,
    required this.date,
    required this.accomplice,
  });

  final String description;
  final List accomplice;
  final DateTime date;
  final double amount;
  final int id;

  @override
  List<Object?> get props => [
        id,
        amount,
        description,
        date,
        accomplice,
      ];

  factory ExpenseCategoryDetail.fromJson(Map<String, dynamic> json) {
    DateFormat inputFormat = DateFormat('yyyy-MM-dd');
    return ExpenseCategoryDetail(
        id: json['id'],
        amount: json['Amount'].toDouble(),
        description: json['Description'] != null ? json['Description'] : '...',
        date: inputFormat.parse(json['Year'].toString() +
            '-' +
            json['Month'].toString() +
            '-' +
            json['Day'].toString()),
        accomplice: json['With']);
  }
  @override
  String toString() => '$id, $amount, $description, $date, $accomplice';
}
