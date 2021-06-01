import 'package:flutter/material.dart';

class NewTransaction extends StatefulWidget {
  final Function _addTransactionHandler;

  NewTransaction(this._addTransactionHandler);

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final titleController = TextEditingController();

  final amountController = TextEditingController();

  void submitData() {
    final eneredTitle = titleController.text;
    final eneredAmount = double.parse(amountController.text);
    if (eneredTitle.isEmpty || eneredAmount <= 0) return;

    widget._addTransactionHandler(
      eneredTitle,
      eneredAmount,
    );
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
              onSubmitted: (_) => submitData(),
              //onChanged: (value) => titleInput = value,
            ),
            TextField(
              decoration: InputDecoration(labelText: 'Amount'),
              //onChanged: (value) => titleInput = value,
              controller: amountController,
              keyboardType: TextInputType.number,
              onSubmitted: (_) => submitData(),
            ),
            FlatButton(
                color: Colors.purple,
                child: Text('Add transaction'),
                onPressed: submitData),
          ],
        ),
      ),
    );
  }
}
