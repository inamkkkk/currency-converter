import 'package:flutter/material.dart';
import 'package:currency_converter/services/api_service.dart';
import 'package:currency_converter/models/currency_model.dart';
import 'package:provider/provider.dart';

class CurrencyConverterScreen extends StatefulWidget {
  @override
  _CurrencyConverterScreenState createState() => _CurrencyConverterScreenState();
}

class _CurrencyConverterScreenState extends State<CurrencyConverterScreen> {
  String? fromCurrency = 'USD';
  String? toCurrency = 'EUR';
  double amount = 1.0;
  double result = 0.0;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    fetchCurrencies();
  }

  Future<void> fetchCurrencies() async {
    setState(() {
      isLoading = true;
    });
    try {
      await Provider.of<CurrencyModel>(context, listen: false).fetchCurrencies();
    } catch (e) {
      print('Error fetching currencies: $e');
      // Handle error (e.g., show a snackbar)
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> convertCurrency() async {
    setState(() {
      isLoading = true;
    });
    try {
      final rate = await ApiService.getExchangeRate(fromCurrency!, toCurrency!);
      setState(() {
        result = amount * rate;
      });
    } catch (e) {
      print('Error converting currency: $e');
      // Handle error (e.g., show a snackbar)
    } finally {
      setState(() {
        isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final currencyModel = Provider.of<CurrencyModel>(context);
    final currencies = currencyModel.currencies;

    return Scaffold(
      appBar: AppBar(
        title: Text('Currency Converter'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (isLoading) CircularProgressIndicator(),
            DropdownButtonFormField<String>(
              decoration: InputDecoration(labelText: 'From Currency'),
              value: fromCurrency,
              items: currencies.map((currency) {
                return DropdownMenuItem<String>(
                  value: currency,
                  child: Text(currency),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  fromCurrency = value;
                });
              },
            ),
            SizedBox(height: 16),
            DropdownButtonFormField<String>(
              decoration: InputDecoration(labelText: 'To Currency'),
              value: toCurrency,
              items: currencies.map((currency) {
                return DropdownMenuItem<String>(
                  value: currency,
                  child: Text(currency),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  toCurrency = value;
                });
              },
            ),
            SizedBox(height: 16),
            TextFormField(
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              decoration: InputDecoration(labelText: 'Amount'),
              onChanged: (value) {
                setState(() {
                  amount = double.tryParse(value) ?? 1.0;
                });
              },
            ),
            SizedBox(height: 24),
            ElevatedButton(
              onPressed: convertCurrency,
              child: Text('Convert'),
            ),
            SizedBox(height: 24),
            Text('Result: $result'),
          ],
        ),
      ),
    );
  }
}
