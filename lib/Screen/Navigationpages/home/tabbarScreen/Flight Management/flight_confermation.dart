import 'package:demo/Screen/Navigationpages/home/tabbarScreen/Flight%20Management/Flighttab.dart';
import 'package:demo/models/Flight%20models/addFlight.dart';
import 'package:demo/provider/dark_theme_provider.dart';
import 'package:demo/widget/button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:path_drawing/path_drawing.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../../models/Flight models/bookingFlight.dart';

class FlightConfirm extends StatefulWidget {
  AddFlight addFlight;
  String id;
  String email;
  String phone;
  String totalPrice;
  List<Map<String, dynamic>> adultList;
  List seetlist1;
  List<Map<String, dynamic>> childList;
  FlightConfirm(
      {super.key,
      required this.addFlight,
      required this.id,
      required this.totalPrice,
      required this.seetlist1,
      required this.email,
      required this.phone,
      required this.adultList,
      required this.childList});

  @override
  State<FlightConfirm> createState() => _FlightConfirmState();
}

class _FlightConfirmState extends State<FlightConfirm> {
  bool isloading = false;
  int adult = 1;
  int child = 0;
  @override
  void initState() {
    getdata();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final themeState = Provider.of<DarkThemeProvider>(context);
    var mq = MediaQuery.of(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Flight Details"),
        centerTitle: true,
        leading: InkWell(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: const Icon(
            Icons.arrow_back_ios_new_rounded,
            color: Colors.white,
            size: 22,
          ),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: mq.size.height * 0.015,
                vertical: mq.size.height * 0.023),
            child: Card(
              color: themeState.getDarkTheme
                  ? const Color(0xff212121)
                  : const Color(0xffffffff),
              elevation: 10,
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(30))),
              child: Container(
                decoration: BoxDecoration(
                    color: themeState.getDarkTheme
                        ? const Color(0xff212121)
                        : const Color(0xffffffff),
                    borderRadius: const BorderRadius.all(Radius.circular(30))),
                width: mq.size.width,
                height: mq.size.height / 1.45,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: Container(
                          width: mq.size.width / 2.5,
                          height: mq.size.height * 0.07,
                          decoration: BoxDecoration(
                              border: Border.all(
                                  color:
                                      const Color.fromARGB(39, 185, 185, 167)),
                              borderRadius: BorderRadius.circular(10)),
                          child: const Center(
                              child: Text(
                            "!ndigo",
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Color.fromARGB(241, 36, 22, 233)),
                          )),
                        ),
                      ),
                      const Divider(
                        thickness: 2,
                      ),
                      Stack(
                        children: [
                          CustomPaint(
                            painter: CurvePainter(),
                            child: SizedBox(
                              height: mq.size.height * 0.10,
                              width: mq.size.width * 0.75,
                            ),
                          ),
                          Positioned(
                            top: 17.5,
                            left: mq.size.width * 0.32,
                            child: const RotatedBox(
                              quarterTurns: 1,
                              child: Icon(
                                Icons.flight,
                                size: 35,
                                color: Color.fromARGB(255, 121, 134, 203),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: mq.size.width * 0.035,
                            vertical: mq.size.height * 0.002),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CircleAvatar(
                              radius: 10,
                              backgroundColor: themeState.getDarkTheme
                                  ? Colors.white
                                  : Colors.purple.shade50,
                              child: const CircleAvatar(
                                radius: 5,
                                backgroundColor: Colors.blue,
                              ),
                            ),
                            CircleAvatar(
                              radius: 10,
                              backgroundColor: themeState.getDarkTheme
                                  ? Colors.white
                                  : Colors.purple.shade50,
                              child: const CircleAvatar(
                                radius: 5,
                                backgroundColor: Colors.red,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "CDG",
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: themeState.getDarkTheme
                                    ? Colors.white
                                    : Colors.black),
                          ),
                          Text(
                            "CCU",
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: themeState.getDarkTheme
                                    ? Colors.white
                                    : Colors.black),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "10:50 am",
                            style: TextStyle(
                                fontSize: 16,
                                color: themeState.getDarkTheme
                                    ? Colors.white
                                    : Colors.black),
                          ),
                          Text(
                            "10:50 am",
                            style: TextStyle(
                                fontSize: 16,
                                color: themeState.getDarkTheme
                                    ? Colors.white
                                    : Colors.black),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: mq.size.height * 0.02,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            // color: Colors.amber,
                            width: mq.size.width * 0.4,
                            height: mq.size.height * 0.1,
                            child: const Text(
                              "Indira Gandhi International AirPort",
                              overflow: TextOverflow.ellipsis,
                              maxLines: 3,
                              style:
                                  TextStyle(fontSize: 15, color: Colors.grey),
                            ),
                          ),
                          SizedBox(
                            // color: Colors.amber,
                            width: mq.size.width * 0.4,
                            height: mq.size.height * 0.1,
                            child: const Text(
                              "Subhash Chandra Bose International AirPort",
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: 15,
                                color: Colors.grey,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: mq.size.height * 0.015),
                      const Divider(
                        thickness: 2,
                      ),
                      SizedBox(height: mq.size.height * 0.02),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Container(
                            width: mq.size.width / 2.5,
                            height: mq.size.height / 15,
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey),
                                borderRadius: BorderRadius.circular(10)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                const Icon(Icons.calendar_month_outlined),
                                Text(
                                  "20/12/2024",
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                      color: themeState.getDarkTheme
                                          ? Colors.white
                                          : Colors.black),
                                )
                              ],
                            ),
                          ),
                          Container(
                            width: mq.size.width / 2.5,
                            height: mq.size.height / 15,
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey),
                                borderRadius: BorderRadius.circular(10)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(Icons.watch_later_outlined),
                                const SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  "9:30",
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                      color: themeState.getDarkTheme
                                          ? Colors.white
                                          : Colors.black),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: mq.size.height * 0.02),
                      const Divider(
                        thickness: 2,
                      ),
                      SizedBox(height: mq.size.height * 0.01),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Price ",
                              style: TextStyle(
                                  fontSize: 25,
                                  color: themeState.getDarkTheme
                                      ? Colors.white
                                      : Colors.black)),
                          Text("10,000",
                              style: TextStyle(
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold,
                                  color: themeState.getDarkTheme
                                      ? Colors.white
                                      : Colors.black)),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: mq.size.width * 0.05),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const Fligthtab(),
                        ),
                        (route) => false);
                  },
                  child: Container(
                    height: mq.size.height * 0.07,
                    width: mq.size.width * 0.35,
                    decoration: BoxDecoration(
                        border: Border.all(color: const Color(0xff0078aa)),
                        borderRadius: BorderRadius.circular(10)),
                    child: const Center(
                      child: Text(
                        "Cancel",
                        style: TextStyle(
                            color: Color(0xff0078aa),
                            fontWeight: FontWeight.bold,
                            fontSize: 18),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: mq.size.height * 0.07,
                  width: mq.size.width * 0.35,
                  child: commenButton(
                    title: "Confirm",
                    loading: isloading,
                    callback: () {
                      save();
                      // Navigator.of(context).push(MaterialPageRoute(
                      //   builder: (context) => const Fli(),
                      // ));
                    },
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  save() async {
    setState(() {
      isloading = true;
    });

    await BookingFlight.addBookingFlight(
      BookingFlight(
          id: widget.id,
          startingFrom: widget.addFlight.startingFrom,
          travelingTo: widget.addFlight.travelingTo,
          flightNumber: widget.addFlight.flightNumber,
          startDate: widget.addFlight.startDate,
          endDate: widget.addFlight.endDate,
          takeoffTime: widget.addFlight.takeoffTime,
          landingTime: widget.addFlight.landingTime,
          price: widget.addFlight.price,
          flightname: widget.addFlight.flightname,
          seatList: widget.seetlist1,
          adult: adult.toString(),
          children: child.toString(),
          email: widget.email,
          phoneno: widget.phone,
          adultList: widget.adultList,
          childrenList: widget.childList,
          totalPrice: widget.totalPrice),
      widget.id,
    ).whenComplete(() {
      setState(() {
        isloading = false;

        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("BOOKING SUCCESSFULLY")));
      });
    });
  }

  getdata() async {
    var store = await SharedPreferences.getInstance();

    var v4 = store.getInt("adult");
    var v5 = store.getInt("child");

    setState(() {
      adult = v4!;
      child = v5!;
    });
  }
}

class CurvePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint();
    double h = size.height;
    double w = size.width;

    paint.color = Colors.grey;
    paint.style = PaintingStyle.stroke;
    paint.strokeWidth = 2;

    var startPoint = Offset(0, h);
    var controlPoint1 = Offset(w / 4, h / 4);
    var controlPoint2 = Offset(3 * w / 4, h / 4);
    var endPoint = Offset(w, h);

    var path = Path();
    path.moveTo(startPoint.dx, startPoint.dy);
    path.cubicTo(controlPoint1.dx, controlPoint1.dy, controlPoint2.dx,
        controlPoint2.dy, endPoint.dx, endPoint.dy);
    canvas.drawPath(
        dashPath(path, dashArray: CircularIntervalList([8, 5])), paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
