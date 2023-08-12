import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

class Calculator extends StatefulWidget {
  @override
  State<Calculator> createState() => _CalculatorState();
}

String userInput = "";
String result = "0";

class _CalculatorState extends State<Calculator> {
  List<String> buttonList = [
    'AC',
    '(',
    ')',
    '/',
    '7',
    '8',
    '9',
    '*',
    '4',
    '5',
    '6',
    '+',
    '1',
    '2',
    '3',
    '-',
    'C',
    '0',
    '.',
    '=',
  ];
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: Text("Calculator")),
        backgroundColor: Color.fromARGB(255, 29, 28, 28),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            SizedBox(
              height: MediaQuery.of(context).size.height / 4,
              child: Column(children: <Widget>[
                Container(
                  padding: EdgeInsets.all(10),
                  alignment: Alignment.centerRight,
                  child: Text(
                    userInput,
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Colors.cyan,
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(10),
                  alignment: Alignment.centerRight,
                  child: Text(
                    result,
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Colors.cyan,
                    ),
                  ),
                ),
              ]),
            ),
            Divider(
              color: Colors.white,
            ),
            Expanded(
                child: Container(
              padding: EdgeInsets.all(10),
              child: GridView.builder(
                  itemCount: buttonList.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4,
                      crossAxisSpacing: 12,
                      mainAxisSpacing: 12),
                  itemBuilder: (BuildContext context, int index) {
                    return CustomButton(buttonList[index]);
                  }),
            ))
          ],
        ),
      ),
    );
  }

  Widget CustomButton(String text) {
    return InkWell(
      splashColor: Colors.blueAccent,
      onTap: () {
        setState(() {
          handleButton(text);
        });
      },
      child: Ink(
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(10)),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
                color: Colors.pinkAccent,
                fontSize: 25,
                fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}

handleButton(String text) {
  if (text == 'AC') {
    userInput = "";
    result = "0";
    return;
  } else if (text == 'C') {
    if (userInput.isNotEmpty) {
      userInput = userInput.substring(0, userInput.length - 1);
    } else
      return null;
  } else if (text == '=') {
    result = Calculate();
    userInput = result;
    if (userInput.endsWith(".0")) {
      userInput = userInput.replaceAll(".0", "");
    }

    if (result.endsWith(".0")) {
      result = result.replaceAll(".0", "");
    }
  } else {
    userInput = userInput + text;
  }
}

String Calculate() {
  try {
    var exp = Parser().parse(userInput);
    var evaluation = exp.evaluate(EvaluationType.REAL, ContextModel());
    return evaluation.toString();
  } catch (e) {
    return "error";
  }
}
