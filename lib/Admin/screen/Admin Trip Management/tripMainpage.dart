import 'package:demo/Admin/screen/Admin%20Trip%20Management/addpackage.dart';
import 'package:demo/Admin/screen/Admin%20Trip%20Management/updatepackage.dart';
import 'package:demo/Admin/screen/Admin%20Trip%20Management/viewbooking.dart';

import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:sizer/sizer.dart';

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
      // 3 backgroundColor: const Color.fromARGB(255, 236, 235, 235),
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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                height: 55,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    child: cardwidget(title: "ADD PACKAGE"),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const AddPackage(),
                          ));
                    },
                  ),
                  InkWell(
                      child: cardwidget(title: "UPDATE PACKAGE"),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const UpdatePackage(),
                            ));
                      })
                ],
              ),
              //
              const SizedBox(
                height: 12,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const ViewBooking(),
                            ));
                      },
                      child: cardwidget(title: "VIEW BOOKINGS")),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget cardwidget({required String title}) {
    return Card(
      elevation: 1,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Container(
        height: 18.h,
        width: 20.h,
        decoration: BoxDecoration(
            color: const Color(0xff0078aa),
            borderRadius: BorderRadius.circular(10)),
        child: Center(
            child: Text(
          title,
          textAlign: TextAlign.center,
          style: const TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 23),
        )),
      ),
    );
  }
}
