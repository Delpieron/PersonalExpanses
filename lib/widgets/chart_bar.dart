import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:personal_expanses_app/currency_api_bloc.dart';
import 'package:get_it/get_it.dart';

class ChartBar extends StatelessWidget {
  final String label;
  final double spendingAmount;
  final double spendingPctOfTotal;

  ChartBar(this.label, this.spendingAmount, this.spendingPctOfTotal);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          SizedBox(
            width: 15,
            child: Text(label),
          ),
          Expanded(
            child: Container(
              height: 20,
              padding: EdgeInsets.symmetric(horizontal: 40),
              child: Stack(
                children: <Widget>[
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Theme.of(context).colorScheme.background, width: 1.0),
                      color: Color.fromRGBO(220, 220, 220, 1),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  FractionallySizedBox(
                    widthFactor: spendingPctOfTotal,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            height: 20,
            width: 65,
            child: Text(
              NumberFormat.simpleCurrency(name: GetIt.I.get<CurrencyApiBloc>().currentCurrencySink.value.name)
                  .format(spendingAmount),
              style: TextStyle(fontSize: 15),
              overflow: TextOverflow.clip,
            ),
          ),
        ],
      ),
    );
  }
}
