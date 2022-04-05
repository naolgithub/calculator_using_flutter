import 'package:flutter/material.dart';

void main() {
  runApp(const CalculatorRootApp());
}

class CalculatorRootApp extends StatelessWidget {
  const CalculatorRootApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Calculator',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const CalculatorPage(),
    );
  }
}

class CalculatorPage extends StatefulWidget {
  const CalculatorPage({Key? key}) : super(key: key);

  @override
  State<CalculatorPage> createState() => _CalculatorPageState();
}

class _CalculatorPageState extends State<CalculatorPage> {
  var userInput = '';
  var answer = '';

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
