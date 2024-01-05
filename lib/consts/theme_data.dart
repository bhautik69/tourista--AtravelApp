import 'package:flutter/material.dart';

class ThemeStyle {
  static ThemeData themeDate(bool isDarkTheme, BuildContext context) {
    return ThemeData(
        colorScheme: ThemeData().colorScheme.copyWith(
            secondary: isDarkTheme ? Colors.black : Colors.white,
            brightness: isDarkTheme ? Brightness.dark : Brightness.light),
        scaffoldBackgroundColor:
            isDarkTheme ? const Color(0xff121212) : const Color(0xFFffffff),
        appBarTheme: AppBarTheme(
          color:
              isDarkTheme ? const Color(0xff212121) : const Color(0xff0078aa),
          titleTextStyle: const TextStyle(
              color: Colors.white, fontSize: 22, fontWeight: FontWeight.w500),
        ),
        primaryColor: const Color(0xff0078aa),
        cardColor:
            isDarkTheme ? const Color(0xff212121) : const Color(0xfff2fdfd),
        canvasColor: isDarkTheme ? const Color(0xff212121) : Colors.grey[50],
        buttonTheme: Theme.of(context).buttonTheme.copyWith(
            colorScheme: isDarkTheme
                ? const ColorScheme.dark()
                : const ColorScheme.light()));
  }
}
