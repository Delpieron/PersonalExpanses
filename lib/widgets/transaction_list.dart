import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';
import 'package:personal_expanses_app/currency_api_bloc.dart';

import '../map_view.dart';
import '../models/transactin.dart';

class TransactionList extends StatelessWidget {
  TransactionList(this.transactions, this.deleteTx, this.currencyMultiplier);

  final List<Transaction> transactions;
  final Function deleteTx;
  final double currencyMultiplier;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 490,
      child: transactions.isEmpty
          ? Column(
              children: <Widget>[
                Text(
                  'No transactions added yet!',
                ),
                SizedBox(
                  height: 30,
                ),
                Container(
                  key: Key('testEmpty'),
                  height: 300,
                ),
              ],
            )
          : ListView.builder(
              itemBuilder: (ctx, index) {
                return Card(
                  key: Key('transactionItem'),
                  elevation: 5,
                  margin: EdgeInsets.symmetric(
                    vertical: 8,
                    horizontal: 16,
                  ),
                  child: ListTile(
                    leading: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                            '${(transactions[index].amount * currencyMultiplier).toStringAsFixed(2)}'),
                        Text(GetIt.I.get<CurrencyApiBloc>().currentCurrencySink.value.name),
                      ],
                    ),
                    title: Row(
                      children: [
                        Text(
                          transactions[index].title,
                          style: Theme.of(context).textTheme.bodyText2,
                        ),
                        IconButton(
                          key: Key('map'),
                          icon: Icon(Icons.map_outlined),
                          color: Theme.of(context).errorColor,
                          onPressed: transactions[index].localization == null
                              ? null
                              : () => Navigator.of(context).push<LocalizationObject>(
                                    MaterialPageRoute(
                                      builder: (_) => SelectionMapView(
                                        localizationObject: transactions[index].localization,
                                        canChangeLocalization: false,
                                      ),
                                    ),
                                  ),
                        ),
                      ],
                    ),
                    subtitle: Text(
                      DateFormat.yMMMd().format(transactions[index].date),
                    ),
                    trailing: IconButton(
                      key: Key('del'),
                      icon: Icon(Icons.delete),
                      color: Theme.of(context).errorColor,
                      onPressed: () => deleteTx(transactions[index].id),
                    ),
                  ),
                );
              },
              itemCount: transactions.length,
            ),
    );
  }
}
