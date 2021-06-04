import 'package:flutter/material.dart';
import 'package:personal_expanses_app/widgets/new_transaction.dart';
import 'package:personal_expanses_app/widgets/transaction_list.dart';
import 'package:personal_expanses_app/widgets/chart.dart';

import 'models/transactin.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter App',
      theme: ThemeData(
          fontFamily: 'Quicksand',
          primarySwatch: Colors.purple,
          accentColor: Colors.purpleAccent,
          secondaryHeaderColor: Colors.white),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  //late String titleInput;
  // late String amountInput;
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  //final titleController = TextEditingController();
  //final amountCotroller = TextEditingController();

  final List<Transaction> _transactions = [
/*     Transaction(
      id: 't1',
      title: 'buty',
      amount: 72.56,
      date: DateTime.now(),
    ),
    Transaction(
      id: 't2',
      title: 'spodnie',
      amount: 55.14,
      date: DateTime.now(),
    ), */
  ];
  List<Transaction> get _recentTransactions {
    List<Transaction> _tempList = [];
    for (int i = 0; i < _transactions.length; i++)
      if (_transactions[i]
          .date
          .isAfter(DateTime.now().subtract(Duration(days: 7))))
        _tempList.add(_transactions[i]);
    return _tempList;
  }

  void _addNewTransaction(String title, double amount, DateTime selectedDate) {
    final newTx = Transaction(
        title: title,
        amount: amount,
        date: selectedDate,
        id: DateTime.now().toString());
    setState(() {
      _transactions.add(newTx);
    });
  }

  void _startAddNewTransaction(BuildContext ctx) {
    showModalBottomSheet(
        context: ctx,
        builder: (_) {
          return GestureDetector(
            onTap: () {},
            child: NewTransaction(_addNewTransaction),
            behavior: HitTestBehavior.opaque,
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).secondaryHeaderColor,
        shadowColor: Theme.of(context).primaryColor,
        title: Text(
          'Flutter App',
          style: TextStyle(color: Theme.of(context).primaryColor),
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () => _startAddNewTransaction(context),
            color: Theme.of(context).primaryColor,
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          //mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Chart(_recentTransactions),
            Container(
              height: 10,
              width: double.infinity,
              child: Card(
                color: Theme.of(context).primaryColor,
                elevation: 5,
              ),
            ),
            TransactionList(_transactions)
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => _startAddNewTransaction(context),
      ),
    );
  }
}
