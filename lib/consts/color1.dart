import 'package:flutter/material.dart';

const MaterialColor primary = MaterialColor(_primaryPrimaryValue, <int, Color>{
  50: Color(0xFFE0EFF5),
  100: Color(0xFFB3D7E6),
  200: Color(0xFF80BCD5),
  300: Color(0xFF4DA1C4),
  400: Color(0xFF268CB7),
  500: Color(_primaryPrimaryValue),
  600: Color(0xFF0070A3),
  700: Color(0xFF006599),
  800: Color(0xFF005B90),
  900: Color(0xFF00487F),
});
const int _primaryPrimaryValue = 0xFF0078AA;

const MaterialColor primaryAccent =
    MaterialColor(_primaryAccentValue, <int, Color>{
  100: Color(0xFFADD5FF),
  200: Color(_primaryAccentValue),
  400: Color(0xFF47A2FF),
  700: Color(0xFF2D95FF),
});
const int _primaryAccentValue = 0xFF7ABCFF;
