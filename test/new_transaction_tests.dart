import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:personal_expanses_app/currency_api_bloc.dart';
import 'package:personal_expanses_app/map_view.dart';
import 'package:personal_expanses_app/widgets/new_transaction.dart';

void main() {
  group('_NewTransactionState', () {
    late DateTime selectedDate;
    late LocalizationObject? transactionAddress;

    setUp(() {
      GetIt.I.registerLazySingleton<CurrencyApiBloc>(() => CurrencyApiBloc());

      selectedDate = DateTime.now();
      transactionAddress = null;
    });

    tearDown(() {
      GetIt.I.unregister<CurrencyApiBloc>();
    });

    testWidgets('Submitting data adds expense and pops the screen', (WidgetTester tester) async {
      bool addExpenseCalled = false;

      final mockAddExpense = (String txTitle, double txAmount, DateTime chosenDate, LocalizationObject? localization) {
        addExpenseCalled = true;
        expect(txTitle, 'Test Title');
        expect(txAmount, 10.0);
        expect(chosenDate.day, selectedDate.day);
        expect(localization, transactionAddress);
      };

      await tester.pumpWidget(MaterialApp(
        home: Scaffold(
          body: NewTransaction(mockAddExpense),
        ),
      ));

      await tester.enterText(find.byKey(Key('TitleInput')), 'Test Title');
      await tester.enterText(find.byKey(Key('AmountInput')), '10');

      await tester.tap(find.text('Save'));
      await tester.pumpAndSettle();

      expect(addExpenseCalled, true);
      expect(find.byType(NewTransaction), findsNothing);
    });

    testWidgets('Submitting empty title or zero amount does not call addExpense', (WidgetTester tester) async {
      bool addExpenseCalled = false;

      final mockAddExpense = (String txTitle, double txAmount, DateTime chosenDate, LocalizationObject? localization) {
        addExpenseCalled = true;
      };

      await tester.pumpWidget(MaterialApp(
        home: Scaffold(
          body: NewTransaction(mockAddExpense),
        ),
      ));

      await tester.enterText(find.byKey(Key('TitleInput')), '');
      await tester.enterText(find.byKey(Key('AmountInput')), '0.0');

      await tester.tap(find.text('Save'));
      await tester.pumpAndSettle();

      expect(addExpenseCalled, false);
    });

    testWidgets('Selecting a date updates the selected date', (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(
        home: Scaffold(
          body: NewTransaction((_, __, chosenDate, ___) {
            expect(chosenDate, selectedDate);
          }),
        ),
      ));

      await tester.tap(find.byType(Radio<DateObject>).at(selectedDate.weekday - 1));
      await tester.pumpAndSettle();
    });
    testWidgets('Submitting data with empty amount does not call addExpense', (WidgetTester tester) async {
      bool addExpenseCalled = false;

      final mockAddExpense = (String txTitle, double txAmount, DateTime chosenDate, LocalizationObject? localization) {
        addExpenseCalled = true;
      };

      await tester.pumpWidget(MaterialApp(
        home: Scaffold(
          body: NewTransaction(mockAddExpense),
        ),
      ));

      await tester.enterText(find.byKey(Key('TitleInput')), 'Test Title');
      await tester.enterText(find.byKey(Key('AmountInput')), '');

      await tester.tap(find.text('Save'));
      await tester.pumpAndSettle();

      expect(addExpenseCalled, false);
    });
  });
}
