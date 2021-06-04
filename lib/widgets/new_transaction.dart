import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  final Function _addTransactionHandler;

  NewTransaction(this._addTransactionHandler);

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final titleController = TextEditingController();
  DateTime _selectedDate = DateTime.now();
  final amountController = TextEditingController();

  void _presentDatePicker() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2021),
            lastDate: DateTime.now())
        .then((value) {
      if (value == null) return;
      setState(() {
        _selectedDate = value;
      });
    });
  }

  void _submitData() {
    final eneredTitle = titleController.text;
    final eneredAmount = double.parse(amountController.text);
    if (eneredTitle.isEmpty || eneredAmount <= 0) return;

    widget._addTransactionHandler(eneredTitle, eneredAmount, _selectedDate);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            TextField(
              decoration: InputDecoration(labelText: 'Title'),
              controller: titleController,
              onSubmitted: (_) => _submitData(),
              cursorColor: Theme.of(context).primaryColor,
              //onChanged: (value) => titleInput = value,
            ),
            TextField(
              decoration: InputDecoration(labelText: 'Amount'),
              //onChanged: (value) => titleInput = value,
              controller: amountController,
              keyboardType: TextInputType.number,
              onSubmitted: (_) => _submitData(),
            ),
            Container(
              height: 60,
              child: Row(
                children: <Widget>[
                  Text(_selectedDate == null
                      ? 'No date chosen!'
                      : DateFormat('yyyy-MM-dd').format(_selectedDate)),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: RaisedButton(
                        color: Colors.white,
                        onPressed: _presentDatePicker,
                        child: Text(
                          'Chose date',
                          style: TextStyle(
                              color: Theme.of(context).primaryColor,
                              fontWeight: FontWeight.bold),
                        )),
                  )
                ],
              ),
            ),
            FlatButton(
                color: Theme.of(context).accentColor,
                child: Text('Add transaction',
                    style: TextStyle(
                        color: Theme.of(context).secondaryHeaderColor,
                        fontWeight: FontWeight.bold)),
                onPressed: _submitData),
          ],
        ),
      ),
    );
  }
}
