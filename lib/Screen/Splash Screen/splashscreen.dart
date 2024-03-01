import 'dart:async';


import 'package:demo/Admin/screen/adminside.dart';
import 'package:demo/Screen/Navigationpages/main_page.dart';
import 'package:demo/pageview.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Splashscreen extends StatefulWidget {
  const Splashscreen({super.key});

  @override
  State<Splashscreen> createState() => _SplashscreenState();
}

class _SplashscreenState extends State<Splashscreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 3), () {
      if (user == null) {
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const Pageviewpage(),
            ));
      } else {
        if (user?.uid == "1lLwEX4zMffDmg8ZBPUBfnHOumf2") {
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const Adminside(),
              ));
        } else {
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) =>  const Mainpage(),
              ));
        }
      }
    });
  }

  User? user = FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      color: const Color(0xff0078aa),
      child: Center(child: SizedBox( height: 55, width: 255, child: Image.asset("assets/img/Touristagif.gif",fit: BoxFit.cover,))),
    ));
  }
}
