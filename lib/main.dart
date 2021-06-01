import 'package:flutter/material.dart';
import 'package:personal_expanses_app/widgets/new_transaction.dart';
import 'package:personal_expanses_app/widgets/transaction_list.dart';

import 'models/transactin.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter App',
      theme: ThemeData(
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
    Transaction(
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
    ),
  ];

  void _addNewTransaction(String title, double amount) {
    final newTx = Transaction(
        title: title,
        amount: amount,
        date: DateTime.now(),
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
        backgroundColor: Colors.white,
        shadowColor: Theme.of(context).primaryColor,
        title: Text(
          'Flutter App',
          style: TextStyle(color: Theme.of(context).primaryColor),
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () => _startAddNewTransaction(context),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          //mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Container(
              height: 50,
              width: double.infinity,
              child: Card(
                color: Theme.of(context).secondaryHeaderColor,
                child: Text(
                  "KUpa",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Theme.of(context).secondaryHeaderColor,
                      fontSize: 24),
                ),
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
