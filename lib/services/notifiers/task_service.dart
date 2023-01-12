import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:procrasti_buddy/database/task_manager/task_manager.dart';

class TaskCRUDNotifer with ChangeNotifier {
  late Box<Task> _taskBox;

  TaskCRUDNotifer() {
    _taskBox = Hive.box<Task>('tasks');
  }

  List<Task> get tasks => _taskBox.values.toList();

  void addTask({required Task task}) {
    _taskBox.add(task);
    notifyListeners();
  }

  void updateTask({required Task task, required int index}) {
    _taskBox.putAt(index, task);
    notifyListeners();
  }

  void deleteTask({required int index}) {
    _taskBox.deleteAt(index);
    notifyListeners();
  }

  Future<void> deleteAll() async {
    await _taskBox.deleteAll(_taskBox.keys);
    notifyListeners();
  }

  List<Task> getAllTasks() {
    return _taskBox.values.toList();
  }

  Task? getTaskById(int id) {
    return _taskBox.get(id);
  }
}
