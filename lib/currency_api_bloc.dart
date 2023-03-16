import 'package:personal_expanses_app/currency_enum.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:rxdart/rxdart.dart';

class CurrencyApiBloc {
  CurrencyApiBloc() {
    currentCurrencySink.stream.listen((currency) async {
      currentCurrencyMultiplierSink.add(null);
      final result = await getCurrency(currency).timeout(Duration(seconds: 6), onTimeout: () => 1.0).catchError((_) {
        return 1.0;
      });
      currentCurrencyMultiplierSink.add(result);
    });
  }

  BehaviorSubject<currencyEnum> currentCurrencySink = BehaviorSubject<currencyEnum>.seeded(currencyEnum.PLN);
  BehaviorSubject<double?> currentCurrencyMultiplierSink = BehaviorSubject<double?>();

  Future<double> getCurrency(currencyEnum currency) async {
    final result = await http.get(Uri.parse('https://api.apilayer.com/exchangerates_data/latest'),
        headers: {'apikey': 'fkIoHVXWlo4VhfR0fnNmVNpv30COQ0Yl'});
    final currencies = jsonDecode(result.body)['rates'] as Map<String, dynamic>;
    final value = currencies[currency.name];
    if (value == null) {
      throw ('Something went wrong, try again');
    }
    if (value is int) {
      return value * 1.1;
    }
    return value;
  }
}
