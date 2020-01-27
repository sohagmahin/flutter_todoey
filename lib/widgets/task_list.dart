import 'package:flutter/material.dart';
import 'package:flutter_todoey/provider/task_provider.dart';
import 'task_tile.dart';
import 'package:provider/provider.dart';
import 'package:flutter_todoey/models/task.dart';

class TaskList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _TaskListState();
  }
}

class _TaskListState extends State<TaskList> {
  Decoration _buildBoxDecoration() {
    return BoxDecoration(
      shape: BoxShape.rectangle,
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(50.0),
        //topRight: Radius.circular(30.0)
      ),
      color: Colors.white,
    );
  }

  Decoration _buildDeleteDecoration() {
    return BoxDecoration(
      shape: BoxShape.rectangle,
      borderRadius: BorderRadius.circular(10.0),
      color: Colors.redAccent,
    );
  }

  Widget _buildBackgroundWidget() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5.0),
      padding: EdgeInsets.only(right: 10.0),
      alignment: AlignmentDirectional.centerEnd,
      decoration: _buildDeleteDecoration(),
      child: Icon(Icons.delete),
    );
  }

  Widget _buildDismissibleWidget(TaskProvider taskData, int index) {
    Task task = taskData.taskList[index];
    return Dismissible(
      direction: DismissDirection.endToStart,
      movementDuration: Duration(milliseconds: 800),
      background: _buildBackgroundWidget(),
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
  }

  @override
  void initState() {
    super.initState();
    Provider.of<TaskProvider>(context, listen: false).initialCall();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 20.0),
        decoration: _buildBoxDecoration(),
        child: Consumer<TaskProvider>(
          child: Center(
            child: Text('No item founds!'),
          ),
          builder: (context, taskData, ch) {
            return taskData.isLoading
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : taskData.taskList.length == 0
                    ? ch
                    : ListView.builder(
                        itemCount: taskData.taskCount,
                        itemBuilder: (context, index) {
                          return _buildDismissibleWidget(taskData, index);
                        },
                      );
          },
        ));
  }
}
