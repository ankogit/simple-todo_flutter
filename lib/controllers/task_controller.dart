import 'dart:async';
import '../models/task.dart';

class TaskController {
  final StreamController<List<Task>> _tasksStreamController =
      StreamController<List<Task>>.broadcast();

  Stream<List<Task>> get tasksStream => _tasksStreamController.stream;

  List<Task> _tasks = [];

  void addTask(Task task) {
    task.id = DateTime.now().millisecondsSinceEpoch;
    _tasks.add(task);
    _dispatch();
  }

  void updateTask(Task task) {
    int index = _tasks.indexWhere((element) => element.id == task.id);
    if (index != -1) {
      _tasks[index] = task;
      _dispatch();
    }
  }

  void deleteTask(Task task) {
    _tasks.removeWhere((element) => element.id == task.id);
    _dispatch();
  }

  void _dispatch() {
    _tasksStreamController.sink.add(_tasks);
  }

  void dispose() {
    _tasksStreamController.close();
  }
}
