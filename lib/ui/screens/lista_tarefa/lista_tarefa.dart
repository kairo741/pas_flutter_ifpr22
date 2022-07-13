import 'package:flutter/material.dart';
import 'package:pas_flutter_ifpr22/ui/screens/lista_tarefa/lista_form.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class ListaTarefa extends StatefulWidget {
  const ListaTarefa({Key? key}) : super(key: key);

  @override
  State<ListaTarefa> createState() => _ListaTarefaState();
}

class _ListaTarefaState extends State<ListaTarefa> {
  Future<List<Map<String, Object?>>> buscarDados() async {
    String dbPath = join(await getDatabasesPath(), 'database.db');

    Database database = await openDatabase(dbPath, version: 1, onCreate: (db, version) {
      db.execute('''
        CREATE IF NOT EXISTS TABLE tarefa(
        id INTEGER PRIMARY KEY
        , nome TEXT NOT NULL
        , descricao TEXT NOT NULL
        );
        ''');
      db.execute('''
        INSERT INTO tarefa (nome, descricao) 
        VALUES ("Tarefa 1","Lorem Ipsum is simply dummy text of the printing and typesetting industry.");
        ''');
      db.execute('''
        INSERT INTO tarefa (nome, descricao) 
        VALUES ("Tarefa 2","Lorem Ipsum is simply dummy text of the printing and typesetting industry.");
        ''');
      db.execute('''
        INSERT INTO tarefa (nome, descricao) 
        VALUES ("Tarefa 3","Lorem Ipsum is simply dummy text of the printing and typesetting industry.")
        ''');
    });

    await Future.delayed(const Duration(seconds: 1));
    List<Map<String, dynamic>> tarefas = await database.query('tarefa');
    setState(() {});
    return tarefas;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Lista de Tarefas"),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ListaForm(),
                )),
          )
        ],
      ),
      body: FutureBuilder(
        future: buscarDados(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) return const Center(child: CircularProgressIndicator());
          var tarefas = (snapshot.data as List<Map<String, dynamic>>);
          return ListView.builder(
            itemCount: tarefas.length,
            itemBuilder: (context, index) {
              var tarefa = tarefas[index];
              return Card(
                // elevation: 1000,
                child: ListTile(
                  title: Text(tarefa["nome"]!.toString()),
                  subtitle: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(tarefa["descricao"]!.toString()),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
