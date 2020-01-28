import 'package:flutter/material.dart';
import 'package:flutter_todoey/provider/task_provider.dart';
import 'screen_task/task_screen.dart';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp,DeviceOrientation.portraitDown]);
    return ChangeNotifierProvider<TaskProvider>(
      create: (context)=> TaskProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: TaskScreen(),
      ),
    );
  }
}
