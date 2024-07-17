import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'package:code94labs/model/currency_data_model.dart';
import 'package:http/http.dart' as http;

class AuthService {

  // Future<CurrencyDataModel> getCurrencyFromAPI(context, _fromCurrency, _toCurrency, amount) async {
  Future<String> getCurrencyFromAPI(context, _fromCurrency, _toCurrency, amount) async {

    String _value;

    final apiUrl = 'https://v6.exchangerate-api.com/v6/a1609f79c8b884d7d8e0a736/latest/$_fromCurrency';
    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {

      log(response.body);

      final data = json.decode(response.body);
      final rate = data['conversion_rates'][_toCurrency];
      final result = amount * rate;

      _value = '$amount $_fromCurrency = ${result.toStringAsFixed(2)} $_toCurrency';

    } else {
      _value = 'Failed to fetch conversion rate';
    }

    return _value;
  }

}

final AuthService authService = AuthService();
