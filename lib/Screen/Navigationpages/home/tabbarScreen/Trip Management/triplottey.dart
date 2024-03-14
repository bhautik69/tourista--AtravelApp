import 'dart:async';

import 'package:demo/Screen/Navigationpages/home/tabbarScreen/Trip%20Management/Find_trip.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

// ignore: must_be_immutable
class Triploty extends StatefulWidget {
  String date;
  String sform;
  String tto;
  Triploty(
      {super.key, required this.date, required this.sform, required this.tto});

  @override
  State<Triploty> createState() => _TriplotyState();
}

class _TriplotyState extends State<Triploty> {
  @override
  void initState() {
    Timer(const Duration(milliseconds: 4020), () {
      Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => Find_trip(
                date: widget.date,
                sform: widget.sform,
                tto: widget.tto,
              )));
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        // mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(
            height: 220,
          ),
          Lottie.asset(
            "assets/img/triploty.json",
          ),
          const SizedBox(
            height: 150,
          ),
          const Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                width: 9,
              ),
              Text(
                "Loading...",
                style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 18,
                    color: Colors.black),
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          const LinearProgressIndicator(),
        ],
      ),
    );
  }
}
