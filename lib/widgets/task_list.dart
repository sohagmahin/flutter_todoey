import 'package:flutter/material.dart';
import 'package:flutter_todoey/provider/task_data.dart';
import 'task_tile.dart';
import 'package:provider/provider.dart';
import 'package:flutter_todoey/models/task.dart';

class TaskList extends StatefulWidget {
  @override
  _TaskListState createState() => _TaskListState();
}

class _TaskListState extends State<TaskList> {
  Decoration deleteDecoration() {
    return BoxDecoration(
      shape: BoxShape.rectangle,
      borderRadius: BorderRadius.circular(10.0),
      color: Colors.redAccent,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(50.0),
            //topRight: Radius.circular(30.0)
          ),
          color: Colors.white),
      child: Consumer<TaskData>(
        builder: (context, taskData, child) {
          return ListView.builder(
              itemCount: taskData.taskCount,
              itemBuilder: (context, index) {
                Task task = taskData.taskList[index];
                return Dismissible(
                  direction: DismissDirection.endToStart,
                  movementDuration: Duration(milliseconds: 800),
                  background: Container(
                    margin: const EdgeInsets.symmetric(vertical: 5.0),
                    padding: EdgeInsets.only(right: 10.0),
                    alignment: AlignmentDirectional.centerEnd,
                    decoration: deleteDecoration(),
                    child: Icon(Icons.delete),
                  ),
                  key: Key(task.name),
                  onDismissed: (DismissDirection direction) {
                    if (direction == DismissDirection.endToStart) {
                      taskData.deleteTask(task);
                      print('end to start');
                    }
                  },
                  child: TaskTile(
                    taskTitle: task.name,
                    isChecked: task.isDone,

                    //For onTap
                    checkBoxCallBack: () {
                      taskData.updateTask(task);
                    },
                    taskColor: task.color,
                  ),
                );
              });
        },
      ),
    );
  }
}
