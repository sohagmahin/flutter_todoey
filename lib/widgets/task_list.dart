import 'package:flutter/material.dart';
import '../provider/task_provider.dart';
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
      boxShadow: [
        BoxShadow(
            color: Colors.black54,
            blurRadius: 2,
            spreadRadius: 7,
            offset: Offset(5, 1))
      ],
      shape: BoxShape.rectangle,
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(50.0),
        //topRight: Radius.circular(30.0)
      ),
      color: Theme.of(context).backgroundColor,
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
      key: Key(task.id),
      onDismissed: (direction) {
          taskData.deleteTask(task);
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

    var screenSize = MediaQuery.of(context).size;
    double _originalHeight = screenSize.height;
    double _originalWidth = screenSize.width;

    return Container(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
        decoration: _buildBoxDecoration(),
        child: Consumer<TaskProvider>(
          child: Center(
            child: Container(
              height: _originalHeight * 0.30,
              width: _originalWidth * 0.30,
              child: Image(
                image: AssetImage("assets/images/todo_icon.png"),
              ),
            ),
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
