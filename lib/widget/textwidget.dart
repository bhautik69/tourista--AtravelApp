import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/dark_theme_provider.dart';

class Titletext extends StatelessWidget {
  final String title;
  final double? size;
  const Titletext({super.key, required this.title, this.size = 20});

  @override
  Widget build(BuildContext context) {
    final themeState = Provider.of<DarkThemeProvider>(context);
    return Text(
      title,
      style: TextStyle(
          color: themeState.getDarkTheme ? Colors.white : Colors.black,
          fontWeight: FontWeight.w500,
          fontSize: size),
    );
  }
}
