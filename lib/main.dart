import 'package:async_builder/async_builder.dart';
import 'package:flutter/material.dart';
import 'package:personal_expanses_app/currency_api_bloc.dart';
import 'package:personal_expanses_app/currency_enum.dart';
import 'package:personal_expanses_app/map_view.dart';
import 'package:personal_expanses_app/themes.dart';

// import 'package:permission_handler/permission_handler.dart';
import 'package:uuid/uuid.dart';
import 'package:async_builder/init_builder.dart';

import './widgets/new_transaction.dart';
import './widgets/transaction_list.dart';
import './widgets/chart.dart';
import './models/transactin.dart';
import 'package:get_it/get_it.dart';

import 'loading_view.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  return runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Personal Expenses',
      theme: lightTheme,
      debugShowCheckedModeBanner: false,
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  MyHomePageState createState() => MyHomePageState();
}

class MyHomePageState extends State<MyHomePage> {
  final List<Transaction> _userTransactions = [
    Transaction(
      id: const Uuid().v4(),
      title: 'New Shoes',
      amount: 69.99,
      date: DateTime.now(),
    ),
    Transaction(
      id: const Uuid().v4(),
      title: 'Weekly Groceries',
      amount: 16.53,
      date: DateTime.now(),
    ),
  ];

  List<Transaction> get recentTransactions {
    return _userTransactions.where((tx) {
      return tx.date.isAfter(
        DateTime.now().subtract(
          Duration(days: 7),
        ),
      );
    }).toList();
  }

  void addNewTransaction(String txTitle, double txAmount, DateTime chosenDate, LocalizationObject? localization) {
    final newTx = Transaction(
      title: txTitle,
      amount: txAmount,
      date: chosenDate,
      localization: localization,
      id: const Uuid().v4(),
    );

    setState(() {
      _userTransactions.add(newTx);
    });
  }

  void _startAddNewTransaction(BuildContext ctx) {
    showModalBottomSheet(
      context: ctx,
      isScrollControlled: true,
      builder: (_) {
        return GestureDetector(
          onTap: () {},
          child: AnimatedPadding(
            duration: Duration(milliseconds: 150),
            curve: Curves.easeIn,
            padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
            child: NewTransaction(addNewTransaction),
          ),
          behavior: HitTestBehavior.opaque,
        );
      },
    );
  }

  void deleteTransaction(String id) {
    setState(() {
      _userTransactions.removeWhere((tx) => tx.id == id);
    });
  }

  @override
  Widget build(BuildContext context) {
    return InitBuilder<void>(
      getter: initCurrencyApi,
      builder: (context, _) {
        return Stack(
          children: [
            Scaffold(
              resizeToAvoidBottomInset: true,
              appBar: AppBar(
                backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
                title: Text(
                  'Personal Expenses',
                  style: TextStyle(color: Theme.of(context).secondaryHeaderColor),
                ),
                actions: <Widget>[
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: SizedBox(
                      width: 80,
                      child: DropdownButtonFormField<currencyEnum>(
                        focusColor: Colors.red,
                        iconEnabledColor: Colors.white,
                        isExpanded: true,
                        isDense: false,
                        value: GetIt.I.get<CurrencyApiBloc>().currentCurrencySink.value,
                        dropdownColor: Colors.red,
                        items: List<DropdownMenuItem<currencyEnum>>.generate(
                          currencyEnum.values.length,
                          (index) => DropdownMenuItem<currencyEnum>(
                            value: currencyEnum.values[index],
                            child: Text(
                              currencyEnum.values[index].name,
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                        onChanged: (newCurrency) =>
                            GetIt.I.get<CurrencyApiBloc>().currentCurrencySink.value = newCurrency!,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: IconButton(
                      icon: Icon(Icons.add),
                      onPressed: () => _startAddNewTransaction(context),
                    ),
                  ),
                ],
              ),
              body: SingleChildScrollView(
                child: AsyncBuilder<double?>(
                  stream: GetIt.I.get<CurrencyApiBloc>().currentCurrencyMultiplierSink,
                  error: (context, obj, stack) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Error occurred. Please restart app and try again')),
                    );
                    return SizedBox.shrink();
                  },
                  builder: (context, currencyMultiplier) {
                    if (currencyMultiplier == null || currencyMultiplier == 0.0) {
                      return const SizedBox.shrink();
                    }
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        Chart(recentTransactions, currencyMultiplier),
                        TransactionList(_userTransactions, deleteTransaction, currencyMultiplier),
                      ],
                    );
                  },
                ),
              ),
              floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
              floatingActionButton: FloatingActionButton(
                child: Icon(
                  Icons.add,
                  color: Colors.white,
                ),
                key: Key('addButton'),
                onPressed: () => _startAddNewTransaction(context),
              ),
            ),
            AsyncBuilder(
              stream: GetIt.I.get<CurrencyApiBloc>().currentCurrencyMultiplierSink.stream,
              error: (context, obj, stack) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Error occurred. Please restart app and try again')),
                );
                return SizedBox.shrink();
              },
              builder: (context, newCurrency) {
                if (newCurrency != null) {
                  return SizedBox.shrink();
                }
                return const LoadingView();
              },
            )
          ],
        );
      },
    );
  }
}

void initCurrencyApi() => GetIt.I.registerSingleton<CurrencyApiBloc>(CurrencyApiBloc());
