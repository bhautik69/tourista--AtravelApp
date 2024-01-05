import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:demo/Screen/Navigationpages/profile/profile_page.dart';
import 'package:demo/Screen/Navigationpages/saved/saved_page.dart';
import 'package:demo/Screen/Navigationpages/home/search_page.dart';

import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../../provider/dark_theme_provider.dart';
import 'book/book.dart';

// ignore: must_be_immutable
class Mainpage extends StatefulWidget {
  const Mainpage({super.key});

  @override
  State<Mainpage> createState() => _MainpageState();
}

class _MainpageState extends State<Mainpage> {
  List pages = [const Search(), const Saved(), const Book(), const Profile()];

  int currentIndex = 0;

  void onTap(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final themeState = Provider.of<DarkThemeProvider>(context);
    return Scaffold(
        body: pages[currentIndex],
        bottomNavigationBar: CurvedNavigationBar(
          index: currentIndex,
          // animationCurve: Curves.fastEaseInToSlowEaseOut,
          height: 61,
          color: themeState.getDarkTheme
              ? const Color(0xff212121)
              : const Color(0xFF0078aa),
          backgroundColor:
              themeState.getDarkTheme ? const Color(0xff121212) : Colors.white,
          onTap: onTap,
          items: [
            Image.asset(
              "assets/img/home.png",
              color: Colors.white,
              height: 22,
            ),
            Image.asset(
              "assets/img/love-icon.png",
              color: Colors.white,
              height: 22,
            ),
            Image.asset(
              "assets/img/briefcase.png",
              color: Colors.white,
              height: 22,
            ),
            Image.asset(
              "assets/img/user.png",
              color: Colors.white,
              height: 22,
            ),
          ],
        ));
  }
}
