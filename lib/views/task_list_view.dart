import 'package:flutter/material.dart';
import '../controllers/task_controller.dart';
import '../models/task.dart';

class TaskListView extends StatefulWidget {
  final TaskController controller;

  TaskListView({required this.controller});

  @override
  _TaskListViewState createState() => _TaskListViewState();
}

class _TaskListViewState extends State<TaskListView> {
  // void _addAction() {}

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Task>>(
      stream: widget.controller.tasksStream,
      builder: (BuildContext context, AsyncSnapshot<List<Task>> snapshot) {
        if (!snapshot.hasData) {
          return Scaffold(
            appBar: AppBar(
              title: const Text('Simple Task Tracker'),
            ),
            body: Center(
              child: CircularProgressIndicator(),
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                Navigator.pushNamed(context, "/add");
              },
              tooltip: 'Increment',
              child: Icon(Icons.add),
            ), // This trailing comma makes auto-formatting nicer for build methods.
          );
        } else {
          return Scaffold(
              appBar: AppBar(
                title: const Text('Simple Task Tracker'),
              ),
              body: ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  Task task = snapshot.data![index];

                  return ListTile(
                    title: Text(task.name),
                    leading: Checkbox(
                      // value: false,
                      value: task.isComplete,
                      onChanged: (bool? value) {
                        if (value != null) {
                          task.isComplete = value;
                          widget.controller.updateTask(task);
                        }
                      },
                    ),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () {
                        widget.controller.deleteTask(task);
                      },
                    ),
                  );
                },
              ),
              floatingActionButton: FloatingActionButton(
                onPressed: () {
                  Navigator.pushNamed(context, "/add");
                },
                tooltip: 'Increment',
                child: Icon(Icons.add),
              ));
        }
      },
    );
  }
}
