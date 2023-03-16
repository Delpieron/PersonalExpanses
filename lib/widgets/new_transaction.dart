import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:personal_expanses_app/map_view.dart';

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

  void _presentDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2019),
      lastDate: DateTime.now(),
    ).then((pickedDate) {
      if (pickedDate == null) {
        return;
      }
      setState(() {
        _selectedDate = pickedDate;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      key: Key('TestClose'),
      elevation: 5,
      child: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            TextField(
              key: Key('TitleInput'),
              decoration: InputDecoration(labelText: 'Title'),
              controller: _titleController,
              onSubmitted: (_) => _submitData(),
            ),
            TextField(
              key: Key('AmountInput'),
              decoration: InputDecoration(labelText: 'Amount'),
              controller: _amountController,
              keyboardType: TextInputType.number,
              onSubmitted: (_) => _submitData(),
            ),
            Padding(
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
            SizedBox(
              height: 50,
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Text(
                      'Picked Date: ${DateFormat.yMd().format(_selectedDate)}',
                    ),
                  ),
                  MaterialButton(
                    textColor: Theme.of(context).primaryColor,
                    child: Text(
                      'Choose Date',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    onPressed: _presentDatePicker,
                  ),
                ],
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
