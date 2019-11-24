import 'package:flutter/material.dart';
class Task {
  String name;
  bool isDone;
  Color color;
  Task({this.name, this.isDone = false,this.color});

  void toggleDone() {
    isDone = !isDone;
  }
}
