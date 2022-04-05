import 'package:calculator_using_flutter/button_gesture_detector.dart';
import 'package:calculator_using_flutter/button_list.dart';
import 'package:calculator_using_flutter/is_operator.dart';
import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';
import 'dart:math';

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
    return Scaffold(
      appBar: AppBar(
        title: const Text("Calculator"),
      ), //AppBar
      backgroundColor: Colors.white38,
      body: Column(
        children: <Widget>[
          Expanded(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Container(
                    padding: const EdgeInsets.all(20),
                    alignment: Alignment.centerRight,
                    child: Text(
                      userInput,
                      style: const TextStyle(fontSize: 18, color: Colors.white),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(15),
                    alignment: Alignment.centerRight,
                    child: Text(
                      answer,
                      style: const TextStyle(
                          fontSize: 30,
                          color: Colors.cyan,
                          fontWeight: FontWeight.bold),
                    ),
                  )
                ]),
          ),
          Expanded(
            flex: 3,
            child: GridView.builder(
                itemCount: buttons.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4),
                itemBuilder: (BuildContext context, int index) {
                  // Clear Button function
                  if (index == 0) {
                    return MyButton(
                      buttontapped: () {
                        setState(() {
                          userInput = '';
                          answer = '0';
                        });
                      },
                      buttonText: buttons[index],
                      color: Colors.blue[50],
                      textColor: Colors.black,
                    );
                  }

                  // +/- button function
                  else if (index == 1) {
                    return MyButton(
                      buttonText: buttons[index],
                      color: Colors.blue[50],
                      textColor: Colors.black,
                    );
                  }
                  // %(modulo) Button function
                  else if (index == 2) {
                    return MyButton(
                      buttontapped: () {
                        setState(() {
                          userInput += buttons[index];
                        });
                      },
                      buttonText: buttons[index],
                      color: Colors.blue[50],
                      textColor: Colors.black,
                    );
                  }
                  // Delete Button function
                  else if (index == 3) {
                    return MyButton(
                      buttontapped: () {
                        setState(() {
                          userInput =
                              userInput.substring(0, userInput.length - 1);
                        });
                      },
                      buttonText: buttons[index],
                      color: Colors.blue[50],
                      textColor: Colors.black,
                    );
                  }
// Power Button function
                  else if (index == 4) {
                    return MyButton(
                      buttontapped: () {
                        setState(() {
                          double findingNumbers = double.parse(buttons[index]);
                          NumberChecker checker = NumberChecker(findingNumbers);
                          userInput += pow(checker.numberfinder, 2).toString();
                        });
                      },
                      buttonText: buttons[index],
                      color: Colors.yellow[50],
                      textColor: const Color.fromARGB(255, 54, 152, 244),
                    );
                  }
                  // Sine Button function
                  else if (index == 5) {
                    return MyButton(
                      buttontapped: () {
                        setState(() {
                          double findingNumbers = double.parse(buttons[index]);
                          NumberChecker checker = NumberChecker(findingNumbers);
                          userInput += sin(checker.numberfinder).toString();
                        });
                      },
                      buttonText: buttons[index],
                      color: Colors.yellow[50],
                      textColor: Colors.red[10],
                    );
                  }
// Cosiine Button function
                  else if (index == 6) {
                    return MyButton(
                      buttontapped: () {
                        setState(() {
                          double findingNumbers = double.parse(buttons[index]);
                          NumberChecker checker = NumberChecker(findingNumbers);
                          userInput += cos(checker.numberfinder).toString();
                        });
                      },
                      buttonText: buttons[index],
                      color: Colors.blue[50],
                      textColor: Colors.green[10],
                    );
                  }
// Tangent Button function
                  else if (index == 7) {
                    return MyButton(
                      buttontapped: () {
                        setState(() {
                          double findingNumbers = double.parse(buttons[index]);
                          NumberChecker checker = NumberChecker(findingNumbers);
                          userInput += tan(checker.numberfinder).toString();
                        });
                      },
                      buttonText: buttons[index],
                      color: const Color.fromARGB(255, 239, 231, 255),
                      textColor: const Color.fromARGB(255, 184, 54, 244),
                    );
                  }
                  // Equal to Button function
                  else if (index == 18) {
                    return MyButton(
                      buttontapped: () {
                        setState(() {
                          equalPressed();
                        });
                      },
                      buttonText: buttons[index],
                      color: Colors.orange[700],
                      textColor: Colors.white,
                    );
                  }

                  //  other buttons
                  else {
                    return MyButton(
                      buttontapped: () {
                        setState(() {
                          userInput += buttons[index];
                        });
                      },
                      buttonText: buttons[index],
                      color: isOperator(buttons[index])
                          ? Colors.blueAccent
                          : Colors.white,
                      textColor: isOperator(buttons[index])
                          ? Colors.white
                          : Colors.black,
                    );
                  }
                }),
          ),
        ],
      ),
    );
  }

// function to calculate the input operation
  void equalPressed() {
    String finaluserinput = userInput;
    finaluserinput = userInput.replaceAll('x', '*');

    Parser p = Parser();
    Expression exp = p.parse(finaluserinput);
    ContextModel cm = ContextModel();
    double eval = exp.evaluate(EvaluationType.REAL, cm);
    answer = eval.toString();
  }
}

class NumberChecker {
  late final double number;
  NumberChecker(this.number);
  set numberFinder(double findingNumber) {
    if (findingNumber == 0 ||
        findingNumber == 1 ||
        findingNumber == 2 ||
        findingNumber == 3 ||
        findingNumber == 4 ||
        findingNumber == 5 ||
        findingNumber == 6 ||
        findingNumber == 7 ||
        findingNumber == 8 ||
        findingNumber == 9) {
      number = findingNumber;
    }
  }

  get numberfinder => number;
}
