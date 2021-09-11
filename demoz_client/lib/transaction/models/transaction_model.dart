import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

@immutable
class CategorySummery extends Equatable {
  CategorySummery({
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

  factory CategorySummery.fromJson(Map<String, dynamic> json) {
    return CategorySummery(
      category: json['category'],
      total: json['total'].toDouble(),
      budget: json['budget'] != null ? json['budget'] : 0,
    );
  }

  @override
  String toString() => '$category,  $total, $budget';
}

@immutable
class TransactionCategoryDetail extends Equatable {
  TransactionCategoryDetail({
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

  factory TransactionCategoryDetail.fromJson(Map<String, dynamic> json) {
    DateFormat inputFormat = DateFormat('yyyy-MM-dd');
    return TransactionCategoryDetail(
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
