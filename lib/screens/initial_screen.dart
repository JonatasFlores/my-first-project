// import 'package:alura_flutter_curso_1/components/tasks.dart';
import 'package:alura_flutter_curso_1/data/task_inherited.dart';
import 'package:alura_flutter_curso_1/screens/form_screen.dart';
import 'package:flutter/material.dart';

class InitialScreen extends StatefulWidget {
  const InitialScreen({Key? key}) : super(key: key);

  @override
  State<InitialScreen> createState() => _InitialScreenState();
}

class _InitialScreenState extends State<InitialScreen> {
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tarefas'),
        titleTextStyle: TextStyle(color: Colors.white, fontSize: 24),
        leading: Icon(Icons.add_task),
        backgroundColor: Colors.blue,
      ),
      body: Container(
        color: Color.fromARGB(255, 208, 221, 237),
        child: ListView(
          children: TaskInherited.of(context).taskList,
          padding: EdgeInsets.only(top: 8, bottom: 70),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: ((contextNew) => FormScreen(
                    taskContext: context,
                  )),
            ),
          );
        },
        backgroundColor: Colors.blue[100],
        child: const Icon(Icons.add),
      ),
    );
  }
}
