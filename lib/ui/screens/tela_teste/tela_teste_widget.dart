import 'package:flutter/material.dart';

import 'tela_teste_page.dart';

class TelaTesteWidget extends State<TelaTestePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("TelaTeste"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            DatePickerDialog(
                initialDate: DateTime.now(), firstDate: DateTime.now(), lastDate: DateTime(2048))
          ],
        ),
      ),
    );
  }
}
