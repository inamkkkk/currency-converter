import 'package:flutter/material.dart';
import 'package:currency_converter/screens/currency_converter_screen.dart';
import 'package:provider/provider.dart';
import 'package:currency_converter/models/currency_model.dart';

void main() {
  runApp(
    ChangeNotifierProvider(create: (context) => CurrencyModel(), child: MyApp()),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Currency Converter',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: CurrencyConverterScreen(),
    );
  }
}
