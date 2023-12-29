import 'package:flutter/material.dart';
import 'package:flutter_calculator/colors.dart';
import 'buttons.dart';
import 'package:math_expressions/math_expressions.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({
    super.key,
  });

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var userInput = '';
  var answer = '';
  var userInputSize = 50.0;
  var answerSize = 30.0;
  bool hideUserInput = false;
  List<String> buttons = [
    'C',
    'DEL',
    '%',
    '/',
    '7',
    '8',
    '9',
    'X',
    '4',
    '5',
    '6',
    '-',
    '1',
    '2',
    '3',
    '+',
    'SCI',
    '0',
    '.',
    '='
  ];

  bool isOperator(String x) {
    if (x == '%' || x == '/' || x == 'X' || x == '-' || x == '+' || x == '=') {
      return true;
    } else {
      return false;
    }
  }

  bool operatorEntered = false;

  void equalPressed() {
    String finalInput = userInput;
    finalInput = finalInput.replaceAll('X', '*');
    Parser p = Parser();
    Expression exp = p.parse(finalInput);
    ContextModel cm = ContextModel();
    double eval = exp.evaluate(EvaluationType.REAL, cm);
    answer = eval.toString();
    if (answer.endsWith('.0')) {
      answer = answer.substring(0, answer.length - 2);
    }
    userInput = answer;
    // hideUserInput = true;
  }

  void handlePercentage() {
    double currentValue = double.parse(userInput);
    double result = currentValue / 100;
    setState(() {
      userInput = result.toString();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade900,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text(
          'Calculator',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            Expanded(
              flex: 1,
              child: Container(
                padding: const EdgeInsets.all(12),
                width: double.infinity,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      userInput,
                      style: TextStyle(
                          color: Colors.white, fontSize: userInputSize),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      answer,
                      style: TextStyle(
                          color: Colors.white38, fontSize: answerSize),
                    ),
                    const SizedBox(height: 10),
                  ],
                ),
              ),
            ),
            Divider(
              indent: 30,
              endIndent: 30,
              thickness: 0.5,
              color: Colors.grey[700],
            ),
            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: GridView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: buttons.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 4),
                    itemBuilder: (context, index) {
                      if (index == 0) {
                        return CalcButtons(
                            buttonTapped: () {
                              setState(() {
                                userInput = '';
                                answer = '';
                              });
                            },
                            buttonText: buttons[index],
                            buttonColor: buttonColor,
                            buttonTextColor: orangeColor);
                      } else if (index == 1) {
                        return CalcButtons(
                            buttonTapped: () {
                              setState(() {
                                if (userInput.isNotEmpty) {
                                  userInput = userInput.substring(
                                      0, userInput.length - 1);
                                }
                              });
                            },
                            buttonText: buttons[index],
                            buttonColor: buttonColor,
                            buttonTextColor: orangeColor);
                      } else if (index == 2) {
                        return CalcButtons(
                            buttonText: buttons[index],
                            buttonColor: buttonColor,
                            buttonTextColor: orangeColor,
                            buttonTapped: () {
                              handlePercentage();
                            });
                      } else if (index == buttons.length - 1) {
                        return CalcButtons(
                            buttonTapped: () {
                              setState(() {
                                if (userInput.isNotEmpty) {
                                  equalPressed();
                                  userInputSize = 30.0;
                                  answerSize = 50.0;
                                  userInput = answer;
                                  hideUserInput = true;
                                } else {
                                  userInput = '';
                                  hideUserInput = false;
                                }
                              });
                            },
                            buttonText: buttons[index],
                            buttonColor: orangeColor,
                            buttonTextColor: Colors.white);
                      } else {
                        return CalcButtons(
                            buttonTapped: () {
                              setState(() {
                                userInput += buttons[index];
                              });
                            },
                            buttonText: buttons[index],
                            buttonColor: Colors.transparent,
                            buttonTextColor: isOperator(buttons[index])
                                ? Colors.orange.shade600
                                : Colors.white);
                      }
                    }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
