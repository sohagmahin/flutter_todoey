import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_todoey/widgets/task_list.dart';
import 'package:flutter_todoey/screen_task/addtask_screen.dart';
import 'package:flutter_todoey/provider/main.dart';
import 'package:provider/provider.dart';
import '../widgets/my_drawer.dart';

class TaskScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => exitDialog(context),
      child: Scaffold(
        drawer: MyDrawer(),
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
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(
                  top: 60.0, left: 30.0, right: 30.0, bottom: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  _buildCustomMenuButton(),
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
                        '${Provider.of<MainModel>(context).taskCount} tasks',
                        style: TextStyle(
                          fontSize: 20.0,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        'Remain: ${Provider.of<MainModel>(context).remainCount}',
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

class _buildCustomMenuButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
              color: Colors.white30,
              blurRadius: 2,
              spreadRadius: 5,
              offset: Offset(0.5, 1))
        ],
      ),
      child: GestureDetector(
        onTap: () {
          print('Tapped');
          Scaffold.of(context).openDrawer();
        },
        child: CircleAvatar(
          radius: 35.0,
          backgroundColor: Theme.of(context).primaryColor,
          child: Icon(
            Icons.list,
            size: 40.0,
            color: Theme.of(context).accentColor,
          ),
        ),
      ),
    );
  }
}
