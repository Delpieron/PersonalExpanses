import 'package:flutter/material.dart';
import '../models/transactin.dart';
import 'package:intl/intl.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> _transactions;

  TransactionList(this._transactions);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color.fromRGBO(220, 190, 255, 1),
      height: 280,
      child: _transactions.isEmpty
          ? Container(
              height: 220,
              width: double.infinity,
              child: Column(
                children: <Widget>[
                  Text('dsadasdasdasdsada'),
                  SizedBox(
                    height: 10,
                  ),
                  Image.asset(
                    'Assets/images/zzz.jpg',
                    fit: BoxFit.cover,
                  )
                ],
              ),
            )
          : ListView.builder(
              itemCount: _transactions.length,
              itemBuilder: (trans, index) {
                return Card(
                  child: Row(
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.all(10),
                        margin:
                            EdgeInsets.symmetric(vertical: 12, horizontal: 15),
                        decoration: BoxDecoration(
                            border: Border.all(
                                color: Theme.of(context).primaryColor,
                                width: 2)),
                        child: Text(
                          'PLN: ${_transactions[index].amount.toStringAsFixed(2)}',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                              color: Theme.of(context).primaryColor),
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            _transactions[index].title,
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16),
                          ),
                          Text(
                            DateFormat('yyyy-MM-dd')
                                .format(_transactions[index].date),
                            style: TextStyle(color: Colors.grey),
                          ),
                        ],
                      ),
                      Flexible(
                        child: Text('data'),
                      )
                    ],
                  ),
                );
              },
            ),
    );
  }
}
