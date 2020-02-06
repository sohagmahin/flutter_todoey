import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/theme_provider.dart';

class TaskTile extends StatelessWidget {
  final String taskTitle;
  final bool isChecked;
  final Function checkBoxCallBack;
  final Color taskColor;

  TaskTile(
      {this.taskTitle, this.isChecked, this.checkBoxCallBack, this.taskColor});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 6.0),
      decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: shadowColor(context),
              blurRadius: 2,
              spreadRadius: 1,
              offset: Offset(2, 2),
            )
          ],
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(10.0),
          color: taskColor == null ? Colors.lightBlueAccent : taskColor),
      child: ListTile(
        onTap: checkBoxCallBack,
        title: Text(
          taskTitle,
          style: TextStyle(
            decoration: isChecked ? TextDecoration.lineThrough : null,
            fontSize: 25.0,
            fontFamily: 'Oswald',
            fontStyle: isChecked? FontStyle.italic : FontStyle.normal,
            fontWeight: isChecked? FontWeight.bold: null,
            color: Colors.black
          ),
        ),
        trailing: Checkbox(
          activeColor: Colors.lightBlueAccent,
          value: isChecked,
//          onChanged: (_){},
        ),
      ),
    );
  }

//changing the shadow color based on ThemeData
  Color shadowColor(BuildContext context) {
    print('inside shadow Color');
    return Provider.of<ThemeProvider>(context, listen: false).isDarkTheme
        ? Colors.white12
        : Colors.black54;
  }
}
