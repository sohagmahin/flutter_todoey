import 'package:flutter/material.dart';
import 'package:flutter_todoey/screen_task/splash_screen.dart';
import './provider/task_provider.dart';
import './provider/theme_provider.dart';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => TaskProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => ThemeProvider(),
        ),
      ],
      child: Consumer<ThemeProvider>(
        builder: (context, themeData, ch) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: themeData.getTheme,
            home: ch,
          );
        },
        child: SplashScreen(),
      ),
    );
  }
}
