import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Errortoast {
  void toastmsg(String message) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: const Color(0xff515151),
        textColor: Colors.white,
        fontSize: 15.0);
  }
}
