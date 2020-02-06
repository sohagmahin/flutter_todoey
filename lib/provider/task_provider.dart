import 'package:flutter/material.dart';
import 'dart:collection';
import 'package:flutter/foundation.dart';
import 'package:flutter_todoey/models/task.dart';
import 'package:flutter_todoey/helpers/db_helpers.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TaskProvider with ChangeNotifier {
  List<Task> _taskList = [];
  bool _loadingStatus = true;
  int _remainCount = 0;
  SharedPreferences pref;

  bool get isLoading => _loadingStatus;
  int get taskCount => _taskList.length;
  int get remainCount => _remainCount;

  void initialCall() {
    retrieveRemainsCount();
    fetchAndSetData();
  }

  Future initialPref() async {
    if (pref == null) {
      pref = await SharedPreferences.getInstance();
    }
  }

  void retrieveRemainsCount() async {
   await initialPref();
    if (pref.getInt('remainsCount') != null) {
      _remainCount = pref.getInt('remainsCount');
      notifyListeners();
    }
  }

  void _remainCounter(int value) async {
    await initialPref();
    _remainCount = _remainCount + (value);
    notifyListeners();
    pref.setInt('remainsCount', _remainCount);
  }

// Why we use UnmodifiableListView because of turn off the write permission.
// Other reason when we rewrite the code somehow we can write but it not need.
// So it dangerous.
  UnmodifiableListView<Task> get taskList {
    return UnmodifiableListView(_taskList);
  }

  void addTask({Task newTask}) async {
    _taskList.add(newTask);
    _remainCounter(1);
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
    _remainCounter(task.isDone ? -1 : 1);
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
    if (!task.isDone) {
      _remainCounter(-1);
    }
    notifyListeners();
    DBhelpers.deleteTask('task_list', task.id);
  }

  Future<void> fetchAndSetData() async {
    final databaselist = await DBhelpers.getData('task_list');
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

