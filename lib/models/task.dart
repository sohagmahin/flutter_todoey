import 'package:flutter/material.dart';
class Task {
  String id;
  String name;
  bool isDone;
  Color color;
  Task({this.id,this.name, this.isDone = false,this.color});

  void toggleDone() {
    isDone = !isDone;
  }
}
