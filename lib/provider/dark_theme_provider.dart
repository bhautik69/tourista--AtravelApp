import 'package:demo/services/dark_Theme_prefs.dart';
import 'package:flutter/material.dart';

class DarkThemeProvider with ChangeNotifier {
  DarkThemePrefs darkThemePrefs = DarkThemePrefs();
  bool _darkThem = false;
  bool get getDarkTheme => _darkThem;
  set setDarkTheme(bool value) {
    _darkThem = value;
    darkThemePrefs.setDarkTheme(value);
    notifyListeners();
  }
}
