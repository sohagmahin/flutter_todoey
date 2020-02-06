import 'package:flutter/material.dart';
class Task {
  final String id;
  final String name;
  bool isDone;
  final Color color;
  Task({this.id,this.name, this.isDone = false,this.color});

  void toggleDone() {
    isDone = !isDone;
  }
}
