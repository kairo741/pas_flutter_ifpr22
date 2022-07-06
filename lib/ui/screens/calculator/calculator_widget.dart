import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

import 'calculator_page.dart';

class CalculatorWidget extends State<CalculatorPage> {
  var calcButtons = [
    "%",
    "CE",
    "C",
    "<",
    "7",
    "8",
    "9",
    "X",
    "4",
    "5",
    "6",
    "-",
    "1",
    "2",
    "3",
    "+",
    "+/-",
    "0",
    ",",
    "=",
  ];

  var calc = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Calculator"),
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              height: 100,
              child: Text(
                calc,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(fontSize: 50),
              ),
            ),
            Expanded(
              child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                      maxCrossAxisExtent: 100,
                      // childAspectRatio: 5 / 2,
                      crossAxisSpacing: 4,
                      mainAxisSpacing: 4),
                  itemCount: calcButtons.length,
                  itemBuilder: (BuildContext ctx, index) {
                    return InkWell(
                      onTap: () {
                        setState(() {
                          useButton(calcButtons[index]);
                        });
                      },
                      child: Container(
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 71, 54, 58),
                            borderRadius: BorderRadius.circular(15)),
                        child: Text(calcButtons[index]),
                      ),
                    );
                  }),
            ),
          ],
        ),
      ),
    );
  }

  useButton(String button) {
    switch (button) {
      case "C":
        calc = "";
        break;
      case "CE":
        calc = "";
        break;
      case "+/-":
        break;
      case "=":

      default:
        calc += button;
        break;
    }
  }

  calculate(expression) {
    var parser = Parser();
    var result = parser.parse(expression).evaluate(EvaluationType.REAL, ContextModel());
    return result.toString();
  }
}
