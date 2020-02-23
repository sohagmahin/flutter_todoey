import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_todoey/widgets/custom_menu_button.dart';
import 'package:flutter_todoey/widgets/task_list.dart';
import 'package:flutter_todoey/screen_task/addtask_screen.dart';
import 'package:flutter_todoey/provider/task_provider.dart';
import 'package:provider/provider.dart';
import 'package:flutter_todoey/widgets/app_drawer.dart';

class TaskScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double originalHeight = size.height;
    double originalWidth = size.width;
    return WillPopScope(
      onWillPop: () => exitDialog(context),
      child: Scaffold(
        drawer: AppDrawer(),
        backgroundColor: Theme.of(context).primaryColor,
        floatingActionButton: FloatingActionButton(
          backgroundColor: Theme.of(context).primaryColor,
          splashColor: Theme.of(context).splashColor,
          child: Icon(
            Icons.add,
            size: 35.0,
            color: Colors.white,
          ),
          onPressed: () => showModalBottomSheet(
            context: context,
            builder: (context) => AddTask(),
          ),
        ),
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(
                    top: originalHeight * 0.04,
                    left: originalWidth * 0.06,
                    right: originalWidth * 0.06),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    CustomMenuButton(),
                    SizedBox(
                      height: 10.0,
                    ),
                    Text(
                      'Todoey',
                      style: TextStyle(
                          fontSize: originalHeight * 0.050,
                          color: Colors.white,
                          fontWeight: FontWeight.w700),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          '${Provider.of<TaskProvider>(context).taskCount} tasks',
                          style: TextStyle(
                            fontSize: originalHeight * 0.03,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          'Remain: ${Provider.of<TaskProvider>(context).remainCount}',
                          style: TextStyle(
                            fontSize: originalHeight * 0.03,
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
        ),
      ),
    );
  }

  Future<bool> exitDialog(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Do you want to exit'),
        actions: <Widget>[
          FlatButton(
            child: Text('No'),
            onPressed: () => Navigator.of(context).pop(),
          ),
          FlatButton(
            child: Text('Yes'),
            onPressed: () => exit(0),
          ),
        ],
      ),
    );
  }
}


