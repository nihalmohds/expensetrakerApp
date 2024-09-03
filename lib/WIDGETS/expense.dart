import 'package:expsnse_tracker/WIDGETS/EXPENSES_IIST/expense_list.dart';
import 'package:expsnse_tracker/WIDGETS/new_expense.dart';
import 'package:expsnse_tracker/models/expense.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class Expenses extends StatefulWidget {
  const Expenses({super.key});

  @override
  State<Expenses> createState() => _ExpensesState();
}

class _ExpensesState extends State<Expenses> {
  final List<Expense> _registeredexpense = [
    Expense(
      title: "flutter corse",
      amount: 19.9,
      date: DateTime.now(),
      Category: categorys.work,
    ),
    Expense(
      title: "cinema",
      amount: 15.3,
      date: DateTime.now(),
      Category: categorys.leisure,
    ),
  ];

  void _openaddexepense() {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (ctx) => NewExpense(
        onnaddexpenses: _addexpense,
      ),
    );
  }

  void _addexpense(Expense expense) {
    setState(() {
      _registeredexpense.add(expense);
    });
  }

  void _removeexpense(Expense expense) {

    final expenseindex=_registeredexpense.indexOf(expense);
    setState(() {
      _registeredexpense.remove(expense);
    });
  ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(duration: Duration(seconds: 3),
        content: Text("expense deleted"),
        action: SnackBarAction(label: "undo", onPressed: (){
          setState(() {
            _registeredexpense.insert(expenseindex, expense);
          });
        }),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget maincontent = Center(child: Text("no expenses fount . start add"));

    if (_registeredexpense.isNotEmpty) {
      maincontent = ExpenseList(
        expenses: _registeredexpense,
        onremoveexpense: _removeexpense,
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("flutter adding expense"),
        actions: [
          IconButton(onPressed: _openaddexepense, icon: Icon(Icons.add))
        ],
      ),
      body: Column(
        children: [
          Text(" The Chart"),
          Expanded(
            child: maincontent,
          )
        ],
      ),
    );
  }
}
