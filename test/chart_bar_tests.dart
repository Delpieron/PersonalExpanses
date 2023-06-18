import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:intl/intl.dart';
import 'package:personal_expanses_app/currency_api_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:personal_expanses_app/widgets/chart_bar.dart';

void main() {
  late CurrencyApiBloc currencyApiBloc;

  setUp(() {
    currencyApiBloc = CurrencyApiBloc();
    GetIt.I.registerSingleton<CurrencyApiBloc>(currencyApiBloc);
  });

  tearDown(() {
    GetIt.I.unregister<CurrencyApiBloc>();
  });

  testWidgets('ChartBar displays the correct label and amount', (WidgetTester tester) async {
    const label = 'Test';
    const spendingAmount = 100.0;
    const spendingPctOfTotal = 0.5;

    await tester.pumpWidget(
      MaterialApp(
        home: ChartBar(label, spendingAmount, spendingPctOfTotal),
      ),
    );

    expect(find.text(label), findsOneWidget);

    final formattedAmount = NumberFormat.simpleCurrency(
      name: currencyApiBloc.currentCurrencySink.value.name,
    ).format(spendingAmount);
    expect(find.text(formattedAmount), findsOneWidget);
  });

  testWidgets('ChartBar displays correct bar width based on spending percentage', (WidgetTester tester) async {
    const label = 'Test';
    const spendingAmount = 100.0;
    const spendingPctOfTotal = 0.5;

    await tester.pumpWidget(
      MaterialApp(
        home: ChartBar(label, spendingAmount, spendingPctOfTotal),
      ),
    );

    final fractionallySizedBox = tester.widget<FractionallySizedBox>(find.byType(FractionallySizedBox));

    expect(fractionallySizedBox.widthFactor, equals(spendingPctOfTotal));
  });
}
