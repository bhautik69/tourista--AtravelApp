import 'package:demo/Admin/screen/Admin%20Trip%20Management/addpackage.dart';
import 'package:demo/Admin/screen/Admin%20Trip%20Management/updatepackage.dart';
import 'package:demo/Admin/screen/Admin%20Trip%20Management/viewbooking.dart';
import 'package:demo/widget/textwidget.dart';

import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';


class TripsManagement extends StatefulWidget {
  const TripsManagement({super.key});
  static const String id = "addpackage";

  @override
  State<TripsManagement> createState() => _TripsManagementState();
}

class _TripsManagementState extends State<TripsManagement> {
  @override
  Widget build(BuildContext context) {
   
    return Scaffold(
        backgroundColor: const Color.fromARGB(255, 236, 235, 235),
        appBar: AppBar(
          title: const Text(
            "Trips Management",
          ),
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(IconlyLight.arrow_left_2)),
        ),
        body: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 9),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 20, top: 20),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const AddPackage(),
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
                                    Expanded(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Column(
                                            children: [
                                              const Titletext(
                                                title: "Add New Trip Packages",
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
                              builder: (context) => const UpdatePackage(),
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
                                    Expanded(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Column(
                                            children: [
                                              const Titletext(
                                                title:
                                                    "Update/Delete Trip Packages",
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
                              builder: (context) => const ViewBooking(),
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
                                    Expanded(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Column(
                                            children: [
                                              const Titletext(
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
