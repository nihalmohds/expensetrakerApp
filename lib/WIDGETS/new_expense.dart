import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:expsnse_tracker/models/expense.dart';

class NewExpense extends StatefulWidget {
  const NewExpense({
    super.key,
    required this.onnaddexpenses,
  });

  final void Function(Expense expense) onnaddexpenses;

  @override
  State<NewExpense> createState() => _NewExpenseState();
}

class _NewExpenseState extends State<NewExpense> {
  final _titlecontroller = TextEditingController();

  final _amountcontrller = TextEditingController();

  DateTime? _sleectedate;
  categorys _sleectedcatagory = categorys.leisure;

  void _presentdatepicker() async {
    final now = DateTime.now();
    final firstdate = DateTime(now.year - 1, now.month, now.day);

    final pickedate = await showDatePicker(
        context: context,
        firstDate: firstdate,
        initialDate: now,
        lastDate: now);

    setState(() {
      _sleectedate = pickedate;
    });
  }

  void _submitexpensedata() {
    final enteramount = double.tryParse(_amountcontrller.text);
    final amountisvalid = enteramount == null || enteramount <= 0;
    if (_titlecontroller.text.trim().isEmpty ||
        amountisvalid ||
        _sleectedate == null) {
      showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
                title: Text("invalid input"),
                content: Text(
                    "please make sure a valid title,amount,date and catagory was entered"),
                actions: [
                  TextButton(
                      onPressed: () {
                        Navigator.pop(ctx);
                      },
                      child: Text("okay"))
                ],
              ));
      return;
    }

    widget.onnaddexpenses(Expense(
        title: _titlecontroller.text,
        amount: enteramount,
        date: _sleectedate!,
        Category: _sleectedcatagory));

        Navigator.pop(context);
  }

  @override
  void dispose() {
    _titlecontroller.dispose();
    _amountcontrller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(16,48,16,16),
      child: Column(
        children: [
          TextField(
            controller: _titlecontroller,
            maxLength: 50,
            decoration: InputDecoration(label: Text("Title")),
          ),
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _amountcontrller,
                  keyboardType: TextInputType.number,
                  decoration:
                      InputDecoration(label: Text("amont"), prefixText: "\$ "),
                ),
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(_sleectedate == null
                        ? "no seleceted date"
                        : formatter.format(_sleectedate!)),
                    IconButton(
                        onPressed: _presentdatepicker,
                        icon: Icon(Icons.calendar_month))
                  ],
                ),
              )
            ],
          ),
          Row(
            children: [
              DropdownButton(
                  value: _sleectedcatagory,
                  items: categorys.values
                      .map(
                        (categorys) => DropdownMenuItem(
                            value: categorys,
                            child: Text(categorys.name.toUpperCase())),
                      )
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      if (value == null) {
                        return;
                      }
                      _sleectedcatagory = value;
                    });
                  }),
              Spacer(),
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text("cancel")),
              ElevatedButton(
                  onPressed: () {
                    _submitexpensedata();
                  },
                  child: Text("save expense"))
            ],
          )
        ],
      ),
    );
  }
}
