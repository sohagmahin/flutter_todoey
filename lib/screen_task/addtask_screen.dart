import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_todoey/provider/task_data.dart';
import 'package:flutter_todoey/models/task.dart';
import 'package:flutter_colorpicker/block_picker.dart';

class AddTask extends StatefulWidget {
  @override
  _AddTaskState createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTask> {
  String newTaskTitle;

  Color pickerColor = Color(0xff443a49);
  Color currentColor = Color(0xff443a49);

  // ValueChanged<Color> callback
  void changeColor(Color color) {
    setState(() => pickerColor = color);
  }

  Future showColorPicker() {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Pick a color!'),
          content: SingleChildScrollView(
            child: BlockPicker(
              pickerColor: currentColor,
              onColorChanged: changeColor,
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: const Text('Got it'),
              onPressed: () {
                setState(() => currentColor = pickerColor);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xff757575),
      child: Container(
        padding: const EdgeInsets.all(20.0),
        decoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20.0),
            topRight: Radius.circular(20.0),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Text(
              'Add Task',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 30.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.lightBlueAccent),
            ),
            TextField(
              autofocus: true,
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.lightBlueAccent, fontSize: 20.0),
              onChanged: (newValue) {
                newTaskTitle = newValue;
              },
            ),
            SizedBox(
              height: 10.0,
            ),
            FlatButton(
              color: Colors.lightBlueAccent,
              child: Text(
                'Choose Color',
                style: TextStyle(color: Colors.white, fontSize: 20.0),
              ),
              onPressed: () {
                showColorPicker();
              },
            ),
            SizedBox(
              height: 10.0,
            ),
            FlatButton(
              child: Text(
                'Add',
                style: TextStyle(color: Colors.white, fontSize: 20.0),
              ),
              color: Colors.lightBlueAccent,
              onPressed: () {
                Task newTask = Task(id:DateTime.now().toString(),name: newTaskTitle, color: currentColor);
                Provider.of<TaskData>(context).addTask(newTask: newTask);
                Navigator.pop(context);
                print(newTaskTitle);
              },
            ),
          ],
        ),
      ),
    );
  }
}
