import 'package:flutter/material.dart';
import 'dart:collection';
import 'package:flutter/foundation.dart';
import 'package:flutter_todoey/models/task.dart';

class TaskData extends ChangeNotifier{

  List<Task> _taskList = [
    Task(name: 'Buy milk', isDone: false),
    Task(name: 'Buy cake', isDone: false),
    Task(name: 'Buy rice', isDone: false),
  ];
// Why we use UnmodifiableListView because of turn off the write permission.
// Other reason when we rewrite the code somehow we can write but it not need.
// So it dangerous.
  UnmodifiableListView<Task> get taskList{
    return UnmodifiableListView(_taskList);
  }
  void addTask({Task newTask}) {
    _taskList.add(newTask);
    notifyListeners();
  }

  int get taskCount{
    return _taskList.length;
  }

  void updateTask(Task task){
    task.toggleDone();
    notifyListeners();
  }

  void deleteTask(Task task){
    _taskList.remove(task);
    notifyListeners();
  }
}