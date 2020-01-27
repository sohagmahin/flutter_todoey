import 'package:flutter/material.dart';
import 'package:flutter_todoey/widgets/task_list.dart';
import 'package:flutter_todoey/screen_task/addtask_screen.dart';
import 'package:flutter_todoey/provider/task_provider.dart';
import 'package:provider/provider.dart';

class TaskScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.indigo,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.indigoAccent,
        splashColor: Colors.black54,
        child: Icon(
          Icons.add,
          size: 35.0,
        ),
        onPressed: () => showModalBottomSheet(
          context: context,
          builder: (context) => AddTask(),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(
                top: 60.0, left: 30.0, right: 30.0, bottom: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black54,
                        blurRadius: 2,
                        spreadRadius: 5,
                        offset: Offset(0.5,1)
                      )
                    ],
                  ),
                  child: CircleAvatar(
                    radius: 35.0,
                    backgroundColor: Colors.white,
                    child: Icon(
                      Icons.list,
                      size: 40.0,
                      color: Colors.lightBlueAccent,
                    ),
                  ),
                ),
                SizedBox(
                  height: 10.0,
                ),
                Text(
                  'Todoey',
                  style: TextStyle(
                      fontSize: 35.0,
                      color: Colors.white,
                      fontWeight: FontWeight.w700),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      '${Provider.of<TaskProvider>(context).taskCount} tasks',
                      style: TextStyle(
                        fontSize: 20.0,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      'Remain: ${Provider.of<TaskProvider>(context).remainCount}',
                      style: TextStyle(
                        fontSize: 20.0,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10.0,
                ),
              ],
            ),
          ),
          Expanded(
            child: TaskList(),
          )
        ],
      ),
    );
  }
}
