import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/task_provider.dart';
import '../provider/theme_provider.dart';
import 'package:flutter_todoey/models/task.dart';
import 'package:flutter_colorpicker/block_picker.dart';

 final roundedShape = RoundedRectangleBorder(
  borderRadius: BorderRadius.circular(30),
);

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
              child: const Text(
                'Got it',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
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

  void _submitForm() {
    if (newTaskTitle == null) return;
    Task newTask = Task(
        id: DateTime.now().toString(), name: newTaskTitle, color: currentColor);
    Provider.of<TaskProvider>(context).addTask(newTask: newTask);
    Navigator.pop(context);
    print(newTaskTitle);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double originalHeight = size.height;
    double originalWidth = size.width;

    return Container(
      color: Provider.of<ThemeProvider>(context).isDarkTheme
          ? Color(0xff151515)
          : Color(0xff757575),
      child: Container(
        padding: EdgeInsets.only(
            top: originalHeight * 0.020,
            left: originalWidth * 0.020,
            right: originalWidth * 0.020),
        decoration: BoxDecoration(
          color: Theme.of(context).backgroundColor,
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
                  fontSize: 20.0,
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
            MaterialButton(
              color: Theme.of(context).buttonColor,
              elevation: 10,
              shape: roundedShape,
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
            MaterialButton(
              shape: roundedShape,
              child: Text(
                'Add Task',
                style: TextStyle(color: Colors.white, fontSize: 20.0),
              ),
              color: Theme.of(context).buttonColor,
              onPressed: _submitForm,
            ),
          ],
        ),
      ),
    );
  }
}
