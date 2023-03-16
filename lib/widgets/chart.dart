import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import './chart_bar.dart';
import '../models/transactin.dart';

class Chart extends StatelessWidget {
  Chart(this.recentTransactions);

  final List<Transaction> recentTransactions;

  List<Map<String, Object>> get groupedTransactionValues {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(
        Duration(days: index),
      );
      var totalSum = 0.0;

      for (var i = 0; i < recentTransactions.length; i++) {
        if (recentTransactions[i].date.day == weekDay.day &&
            recentTransactions[i].date.month == weekDay.month &&
            recentTransactions[i].date.year == weekDay.year) {
          totalSum += recentTransactions[i].amount;
        }
      }

      return {
        'day': DateFormat.E().format(weekDay).substring(0, 1),
        'amount': totalSum,
      };
    }).reversed.toList();
  }

  double get totalSpending => groupedTransactionValues.fold(0.0, (sum, item) => sum + (item['amount'] as double));

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      margin: EdgeInsets.all(20),
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: groupedTransactionValues.map((data) {
            return ChartBar(
              data['day'].toString(),
              (data['amount'] as double),
              totalSpending == 0.0 ? 0.0 : (data['amount'] as double) / totalSpending,
            );
          }).toList(),
        ),
      ),
    );
  }
}
