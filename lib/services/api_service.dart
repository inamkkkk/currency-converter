import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl = 'https://api.exchangerate.host';

  static Future<List<String>> getCurrencies() async {
    final response = await http.get(Uri.parse('$baseUrl/symbols'));

    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      final symbols = jsonResponse['symbols'] as Map<String, dynamic>;
      return symbols.keys.toList();
    } else {
      throw Exception('Failed to load currencies');
    }
  }

  static Future<double> getExchangeRate(String fromCurrency, String toCurrency) async {
    final response = await http.get(Uri.parse('$baseUrl/convert?from=$fromCurrency&to=$toCurrency'));

    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      return jsonResponse['result'];
    } else {
      throw Exception('Failed to load exchange rate');
    }
  }
}
