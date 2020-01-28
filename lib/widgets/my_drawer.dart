import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/main.dart';
class MyDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double _height_container = MediaQuery.of(context).size.height*0.20;
    return Drawer(
        child: SafeArea(
          child: Column(
            children: <Widget>[
              Container(
                height: _height_container,
                child: Center(
                  child: Container(
                    decoration: BoxDecoration(boxShadow: [
                      BoxShadow(
                          color: Colors.black54,
                          blurRadius: 5,
                          spreadRadius: 8,
                          offset: Offset.zero)
                    ],shape: BoxShape.circle),
                    child: CircleAvatar(
                      backgroundImage: AssetImage("assets/images/drawer_icon.jpg"),
                      radius: _height_container*0.35,
                    ),
                  ),
                ),
                decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black,
                          blurRadius: 1,
                          spreadRadius: 1,
                          offset: Offset(0, 1))
                    ],
                    gradient: LinearGradient(
                      colors: [Colors.indigoAccent, Colors.orange],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      stops: [0.6, 1],
                    ),
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(10.0),
                        bottomRight: Radius.circular(10.0))),
              ),
              Consumer<MainModel>(
                builder: (context, mainModel, ch) {
                  return SwitchListTile(
                    title: Text('Dark Mode'),
                    value: mainModel.isDarkTheme,
                    onChanged: (value) {
                      mainModel.toggleTheme();
                    },
                  );
                },
              ),
              //SizedBox(height: 2,child: Container(color:Colors.grey),),
              ListTile(
                leading: Icon(Icons.person_outline),
                title: Text('About'),
                onTap: () {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: Text('About'),
                          content: Text(
                              'Build by Flutter!\nCreated by SOHAG\nFacebook: fb.com/sohagmahin\nEmail: sohagmahin@gmail.com'),
                        );
                      });
                },
              ),
            ],
          ),
        ));
  }
}
