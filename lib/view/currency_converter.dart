import 'package:code94labs/services/auth.dart';
import 'package:code94labs/services/shared_preference_data.dart';
import 'package:code94labs/utils/const.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../utils/alerts.dart';

class CurrencyConverter extends StatefulWidget {
  const CurrencyConverter({super.key});

  @override
  State<CurrencyConverter> createState() => _CurrencyConverterState();
}

class _CurrencyConverterState extends State<CurrencyConverter> {

  final TextEditingController _amountController = TextEditingController();

  String _fromCurrency = 'USD';
  String _toCurrency = 'EUR';
  List<String> _currencies = ['USD', 'EUR'];

  String _result = '';

  bool isLoading = false;

  @override
  void initState() {

    getSavedCurrencies();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Currency Converter'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _amountController,
              decoration: const InputDecoration(labelText: 'Amount'),
              keyboardType: TextInputType.number,
            ),
            DropdownButton<String>(
              value: _fromCurrency,
              onChanged: (value) {
                setState(() {
                  _fromCurrency = value!;
                });
              },
              items: _currencies.map((currency) {
                return DropdownMenuItem(
                  value: currency,
                  child: Text(currency),
                );
              }).toList(),
            ),
            DropdownButton<String>(
              value: _toCurrency,
              onChanged: (value) {
                setState(() {
                  _toCurrency = value!;
                });
              },
              items: _currencies.map((currency) {
                return DropdownMenuItem(
                  value: currency,
                  child: Text(currency),
                );
              }).toList(),
            ),

            const SizedBox(height: 20),

            ElevatedButton(
              onPressed: _convertCurrency,
              child: const Text('Convert'),
            ),

            const SizedBox(height: 20),

            isLoading ? const CircularProgressIndicator() : Text(
              _result,
              style: const TextStyle(fontSize: 20),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
          heroTag: "btn1",
          onPressed: () {
            addNewCurrency();
          },
          child: const Icon(Icons.add),
        ),

    );
  }

  getSavedCurrencies() async {
    final currencyList = await SharedPreferencesData.getCurrencies();

    if(currencyList.isNotEmpty) {
      _currencies.clear();

      setState(() {
        _currencies = currencyList;
      });
    }

  }

  addNewCurrency() async {
    Alerts.addNewCurrencyAlert(context: context, currentCurrencyList: _currencies, currencyList: Constance.currencies, callback: (value) => onClick(value));
  }

  onClick(String value) {

    if(_currencies.contains(value)) {
      showToast("$value removed");
      setState(() {
        _currencies.remove(value);
        SharedPreferencesData.setCurrencies(_currencies);
      });
    } else {
      showToast("$value added");
      setState(() {
        _currencies.add(value);
        SharedPreferencesData.setCurrencies(_currencies);
      });
    }

  }

  showToast(message) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.black,
        textColor: Colors.white,
        fontSize: 16.0
    );
  }

  _convertCurrency() async {

    if(_amountController.text.isEmpty) {

      setState(() {
        _result = "Invalid amount";
      });

    } else {

      setState(() {
        isLoading = true;
      });

      double amount = double.parse(_amountController.text);

      authService.getCurrencyFromAPI(context, _fromCurrency, _toCurrency, amount).then((value) {
        setState(() {
          _result = value;
          isLoading = false;
        });
      });
    }
  }
}