import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import '../models/task.dart';

class TaskProvider with ChangeNotifier {
  List<Task> _tasks = [];

  List<Task> get tasks => _tasks;

  void addTask(Task task) {
    _tasks.add(task);
    Hive.box('tasksBox').put(task.title, task);
    notifyListeners();
  }

  void toggleComplete(Task task) {
    task.isCompleted = !task.isCompleted;
    Hive.box('tasksBox').put(task.title, task);
    notifyListeners();
  }

  void loadTasks() {
    var box = Hive.box('tasksBox');
    _tasks = box.values.toList().cast<Task>();
    notifyListeners();
  }
}
