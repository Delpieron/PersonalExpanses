import 'package:flutter/material.dart';
import 'package:personal_expanses_app/map_view.dart';
import 'package:personal_expanses_app/themes.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:uuid/uuid.dart';

import './widgets/new_transaction.dart';
import './widgets/transaction_list.dart';
import './widgets/chart.dart';
import './models/transactin.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final result = await requestPermissions([Permission.location]);
  if (!result) {
    retryRequests();
  }

  return runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Personal Expenses',
      theme: lightTheme,
      debugShowCheckedModeBanner: false,
      home: MyHomePage(),
    );
  }
}

final Map<Permission, PermissionStatus> _deniedPermissions = {};

void retryRequests() {
  _deniedPermissions.forEach((perm, status) async {
    if (status.isPermanentlyDenied) {
      await openAppSettings();
    } else {
      final result = await perm.request();
      _deniedPermissions[perm] = result;
    }
  });
}

Future<bool> requestPermissions(Iterable<Object> permissions) async {
  _deniedPermissions.clear();
  final results = await (permissions.whereType<Permission>().toList()).request();
  final denied = results.entries.where((perm) => perm.value.isDenied || perm.value.isPermanentlyDenied);
  if (_deniedPermissions.isNotEmpty) {
    _deniedPermissions.addEntries(denied);
    return false;
  }
  return true;
}

class MyHomePage extends StatefulWidget {
  @override
  MyHomePageState createState() => MyHomePageState();
}

class MyHomePageState extends State<MyHomePage> {
  final List<Transaction> _userTransactions = [
    Transaction(
      id: const Uuid().v4(),
      title: 'New Shoes',
      amount: 69.99,
      date: DateTime.now(),
    ),
    Transaction(
      id: const Uuid().v4(),
      title: 'Weekly Groceries',
      amount: 16.53,
      date: DateTime.now(),
    ),
  ];

  List<Transaction> get _recentTransactions {
    return _userTransactions.where((tx) {
      return tx.date.isAfter(
        DateTime.now().subtract(
          Duration(days: 7),
        ),
      );
    }).toList();
  }

  void _addNewTransaction(String txTitle, double txAmount, DateTime chosenDate, LocalizationObject? localization) {
    final newTx = Transaction(
      title: txTitle,
      amount: txAmount,
      date: chosenDate,
      localization: localization,
      id: const Uuid().v4(),
    );

    setState(() {
      _userTransactions.add(newTx);
    });
  }

  void startAddNewTransaction(BuildContext ctx) {
    showModalBottomSheet(
      context: ctx,
      builder: (_) {
        return GestureDetector(
          onTap: () {},
          child: NewTransaction(_addNewTransaction),
          behavior: HitTestBehavior.opaque,
        );
      },
    );
  }

  void _deleteTransaction(String id) {
    setState(() {
      _userTransactions.removeWhere((tx) => tx.id == id);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        title: Text(
          'Personal Expenses',
          style: TextStyle(color: Theme.of(context).secondaryHeaderColor),
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () => startAddNewTransaction(context),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Chart(_recentTransactions),
            TransactionList(_userTransactions, _deleteTransaction),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        key: Key('addButton'),
        onPressed: () => startAddNewTransaction(context),
      ),
    );
  }
}
