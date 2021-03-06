import 'package:flutter/material.dart';
import 'package:pas_flutter_ifpr22/ui/screens/lista_tarefa/lista_tarefa.dart';

import 'ui/screens/menu/menu_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Projeto Avançado de Software',
      theme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.deepPurple,
      ),
      debugShowCheckedModeBanner: false,
      home: const ListaTarefa(),
    );
  }
}
