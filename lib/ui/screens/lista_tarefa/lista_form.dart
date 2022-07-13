import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class ListaForm extends StatelessWidget {
  ListaForm({Key? key}) : super(key: key);

  register(int? id, String name, String desc) async {
    String dbPath = join(await getDatabasesPath(), 'database.db');

    Database database = await openDatabase(dbPath);
    String sql;
    if (id == null) {
      sql = 'INSERT INTO tarefa (nome, descricao) VALUES (?,?)';
      await database.rawInsert(sql, [name, desc]);
    } else {
      sql = 'UPDATE tarefa SET nome=?, descricao=? WHERE id=?';
      await database.rawUpdate(sql, [name, desc, id]);
    }
  }

  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Cadastrar"),
        ),
        body: Form(
          key: _formKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                TextFormField(
                    controller: _nameController,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    decoration: const InputDecoration(label: Text("Nome")),
                    validator: _validate),
                TextFormField(
                    controller: _descController,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    decoration: const InputDecoration(label: Text("Descrição")),
                    validator: _validate),
                TextButton.icon(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      await register(null, _nameController.text, _descController.text).then((_) {
                        Navigator.pop(context);
                      });
                    }
                  },
                  icon: const Icon(Icons.save),
                  label: const Text("Salvar"),
                )
              ],
            ),
          ),
        ));
  }

  String? _validate(value) {
    if (value == null || value.isEmpty) {
      return 'Este campo não pode ser vazio';
    }
    return null;
  }
}
