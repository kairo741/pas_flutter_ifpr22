import 'package:flutter/material.dart';
import 'package:pas_flutter_ifpr22/ui/screens/home/home_page.dart';
import 'package:pas_flutter_ifpr22/ui/screens/sparkle/sparkle_page.dart';
import 'package:pas_flutter_ifpr22/ui/screens/tela_teste/tela_teste_page.dart';

import '../calculator/calculator_page.dart';
import 'menu_page.dart';

class MenuWidget extends State<MenuPage> {
  int _counter = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Menu"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            DefaultButtonMenu(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const HomePage(title: "home"),
                ));
              },
              text: "Go home",
            ),
            DefaultButtonMenu(
              onPressed: () => setState(() {
                _counter++;
              }),
              text: "Contador: $_counter",
            ),
            DefaultButtonMenu(
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (context) {
                      return const AlertDialog(
                        content: Text("Hello World"),
                      );
                    });
              },
              text: "Hello World",
            ),
            DefaultButtonMenu(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const TelaTestePage(),
                ));
              },
              text: "Go Tela Teste",
            ),
            DefaultButtonMenu(
              onPressed: () {
                _chooseBday(context);
              },
              text: "Aniversário",
            ),
            DefaultButtonMenu(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const CalculatorPage(),
                ));
              },
              text: "Calculadora",
            ),
          ],
        ),
      ),
    );
  }
}

_chooseBday(context) {
  String name = "";
  DateTime? bday;
  showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: Column(mainAxisSize: MainAxisSize.min, children: [
            TextFormField(
              decoration: const InputDecoration(labelText: "Insira seu nome"),
              onChanged: (value) {
                name = value;
              },
            ),
            IconButton(
                onPressed: () async {
                  bday = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(1900),
                    lastDate: DateTime.now(),
                  );
                },
                icon: const Icon(Icons.calendar_month)),
            DefaultButtonMenu(
                text: "OK",
                onPressed: () async {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const Sparkling(),
                  ));
                  await Future.delayed(const Duration(seconds: 2), () {
                    Navigator.of(context).pop();
                    showDialog(
                        context: context,
                        builder: (context) {
                          return Center(
                            child: Text(
                              "Olá $name Sua idade é ${calculateAge(bday!)}",
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                  color: Colors.white, decoration: TextDecoration.none),
                            ),
                          );
                        });
                  });
                })
          ]),
        );
      });
}

int calculateAge(DateTime userAge) {
  DateTime currentDate = DateTime.now();
  int age = currentDate.year - userAge.year;
  int currentMonth = currentDate.month;
  int userMonthBirt = userAge.month;
  if (userMonthBirt > currentMonth) {
    age--;
  } else if (currentMonth == userMonthBirt) {
    if (userAge.day > currentDate.day) {
      age--;
    }
  }
  return age;
}

class DefaultButtonMenu extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  const DefaultButtonMenu({Key? key, required this.onPressed, required this.text})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(onPressed: onPressed, child: Text(text));
  }
}
