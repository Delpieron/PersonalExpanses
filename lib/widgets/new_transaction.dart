import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:personal_expanses_app/currency_api_bloc.dart';
import 'package:personal_expanses_app/map_view.dart';
import 'package:get_it/get_it.dart';

class NewTransaction extends StatefulWidget {
  final Function(String txTitle, double txAmount, DateTime chosenDate, LocalizationObject? localization) addExpanse;

  NewTransaction(this.addExpanse);

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime _selectedDate = DateTime.now();
  LocalizationObject? transactionAdress;
  List<DateObject> daysOfWeek = List.generate(
    Days.values.length,
    (index) => DateObject(
      Days.values[index],
      DateTime.now().subtract(
        Duration(days: index),
      ),
    ),
  );

  void _submitData() {
    if (_amountController.text.isEmpty) {
      return;
    }
    final enteredTitle = _titleController.text;
    final enteredAmount = double.parse(_amountController.text);

    if (enteredTitle.isEmpty || enteredAmount <= 0) {
      return;
    }
    widget.addExpanse(
      enteredTitle,
      enteredAmount,
      _selectedDate,
      transactionAdress,
    );

    Navigator.of(context).pop();
  }

  DateObject groupValue = DateObject(Days.values[DateTime.now().weekday - 1], DateTime.now());

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 8,
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            TextField(
              key: Key('TitleInput'),
              decoration: InputDecoration(labelText: 'Title'),
              controller: _titleController,
              onSubmitted: (_) => _submitData(),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: TextField(
                    key: Key('AmountInput'),
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    decoration: InputDecoration(labelText: 'Amount'),
                    controller: _amountController,
                    keyboardType: TextInputType.number,
                    onSubmitted: (_) => _submitData(),
                  ),
                ),
                Text(GetIt.I.get<CurrencyApiBloc>().currentCurrencySink.value.name),
              ],
            ),
            Visibility(
              visible: false, // Disabled because of problems with googleApi
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(transactionAdress?.localizationString ?? 'Choose localization'),
                      IconButton(
                        onPressed: () async {
                          final localization = await Navigator.of(context).push<LocalizationObject>(
                            MaterialPageRoute(builder: (_) => SelectionMapView()),
                          );
                          setState(() {
                            transactionAdress = localization;
                          });
                        },
                        icon: Icon(Icons.map_outlined),
                      )
                    ],
                  ),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: List<Column>.generate(
                daysOfWeek.length,
                (index) {
                  return Column(
                    children: [
                      Radio<DateObject>(
                        value: daysOfWeek[index],
                        groupValue: groupValue,
                        onChanged: (DateObject? value) {
                          setState(() => groupValue = value!);
                          _selectedDate = DateTime.now().subtract(Duration(days: index));
                        },
                      ),
                      Text(Days.values[index].name),
                    ],
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 32.0),
              child: Center(
                child: MaterialButton(
                  elevation: 6,
                  child: Text('Save'),
                  color: Theme.of(context).primaryColor,
                  height: 60,
                  textColor: Theme.of(context).secondaryHeaderColor,
                  onPressed: _submitData,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class DateObject {
  DateObject(this.name, this.dayDate);

  final Days name;
  final DateTime dayDate;
}

enum Days { Monday, Tuesday, Wednesday, Thursday, Friday, Saturday, Sunday }
