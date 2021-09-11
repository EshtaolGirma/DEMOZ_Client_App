import 'package:demoz_client/expense/bloc/expense_state.dart';
import 'package:flutter/material.dart';

abstract class ExpenseEvent {}

class ExpenseLoad extends ExpenseEvent {}

abstract class ExpenseCategoryDetailEvent {}

class ExpenseDetailLoad extends ExpenseCategoryDetailEvent {
  final int category_id;
  final String name;

  ExpenseDetailLoad(this.category_id, this.name);
}

class ExpenseDetailClick extends ExpenseCategoryDetailEvent {
  final int expense_id;
  final String expense_cat;

  ExpenseDetailClick(this.expense_id, this.expense_cat);
}
