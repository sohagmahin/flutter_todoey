import 'package:flutter/material.dart';
import 'package:flutter_todoey/models/task_data.dart';
import 'screen_task/task_screen.dart';

import 'package:provider/provider.dart';
import 'models/task.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<TaskData>(
      builder: (context)=> TaskData(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: TaskScreen(),
      ),
    );
  }
}
