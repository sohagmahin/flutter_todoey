import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider with ChangeNotifier {
  final String key = 'theme';
  bool _darkTheme = false;
  SharedPreferences pref;

  ThemeProvider(){
    _loadData();
  }

  Future initialPref() async {
    if (pref == null) {
      pref = await SharedPreferences.getInstance();
    }
  }

  ThemeData dark() {
    return ThemeData(
      brightness: Brightness.dark,
      accentColor: Colors.white30,
      backgroundColor: Colors.white12,
      buttonColor: Colors.grey,
      splashColor: Colors.white30,
    );
  }

  ThemeData light() {
    return ThemeData(
      brightness: Brightness.light,
      primaryColor: Colors.indigo,
      accentColor: Colors.greenAccent,
      backgroundColor: Colors.white,
      buttonColor: Colors.indigoAccent,
      splashColor: Colors.white30,
    );
  }

  bool get isDarkTheme => _darkTheme;
  ThemeData get getTheme {
    return _darkTheme ? dark() : light();
  }

  toggleTheme() {
    _darkTheme = !_darkTheme;
    pref.setBool(key, _darkTheme);
    notifyListeners();
  }

  _loadData() async {
    await initialPref();
    _darkTheme = pref.getBool(key) ?? false;
    notifyListeners();
  }
}