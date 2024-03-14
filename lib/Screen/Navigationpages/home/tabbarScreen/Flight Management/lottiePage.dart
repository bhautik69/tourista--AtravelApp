import 'dart:async';

import 'package:demo/Screen/Navigationpages/home/tabbarScreen/Flight%20Management/flight_search.dart';
import 'package:demo/widget/textwidget.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

// ignore: must_be_immutable
class LottiePage extends StatefulWidget {
   bool search;
  bool recentsearch;
  String? startingfrom;
  String? travellingto;
  String? takeoffdate;
  String? classname;
  String? traveller;
  LottiePage(
      {super.key,
      required this.search,
      required this.recentsearch,
      required this.classname,
      required this.startingfrom,
      required this.traveller,
      required this.takeoffdate,
      required this.travellingto});

  @override
  State<LottiePage> createState() => _LottiePageState();
}

class _LottiePageState extends State<LottiePage> {
  @override
  void initState() {
    Timer(const Duration(milliseconds: 4020), () {
      Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => FlightSearch(search: widget.search,
          recentsearch: widget.recentsearch,
          
            classname: widget.classname,
            startingfrom: widget.startingfrom,
            takeoffdate: widget.takeoffdate,
            travellingto: widget.travellingto,
            traveller: widget.traveller),
      ));
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor:  const Color(0xffE9ECF7),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height / 3.7,
          ),
          Lottie.asset(
            "assets/img/Animation_1710233681033.json",
          ),
          Expanded(
            child: Container(
              width: MediaQuery.of(context).size.width,
              color: Colors.white,
              child: Row(
                children: [
                  Image.asset(
                    "assets/img/person1.png",
                    scale: 4,
                  ),
                  const Spacer(),
                  const Padding(
                    padding: EdgeInsets.only(right: 40),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 40,
                        ),
                        Titletext(
                          title: "Start your",
                          size: 25,
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Titletext(title: "Journey"),
                        SizedBox(
                          height: 5,
                        ),
                        Titletext(
                          title: "with",
                          size: 17,
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          "Tourista",
                          style: TextStyle(
                              color: Colors.blue,
                              fontWeight: FontWeight.bold,
                              fontSize: 30),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        SizedBox(
                          height: 3,
                          width: 110,
                          child: LinearProgressIndicator(),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
