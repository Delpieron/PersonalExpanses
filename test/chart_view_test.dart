import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';
import 'package:personal_expanses_app/currency_api_bloc.dart';
import 'package:personal_expanses_app/models/transactin.dart';
import 'package:personal_expanses_app/widgets/chart.dart';
import 'package:personal_expanses_app/widgets/chart_bar.dart';


void main() {
  setUp(() => GetIt.I.registerSingleton<CurrencyApiBloc>(CurrencyApiBloc()));
  group('Chart', () {
    final currencyMultiplier = 1.0;
    final List<Transaction> recentTransactions = [
      Transaction(
        id: 't1',
        title: 'Transaction 1',
        amount: 10.0,
        date: DateTime.now(),
      ),
      Transaction(
        id: 't2',
        title: 'Transaction 2',
        amount: 20.0,
        date: DateTime.now(),
      ),
    ];

    testWidgets('renders ChartBar widgets for each day of week', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Chart(recentTransactions, currencyMultiplier),
          ),
        ),
      );

      expect(find.byType(ChartBar), findsNWidgets(DateTime.daysPerWeek));
    });

    test('calculates the total spending correctly', () {
      final chart = Chart(recentTransactions, currencyMultiplier);

      final expectedTotalSpending = recentTransactions.fold(
        0.0,
            (sum, item) => sum + (item.amount * currencyMultiplier),
      );

      expect(chart.totalSpending, expectedTotalSpending);
    });

    test('calculates the grouped transaction values correctly', () {
      final chart = Chart(recentTransactions, currencyMultiplier);

      final expectedGroupedTransactionValues = List.generate(7, (index) {
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
          'amount': totalSum * currencyMultiplier,
        };
      }).toList();

      expect(chart.groupedTransactionValues, expectedGroupedTransactionValues);
    });
  });
}
