import 'package:flutter/material.dart';
import 'dart:collection';
import 'package:flutter/foundation.dart';
import 'package:flutter_todoey/models/task.dart';
import 'package:flutter_todoey/helpers/db_helpers.dart';

class TaskProvider extends ChangeNotifier {
  List<Task> _taskList = [
  ];
  bool _loadingStatus = true;


  bool get isLoading=>_loadingStatus;
  int get taskCount =>_taskList.length;

// Why we use UnmodifiableListView because of turn off the write permission.
// Other reason when we rewrite the code somehow we can write but it not need.
// So it dangerous.
  UnmodifiableListView<Task> get taskList {
    return UnmodifiableListView(_taskList);
  }

  void addTask({Task newTask}) async {
    _taskList.add(newTask);
    notifyListeners();
    DBhelpers.insertTask('task_list', {
      'id': newTask.id,
      'name': newTask.name,
      'isDone': newTask.isDone,
      'color': newTask.color.value
    });
  }

  void updateTask(Task task) {
    task.toggleDone();
    notifyListeners();
    DBhelpers.updateTask('task_list', {
      'id': task.id,
      'name': task.name,
      'isDone': task.isDone,
      'color': task.color.value
    });
  }

  void deleteTask(Task task) {
    _taskList.remove(task);
    notifyListeners();
    DBhelpers.deleteTask('task_list', task.id);
  }

  Future<void> fetchAndSetData() async {
    final databaselist = await DBhelpers.getData('task_list');
    print('Database size : ' + databaselist.length.toString());
    _taskList = databaselist.map((task) {
      return Task(
        id: task['id'],
        name: task['name'],
        isDone: task['isDone'] == 1 ? true : false,
        color: Color(task['color']),
      );
    }).toList();
    
    _loadingStatus = false;
    notifyListeners();
  }
}
