import 'package:flutter/material.dart';
import 'package:todo_app/views/task_add_view.dart';
import 'package:todo_app/views/task_list_view.dart';

import 'controllers/task_controller.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // const MyApp({super.key});

  final TaskController _taskController = TaskController();

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Task List',
      initialRoute: '/',
      routes: {
        '/': (context) => TaskListView(controller: _taskController),
        '/add': (context) => TaskAddView(controller: _taskController),
      },
    );
  }

  @override
  void dispose() {
    _taskController.dispose();
    // super.d();
  }
}
