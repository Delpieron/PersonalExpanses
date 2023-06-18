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
    return SizedBox(
      height: 490,
      child: transactions.isEmpty
          ?
                Center(
                  child: Text(
                    'No transactions added yet!',
                  ),
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
                    leading: Padding(
                      padding: const EdgeInsets.only(top: 10.0, right: 8),
                      child: Text(
                        NumberFormat.simpleCurrency(name: GetIt.I.get<CurrencyApiBloc>().currentCurrencySink.value.name)
                            .format(transactions[index].amount * currencyMultiplier),
                      ),
                    ),
                    title: Row(
                      children: [
                        Text(
                          transactions[index].title,
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                        IconButton(
                          key: Key('map'),
                          icon: Icon(Icons.map_outlined),
                          color: Theme.of(context).colorScheme.error,
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
                      color: Theme.of(context).colorScheme.error,
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
