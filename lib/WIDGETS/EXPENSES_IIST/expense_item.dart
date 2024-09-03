import 'package:expsnse_tracker/WIDGETS/expense.dart';
import 'package:expsnse_tracker/models/expense.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class ExpenseItem extends StatelessWidget {
  const ExpenseItem(this.expense, {super.key});

  final Expense expense;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: Column(
          children: [
            Text(expense.title),
            SizedBox(
              height: 10,
            ),
            Row(
              children: [Text("${expense.amount.toStringAsFixed(2)}"),const Spacer() , Row(
                children: [
                  Icon(caagoryicons[expense.Category]),
                  SizedBox(width: 8,),
                  Text(expense.formatedate)
                ],
              )],
              
            )
          ],
        ),
      ),
    );
  }
}
