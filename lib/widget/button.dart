// ignore_for_file: avoid_unnecessary_containers

import 'package:flutter/material.dart';

Widget commenButton(
    {required String title,
    required VoidCallback callback,
    double? size,
    bool loading = false}) {
  return SizedBox(
    width: size,
    child: ElevatedButton(
      style: ElevatedButton.styleFrom(
          elevation: 2,
          textStyle: const TextStyle(fontSize: 18),
          shadowColor: const Color(0xff0078aa),
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10))),
          backgroundColor: const Color(0xff0078aa)),
      child: loading
          ? Container(
              child: const Center(
                child: CircularProgressIndicator(color: Colors.white),
              ),
            )
          : Text(
              title,
              style: const TextStyle(
                  color: Colors.white, fontWeight: FontWeight.bold),
            ),
      onPressed: () {
        callback();
      },
    ),
  );
}
