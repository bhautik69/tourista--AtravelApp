import 'dart:async';

import 'package:demo/Screen/Navigationpages/home/tabbarScreen/Hotel%20Management/findhotel.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

// ignore: must_be_immutable
class HotelLottie extends StatefulWidget {
  String destination;
  bool search;
  bool recentsearch;
  String check_In;
  String check_Out;
  int room;
  int adults;
  int child;
  HotelLottie(
      {super.key,
      required this.search,
      required this.recentsearch,
      required this.adults,
      required this.destination,
      required this.room,
      // ignore: non_constant_identifier_names
      required this.check_In,
      // ignore: non_constant_identifier_names
      required this.check_Out,
      required this.child});

  @override
  State<HotelLottie> createState() => _HotelLottieState();
}

class _HotelLottieState extends State<HotelLottie> {
  @override
  void initState() {
    Timer(const Duration(milliseconds: 5020), () {
      Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => show_hotel(
                destination: widget.destination,
                check_In: widget.check_In,
                check_Out: widget.check_Out,
                adults: widget.adults,
                child: widget.child,
                room: widget.room,
                search: widget.search,
                recentsearch: widget.recentsearch,
                hotelname: '',
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
            "assets/img/87TGZIzDOW.json",
          ),
          const SizedBox(
            height: 90,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(
                width: 9,
              ),
              const Text(
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
