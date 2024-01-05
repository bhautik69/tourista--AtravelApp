
import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';


Widget listTiles(
    {required String title,
    required BuildContext context,
    required IconData icon,
    required bool isdark,
    required VoidCallback callback}) {
  return ListTile(
      title: Text(
        title,
        style: TextStyle(color: isdark ? Colors.white : Colors.black),
      ),
      leading: Icon(
        icon,
        color: isdark ? Colors.white : Colors.black,
      ),
      trailing: Icon(
        IconlyLight.arrow_right_2,
        color: isdark ? Colors.white : Colors.black,
      ),
      onTap: () {
        callback();
      });
}
