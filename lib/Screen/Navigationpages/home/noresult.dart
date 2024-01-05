import 'package:demo/provider/dark_theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Nodata extends StatelessWidget {
  const Nodata({super.key});

  @override
  Widget build(BuildContext context) {
    final themeState = Provider.of<DarkThemeProvider>(context);

    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Icon(
            Icons.search_off_outlined,
            color: Color(0xff0078aa),
            size: 150,
          ),
          const SizedBox(
            height: 2,
          ),
          const Text(
            "Oops! We didn't get you ",
            style: TextStyle(fontWeight: FontWeight.w700, fontSize: 25),
          ),
          const SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: Text(
              "Sorry, but we can't find anything that matches yours search.Plese try again ",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w400,
                  color: themeState.getDarkTheme
                      ? Colors.white54
                      : Colors.black54),
            ),
          ),
        ],
      ),
    );
  }
}
