// ignore_for_file: must_be_immutable

import 'dart:convert';

import 'package:demo/widget/button.dart';

import 'package:flutter/material.dart';

class Bottomseetfasility extends StatefulWidget {
  final Map<String, bool> faciliti1;
  final Function(Map<String, bool>) updateFacility;

  const Bottomseetfasility(
      {super.key, required this.faciliti1, required this.updateFacility});

  @override
  State<Bottomseetfasility> createState() => _BottomseetfasilityState();
}

class _BottomseetfasilityState extends State<Bottomseetfasility> {
  List ficilities = [
    "Free Wi-Fi",
    "beds",
    "Garden",
    "bedrooms",
    "Kitchen",
    "Parking",
    "Private bathroom",
    "Pets allowed",
    "Swimming pool",
    "Bar",
    "Safety",
    "Room service",
    "Family rooms",
    "Airport transfer",
  ];

  @override
  Widget build(BuildContext context) {
    var mq = MediaQuery.of(context);
    return SizedBox(
      height: mq.size.height / 1.13,
      child: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: ficilities.length,
              itemBuilder: (context, index) {
                return CheckboxListTile(
                    title: Text(ficilities[index]),
                    checkColor: const Color(0xff0078aa),
                    value: widget.faciliti1[index.toString()] ?? false,
                    onChanged: (val) {
                      setState(() {
                        widget.faciliti1[index.toString()] = val ?? false;
                      });
                    });
              },
            ),
          ),
          Container(
            decoration: const BoxDecoration(
                color: Color(0xffffffff),
                boxShadow: [
                  BoxShadow(offset: Offset(5, 5), color: Colors.black12)
                ]),
            height: mq.size.height * 0.1,
            child: Column(children: [
              Container(width: mq.size.width, height: 3, color: Colors.black12),
              SizedBox(
                height: mq.size.height * 0.016,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Spacer(),
                    SizedBox(
                      height: mq.size.height * 0.067,
                      width: mq.size.width * 0.44,
                      child: commenButton(
                        title: "Select",
                        callback: () async {
                          widget.updateFacility(widget.faciliti1);
                          Navigator.pop(context);
                          setState(() {});
                        },
                      ),
                    ),
                  ],
                ),
              )
            ]),
          )
        ],
      ),
    );
  }
}
