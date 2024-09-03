import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';



final formatter= DateFormat.yMd();

final uuid = Uuid();

// ignore: camel_case_types
enum categorys { food, travel, leisure, work }

const caagoryicons = {
  categorys.food: Icons.lunch_dining,
  categorys.travel: Icons.flight_takeoff,
  categorys.leisure: Icons.movie,
  categorys.work: Icons.work,
};

class Expense {
  Expense(
      {required this.title,
      required this.amount,
      required this.date,
      required this.Category})
      : id = uuid.v4();

  final String id;
  final String title;
  final double amount;
  final DateTime date;
  final categorys Category;



String get formatedate{
  return formatter.format(date);
}  
}
