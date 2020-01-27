import 'package:flutter/material.dart';

class TaskTile extends StatelessWidget {
  final String taskTitle;
  final bool isChecked;

  //Using two different checkBoxCallBack method but worked are both same.
  //Coz i used for avoiding null error of ListTile checkbox.
  //ListTile checkbox does't support null Function.
  //final Function checkBoxCallBack;
  final Function checkBoxCallBack;
  final Color taskColor;

  TaskTile(
      {this.taskTitle,
      this.isChecked,
      this.checkBoxCallBack,
      this.taskColor});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5.0,horizontal: 6.0),
      decoration: BoxDecoration(
        boxShadow: [BoxShadow(color: Colors.black54,blurRadius: 2,spreadRadius: 1,offset: Offset(2,2),)],
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
          ),
        ),
        trailing: Checkbox(
          activeColor: Colors.lightBlueAccent,
          value: isChecked,
//          No need this function because we attached onTap Function
//          on whole ListTile to check the checkbox.
        //  onChanged: (isChecked){
        //  },
        ),
      ),
    );
  }
}
