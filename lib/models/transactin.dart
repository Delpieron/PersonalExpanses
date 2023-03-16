import 'package:personal_expanses_app/map_view.dart';

class Transaction {
  Transaction({
    required this.id,
    required this.title,
    required this.amount,
    required this.date,
    this.localization,
  });

  final String id;
  final String title;
  final double amount;
  final DateTime date;
  final LocalizationObject? localization;
}
