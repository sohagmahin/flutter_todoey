import 'package:flutter/material.dart';

class CustomMenuButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    Size size = MediaQuery.of(context).size;
    double originalHeight = size.height;

    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
              color: Colors.white30,
              blurRadius: originalHeight*0.002,
              spreadRadius: originalHeight*0.007,
              offset: Offset(0.5, 1))
        ],
      ),
      child: GestureDetector(
        onTap: () {
          Scaffold.of(context).openDrawer();
        },
        child: CircleAvatar(
          radius: originalHeight*0.05,
          backgroundColor: Theme.of(context).primaryColor,
          child: Icon(
            Icons.list,
            size: originalHeight*0.05,
            color: Theme.of(context).accentColor,
          ),
        ),
      ),
    );
  }
}