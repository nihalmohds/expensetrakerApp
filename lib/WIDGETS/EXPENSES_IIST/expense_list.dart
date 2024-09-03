import 'package:expsnse_tracker/WIDGETS/EXPENSES_IIST/expense_item.dart';
import 'package:expsnse_tracker/models/expense.dart';
import 'package:flutter/material.dart';

class ExpenseList extends StatelessWidget {
  const ExpenseList({super.key, required this.expenses,required this.onremoveexpense});

  final List<Expense> expenses;
  final void Function(Expense expense) onremoveexpense;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: expenses.length,
        itemBuilder: (ctx, index) => Dismissible(
            key: ValueKey(expenses[index]),
            onDismissed: (direction){
              onremoveexpense(expenses[index]);
            },
            child: ExpenseItem(expenses[index])));
  }
}
