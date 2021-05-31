import 'package:flutter/material.dart';
import './transactin.dart';
import 'package:intl/intl.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter App',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  final List<Transaction> transactions = [
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        shadowColor: Colors.purple,
        title: Text(
          'Flutter App',
          style: TextStyle(color: Colors.purple),
        ),
      ),
      body: Column(
        //mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Container(
            width: double.infinity,
            child: Card(
              color: Colors.purple,
              child: Text("KUpa"),
              elevation: 5,
            ),
          ),
          Card(
            elevation: 5,
            child: Container(
              padding: EdgeInsets.all(10),
              child: Column(
                children: <Widget>[
                  TextField(),
                  TextField(),
                ],
              ),
            ),
          ),
          Column(
            children: transactions.map((tx) {
              return Card(
                child: Row(
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.all(10),
                      margin:
                          EdgeInsets.symmetric(vertical: 12, horizontal: 15),
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.purple, width: 2)),
                      child: Text(
                        'PLN: ${tx.amount}',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            color: Colors.purple),
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          tx.title,
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                        Text(
                          DateFormat('yyyy-MM-dd').format(tx.date),
                          style: TextStyle(color: Colors.grey),
                        ),
                      ],
                    )
                  ],
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
