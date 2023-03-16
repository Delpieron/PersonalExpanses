// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.


import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:personal_expanses_app/main.dart';
import 'package:coverage/coverage.dart';
void main() {
  testWidgets('Add transaction', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MyApp());
    var findAddButton = find.byKey(Key('addButton'));
    await tester.tap(findAddButton);
    await tester.pumpAndSettle();
    var findTitleInput = find.byKey(Key('TitleInput'));
    var findAmountInput = find.byKey(Key('AmountInput'));
    var findConfirmButton = find.text('Add Transaction');
    expect(findAmountInput, findsOneWidget);

    await tester.enterText(findTitleInput, 'Buty');
    await tester.enterText(findAmountInput, '22.99');
    //expect(findConfirmButton, findsOneWidget);

    await tester.tap(findConfirmButton);
    await tester.pumpAndSettle();
    //=================================================================


    var findss = find.byKey(Key('test'));

    expect(findss, findsWidgets);
    var findDelButton = find.byKey(Key('del'));
    await tester.tap(findDelButton);
    await tester.pump();
    expect(findss, findsNothing);
  });
}
