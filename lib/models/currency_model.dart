import 'package:flutter/material.dart';
import 'package:currency_converter/services/api_service.dart';

class CurrencyModel extends ChangeNotifier {
  List<String> _currencies = [];

  List<String> get currencies => _currencies;

  Future<void> fetchCurrencies() async {
    try {
      _currencies = await ApiService.getCurrencies();
      notifyListeners();
    } catch (e) {
      print('Error fetching currencies in model: $e');
      rethrow;
    }
  }
}
