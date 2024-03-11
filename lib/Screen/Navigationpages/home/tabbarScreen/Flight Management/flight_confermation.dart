import 'package:demo/Screen/Navigationpages/home/tabbarScreen/Flight%20Management/Flighttab.dart';
import 'package:demo/models/Flight%20models/addFlight.dart';
import 'package:demo/provider/dark_theme_provider.dart';
import 'package:demo/widget/button.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:path_drawing/path_drawing.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../../models/Flight models/bookingFlight.dart';

// ignore: must_be_immutable
class FlightConfirm extends StatefulWidget {
  String ssortname;
  String esortname;
  String classtype1;
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
      required this.ssortname,
      required this.esortname,
      required this.classtype1,
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
  String time = "";
  @override
  void initState() {
    time =
        gettime2(widget.addFlight.takeoffTime!, widget.addFlight.landingTime!);
    getdata();
    super.initState();
  }

  String gettime2(String stime, String etime) {
    DateFormat format = DateFormat('hh:mm a');
    DateTime time1 = format.parse(etime);
    DateTime time2 = format.parse(stime);

    Duration difference = time1.difference(time2);

    return "${difference.inHours.toString().padLeft(2, '0')}h : ${difference.inMinutes.remainder(60).toString().padLeft(2, '0')}m";
  }

  @override
  Widget build(BuildContext context) {
    final themeState = Provider.of<DarkThemeProvider>(context);
    var mq = MediaQuery.of(context);
    return Scaffold(
      backgroundColor: themeState.getDarkTheme
          ? const Color(0xff121212)
          : const Color.fromARGB(255, 236, 235, 235),
      appBar: AppBar(
        title: const Text("Booking overview"),
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
          SizedBox(height: mq.size.height * 0.015),
          Container(
            decoration: BoxDecoration(
                color: themeState.getDarkTheme
                    ? const Color(0xff212121)
                    : const Color(0xffffffff),
                borderRadius: const BorderRadius.all(Radius.circular(0))),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Container(
                      decoration: BoxDecoration(
                          //color: Colors.amber,
                          border: Border.all(
                              color: themeState.getDarkTheme
                                  ? Colors.white24
                                  : Colors.black26),
                          borderRadius: BorderRadius.circular(10)),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 25),
                        child: Text(
                          widget.addFlight.flightname!,
                          style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Color(0xff0078aa)),
                        ),
                      ),
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
                        widget.ssortname,
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: themeState.getDarkTheme
                                ? Colors.white
                                : Colors.black),
                      ),
                      Text(
                        widget.esortname,
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: themeState.getDarkTheme
                                ? Colors.white
                                : Colors.black),
                      ),
                    ],
                  ),
                  SizedBox(height: mq.size.height * 0.002),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        widget.addFlight.takeoffTime!,
                        style: TextStyle(
                            fontSize: 16,
                            color: themeState.getDarkTheme
                                ? Colors.white
                                : Colors.black),
                      ),
                      Text(
                        widget.addFlight.landingTime!,
                        style: TextStyle(
                            fontSize: 16,
                            color: themeState.getDarkTheme
                                ? Colors.white
                                : Colors.black),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: mq.size.height * 0.015,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        // color: Colors.amber,
                        width: mq.size.width * 0.36,

                        child: Text(
                          widget.addFlight.startingFrom!,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 3,
                          style: const TextStyle(fontSize: 15, color: Colors.grey),
                        ),
                      ),
                      const Spacer(),
                      SizedBox(
                        // color: Colors.amber,
                        width: mq.size.width * 0.36112,

                        child: Text(
                          widget.addFlight.travelingTo!,
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 15,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: mq.size.height * 0.025),
                  const Divider(
                    thickness: 1.5,
                  ),
                  SizedBox(height: mq.size.height * 0.02),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: mq.size.width / 2.5,
                        height: mq.size.height / 15,
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(10)),
                        child: Row(
                          children: [
                            const Padding(
                              padding:
                                  EdgeInsets.symmetric(horizontal: 10),
                              child: Icon(Icons.calendar_month_outlined),
                            ),
                            Text(
                              widget.addFlight.startDate!,
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
                          children: [
                            const Padding(
                              padding:
                                  EdgeInsets.symmetric(horizontal: 10),
                              child: Icon(Icons.watch_later_outlined),
                            ),
                            Text(
                              time,
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: mq.size.width / 2.5,
                        height: mq.size.height / 15,
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(10)),
                        child: Row(
                          children: [
                            const Padding(
                              padding:
                                  EdgeInsets.symmetric(horizontal: 10),
                              child: Icon(Icons.man_3_outlined),
                            ),
                            Text(
                              "${adult.toString().padLeft(2, '0')} Adult",
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
                          children: [
                            const Padding(
                              padding:
                                  EdgeInsets.symmetric(horizontal: 10),
                              child: Icon(Icons.man_4_outlined),
                            ),
                            Text(
                              "${child.toString().padLeft(2, '0')} ${child >= 1 ? "children" : "child"}",
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
                    thickness: 1.5,
                  ),
                  SizedBox(height: mq.size.height * 0.01),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Price: ",
                          style: TextStyle(
                              fontSize: 22,
                              color: themeState.getDarkTheme
                                  ? Colors.white
                                  : Colors.black)),
                      Text("₹ ${widget.totalPrice}",
                          style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.w500,
                              color: themeState.getDarkTheme
                                  ? Colors.white
                                  : Colors.black)),
                    ],
                  ),
                  SizedBox(height: mq.size.height * 0.02),
                ],
              ),
            ),
          ),
          SizedBox(height: mq.size.height * 0.015),
          Expanded(
            child: Container(
              color: themeState.getDarkTheme
                  ? const Color(0xff212121)
                  : const Color(0xffffffff),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: mq.size.width * 0.03
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                        height: mq.size.height * 0.067,
                        width: mq.size.width * 0.44,
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
                      height: mq.size.height * 0.067,
                      width: mq.size.width * 0.44,
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
              ),
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
          classtype: widget.classtype1,
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
