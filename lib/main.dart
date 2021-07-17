import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:math_expressions/math_expressions.dart';
import 'buttons.dart';

void main() {
  runApp(const MyApp());
  SystemChrome.setPreferredOrientations([]);
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var userQuestion = '';
  var userAnswer = '0';

  final List<String> buttons = [
    '/',
    '7',
    '8',
    '9',
    'x',
    '4',
    '5',
    '6',
    '-',
    '1',
    '2',
    '3',
    '+',
    '(',
    '0',
    ')',
    '.',
    'AC',
    'Del',
    '='
  ];

  bool darkMode = true;
  onSwitchValChanged(bool newValue) {
    setState(() {
      darkMode = newValue;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: darkMode ? const Color(0xFF292B2F) : Colors.grey[300],
      body: SafeArea(
        child: Column(
          children: <Widget>[
            // toggle between themes
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Switch(
                  value: darkMode,
                  onChanged: (newVal) {
                    onSwitchValChanged(newVal);
                  },
                  activeColor: Colors.white,
                  inactiveThumbColor: Colors.black,
                ),
                Text(
                  darkMode ? "Switch to Light Theme" : "Switch to Dark Theme",
                  style: TextStyle(
                    fontSize: 15.0,
                    letterSpacing: 3.0,
                    fontWeight: FontWeight.w500,
                    color: darkMode ? Colors.grey[300] : Colors.grey[900],
                  ),
                ),
              ],
            ),
            // input and evaluation box
            Expanded(
              child: Container(
                margin: const EdgeInsets.symmetric(
                  vertical: 5.0,
                  horizontal: 10.0,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Container(
                      padding: const EdgeInsets.symmetric(
                        vertical: 15.0,
                        horizontal: 20.0,
                      ),
                      alignment: Alignment.centerLeft,
                      child: Text(
                        userQuestion,
                        style: TextStyle(
                          fontSize: 25,
                          color: darkMode ? Colors.white : Colors.grey[900],
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        vertical: 15.0,
                        horizontal: 20.0,
                      ),
                      alignment: Alignment.centerRight,
                      child: Text(
                        userAnswer,
                        style: TextStyle(
                          fontSize: 40.0,
                          color: darkMode ? Colors.white : Colors.grey[900],
                        ),
                      ),
                    ),
                  ],
                ),
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(20.0)),
                  color: darkMode ? const Color(0xFF292B2F) : Colors.grey[300],
                  boxShadow: [
                    BoxShadow(
                      color: darkMode ? Colors.black : Colors.grey.shade600,
                      offset: const Offset(5.0, 5.0),
                      blurRadius: 20.0,
                      spreadRadius: 1.0,
                    ),
                    BoxShadow(
                      color: darkMode ? Colors.grey.shade800 : Colors.white,
                      offset: const Offset(-5.0, -5.0),
                      blurRadius: 10.0,
                      spreadRadius: 1.0,
                    ),
                  ],
                ),
              ),
            ),
            // button pad
            Expanded(
              flex: 3,
              child: Container(
                child: GridView.builder(
                  itemCount: buttons.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4,
                  ),
                  itemBuilder: (BuildContext context, int index) {
                    return FirstButton(
                      mode: darkMode,
                      buttonText: buttons[index],
                      buttonTapped: () {
                        setState(() {
                          if (buttons[index] == 'Del') {
                            userQuestion = userQuestion.substring(
                                0, userQuestion.length - 1);
                            userAnswer = '';
                          } else if (buttons[index] == 'AC') {
                            userQuestion = '';
                            userAnswer = '';
                          } else if (buttons[index] == '=') {
                            equalPressed();
                          } else {
                            userQuestion += buttons[index];
                          }
                        });
                      },
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void equalPressed() {
    String finalQuestion = userQuestion;
    finalQuestion = finalQuestion.replaceAll('x', '*');
    Parser p = Parser();
    Expression exp = p.parse(finalQuestion);
    ContextModel cm = ContextModel();
    double eval = exp.evaluate(EvaluationType.REAL, cm);
    userAnswer = eval.toString();
  }
}
