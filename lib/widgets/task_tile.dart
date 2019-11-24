import 'package:flutter/material.dart';

class TaskTile extends StatelessWidget {
  final String taskTitle;
  final bool isChecked;
  final Function checkBoxCallBack;
  final Function longPressCallback;
  final Color taskColor;

  TaskTile(
      {this.taskTitle,
      this.isChecked,
      this.checkBoxCallBack,
      this.longPressCallback,
      this.taskColor});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5.0),
      decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(10.0),
          color: taskColor == null? Colors.lightBlueAccent : taskColor),
      child: ListTile(
        onLongPress: longPressCallback,
        title: Text(
          taskTitle,
          style: TextStyle(
            decoration: isChecked ? TextDecoration.lineThrough : null,
            fontSize: 25.0,
            fontFamily: 'Oswald',
          ),
        ),
        trailing: Checkbox(
          activeColor: Colors.lightBlueAccent,
          value: isChecked,
          onChanged: checkBoxCallBack,
        ),
      ),
    );
  }
}
