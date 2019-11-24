import 'package:flutter/material.dart';
import 'package:flutter_todoey/models/task_data.dart';
import 'task_tile.dart';
import 'package:provider/provider.dart';
import 'package:flutter_todoey/models/task.dart';

class TaskList extends StatefulWidget {
  @override
  _TaskListState createState() => _TaskListState();
}

class _TaskListState extends State<TaskList> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(60.0),
              //topRight: Radius.circular(30.0)
          ),
          color: Colors.white),
      child: Consumer<TaskData>(
        builder: (context, taskData, child) {
          return ListView.builder(
              itemCount: taskData.taskCount,
              itemBuilder: (context, index) {
                Task task = taskData.taskList[index];
                return TaskTile(
                  taskTitle: task.name,
                  isChecked: task.isDone,
                  checkBoxCallBack: (_) {
                    taskData.updateTask(task);
                  },
                  longPressCallback: (){
                    taskData.deleteTask(task);
                  },
                  taskColor: task.color,
                );
              });
        },
      ),
    );
  }
}
