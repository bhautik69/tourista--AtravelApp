import 'package:demo/Admin/screen/Admin%20Flight%20Management/addNewflight.dart';
import 'package:demo/Admin/screen/Admin%20Flight%20Management/updateflight.dart';
import 'package:demo/Admin/screen/Admin%20Flight%20Management/viewFlightBooking.dart';
import 'package:demo/widget/textwidget.dart';
import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';

class FlightMainPage extends StatefulWidget {
  const FlightMainPage({super.key});

  @override
  State<FlightMainPage> createState() => _FlightMainPageState();
}

class _FlightMainPageState extends State<FlightMainPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromARGB(255, 236, 235, 235),
        appBar: AppBar(
          title: const Text(
            "Flight Management",
          ),
          centerTitle: true,
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(IconlyLight.arrow_left_2)),
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 9),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 20, top: 20),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const AddNewFlight(),
                            ));
                      },
                      child: Card(
                        elevation: 5,
                        color: const Color(0xffffffff),
                        child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 19, vertical: 23),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Image.asset(
                                      "assets/img/import.png",
                                      //
                                      //        color: Color(0xff0078aa),
                                      scale: 12,
                                    ),
                                    const Expanded(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Column(
                                            children: [
                                              Titletext(
                                                title: "Add New Flight",
                                                size: 18.5,
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ],
                            )),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 20),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const UpdateFlight(),
                            ));
                      },
                      child: Card(
                        elevation: 5,
                        color: const Color(0xffffffff),
                        child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 19, vertical: 23),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Image.asset(
                                      "assets/img/update.png",
                                      scale: 12,
                                      //          color: Color(0xff0078aa),
                                    ),
                                    const Expanded(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Column(
                                            children: [
                                              Titletext(
                                                title: "Update/Delete Flight",
                                                size: 18.5,
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ],
                            )),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 20),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const ViewFlightBooking(),
                            ));
                      },
                      child: Card(
                        elevation: 5,
                        color: const Color(0xffffffff),
                        child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 19, vertical: 23),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Image.asset(
                                      "assets/img/file.png",
                                      // color: Color(0xff0078aa),
                                      scale: 12,
                                    ),
                                    const Expanded(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Column(
                                            children: [
                                              Titletext(
                                                title: "View Booking",
                                                size: 18.5,
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ],
                            )),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ));
  }
}
