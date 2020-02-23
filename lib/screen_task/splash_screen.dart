import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_todoey/screen_task/task_screen.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  AnimationController controller;
  Animation animation;
  @override
  void initState() {
    super.initState();

    controller =
        AnimationController(vsync: this, duration: Duration(seconds: 1));
    animation = CurvedAnimation(parent: controller, curve: Curves.decelerate);

    controller.forward();

    controller.addListener(() {
      setState(() {});
    });

    Timer(Duration(seconds: 2), () {
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => TaskScreen()));
    });
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlueAccent,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Center(
            child: Container(
              height: animation.value*150,
              child: Image(
                image: AssetImage('assets/images/todo_icon.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(
            height: 10.0,
          ),
          Center(
              child: TyperAnimatedTextKit(
            text: ['Daily Task!'],
            speed: Duration(milliseconds: 100),
            isRepeatingAnimation: false,
            textStyle: TextStyle(
                fontFamily: 'OdibeeSans',
                fontSize: 50.0,
                color: Colors.limeAccent),
          )),
        ],
      ),
    );
  }
}
