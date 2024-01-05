import 'package:flutter/material.dart';

Widget skipbutton() {
  return Container(
    height: 26,
    width: 70,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(30),
      color: const Color(0xff515151).withOpacity(0.6),
    ),
    child: const Center(
        child: Text(
      "Skip>>",
      style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
    )),
  );
}

// ignore: non_constant_identifier_names
Widget Swipbutton() {
  return Card(
    shape: BeveledRectangleBorder(borderRadius: BorderRadius.circular(10)),
    elevation: 2,
    shadowColor: const Color(0xff0078aa),
    child: Container(
      height: 55,
      width: 120,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: const Color(0xff0078aa)),
      child: Center(
        child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          Icon(
            Icons.arrow_forward_ios,
            color: Colors.white.withOpacity(0.4),
            size: 8,
          ),
          const SizedBox(
            width: 3,
          ),
          Icon(
            Icons.arrow_forward_ios,
            color: Colors.white.withOpacity(0.6),
            size: 13,
          ),
          Icon(
            Icons.arrow_forward_ios,
            color: Colors.white.withOpacity(0.8),
            size: 17,
          ),
          Icon(
            Icons.arrow_forward_ios,
            color: Colors.white.withOpacity(1),
            size: 20,
          ),
        ]),
      ),
    ),
  );
}
