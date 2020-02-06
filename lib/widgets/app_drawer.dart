import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/theme_provider.dart';

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double _heightContainer = MediaQuery.of(context).size.height * 0.20;
    return Drawer(
        child: SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              height: _heightContainer,
              child: Center(
                child: Container(
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black54,
                        blurRadius: 5,
                        spreadRadius: 8,
                        offset: Offset.zero,
                      ),
                    ],
                    shape: BoxShape.circle,
                  ),
                  child: CircleAvatar(
                    backgroundImage: AssetImage("assets/images/drawer_icon.jpg"),
                    radius: _heightContainer * 0.35,
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
            Consumer<ThemeProvider>(
              builder: (context, mainModel, ch) {
                return SwitchListTile(
                  title: ch,
                  value: mainModel.isDarkTheme,
                  onChanged: (value) {
                    mainModel.toggleTheme();
                  },
                );
              },
              child: Text('Dark Mode'),
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
      ),
    ));
  }
}
