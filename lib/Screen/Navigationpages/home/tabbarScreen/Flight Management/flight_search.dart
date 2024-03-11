// ignore_for_file: must_be_immutable

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demo/Screen/Navigationpages/home/tabbarScreen/Flight%20Management/flight_detail.dart';
import 'package:demo/models/Flight%20models/addFlight.dart';
import 'package:demo/provider/dark_theme_provider.dart';
import 'package:demo/widget/button.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class FlightSearch extends StatefulWidget {
  String? startingfrom;
  String? travellingto;
  String? takeoffdate;
  String? classname;
  String? traveller;
  FlightSearch(
      {super.key,
      required this.classname,
      required this.startingfrom,
      required this.traveller,
      required this.takeoffdate,
      required this.travellingto});

  @override
  State<FlightSearch> createState() => _FlightSearchState();
}

class _FlightSearchState extends State<FlightSearch> {
  String wordBeforeAirport1 = "";
  String wordBeforeAirport2 = "";
  String wordBeforeAirport3 = "";
  String wordBeforeAirport4 = "";
  @override
  void initState() {
    wordBeforeAirport1 = getWordBeforeAirport(widget.startingfrom!);
    wordBeforeAirport2 = getWordBeforeAirport(widget.travellingto!);
    wordBeforeAirport3 = getWordafterAirport(widget.startingfrom!);
    wordBeforeAirport4 = getWordafterAirport(widget.travellingto!);

    super.initState();
  }

  Widget build(BuildContext context) {
    final themeState = Provider.of<DarkThemeProvider>(context);
    var mq = MediaQuery.of(context);
    return Scaffold(
        backgroundColor: themeState.getDarkTheme
            ? const Color(0xff121212)
            : const Color.fromARGB(255, 236, 235, 235),

        // backgroundColor: const Color.fromRGBO(249, 251, 250, 1),
        appBar: AppBar(
          title: const Text("Search Result"),
          //centerTitle: true,
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
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(top: 14),
            child: StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection("FlightDetail")
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(
                        color: Color(0xff0078aa),
                      ),
                    );
                  }
                  if (!snapshot.hasData ||
                      snapshot.data == null ||
                      snapshot.data!.docs.isEmpty) {
                    return const Center(
                      child: Text(
                        "NO DATA FOUND!",
                        style: TextStyle(
                            fontWeight: FontWeight.w500, fontSize: 22),
                      ),
                    );
                  }
                  final data = snapshot.data!.docs.where((documentSnapshot) {
                    var startingfrom = widget.startingfrom!.toLowerCase();
                    var travellingto = widget.travellingto!.toLowerCase();
                    var date = widget.takeoffdate!.toLowerCase();
                    var fromstart = documentSnapshot['startingFrom']
                        .toString()
                        .toLowerCase();
                    var endto = documentSnapshot['travelingTo']
                        .toString()
                        .toLowerCase();
                    var startdate =
                        documentSnapshot['startDate'].toString().toLowerCase();
                    return fromstart.contains(startingfrom) &&
                        endto.contains(travellingto) &&
                        startdate.contains(date);
                  }).toList();

                  if (data.isEmpty) {
                    return const Center(
                      child: Text(
                        "HOTEL NOT FOUND!",
                        style: TextStyle(
                            fontWeight: FontWeight.w500, fontSize: 22),
                      ),
                    );
                  }

                  return ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: data.length,
                      itemBuilder: (context, index) {
                        String sdate = getdate(data[index]["startDate"]);
                        String sdate1 = getdate1(data[index]["startDate"]);
                        String edate1 = getdate1(data[index]["endDate"]);
                        String edate = getdate(data[index]["endDate"]);
                        String timeduration = gettime(
                            data[index]["takeoffTime"],
                            data[index]["landingTime"]);
                        String timeduration2 = gettime2(
                            data[index]["takeoffTime"],
                            data[index]["landingTime"]);
                        return Padding(
                          padding: const EdgeInsets.all(7),
                          child: Card(
                            color: themeState.getDarkTheme
                                ? const Color(0xff212121)
                                : const Color(0xffffffff),
                            elevation: 5,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                            child: Container(
                              decoration: BoxDecoration(
                                  color: themeState.getDarkTheme
                                      ? const Color(0xff212121)
                                      : const Color(0xffffffff),
                                  borderRadius: BorderRadius.circular(20)),
                              width: mq.size.width,
                              height: mq.size.height * 0.33,
                              child: Padding(
                                padding: const EdgeInsetsDirectional.symmetric(
                                    vertical: 14, horizontal: 14),
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                          decoration: BoxDecoration(
                                              //color: Colors.amber,
                                              border: Border.all(
                                                  color: themeState.getDarkTheme
                                                      ? Colors.white24
                                                      : Colors.black26),
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 8, horizontal: 8),
                                            child: Text(
                                              data[index]["flightname"],
                                              style: const TextStyle(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold,
                                                  color: Color(0xff0078aa)),
                                            ),
                                          ),
                                        ),
                                        Text(
                                          timeduration,
                                          style: TextStyle(
                                              fontSize: 15,
                                              color: themeState.getDarkTheme
                                                  ? Colors.white
                                                  : Colors.black),
                                        )
                                      ],
                                    ),
                                    SizedBox(
                                      height: mq.size.height * 0.015,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              data[index]["takeoffTime"],
                                              style: TextStyle(
                                                  fontSize: 17,
                                                  fontWeight: FontWeight.bold,
                                                  color: themeState.getDarkTheme
                                                      ? Colors.white
                                                      : Colors.black),
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                Text(
                                                  wordBeforeAirport1,
                                                  style: TextStyle(
                                                      fontSize: 11,
                                                      color: themeState
                                                              .getDarkTheme
                                                          ? Colors.white
                                                          : Colors.black),
                                                ),
                                                Text(
                                                  " - ${sdate}",
                                                  style: TextStyle(
                                                      fontSize: 11,
                                                      color: Colors.grey),
                                                ),
                                              ],
                                            )
                                          ],
                                        ),
                                        Expanded(
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Stack(
                                              children: [
                                                SizedBox(
                                                  height: 24,
                                                  child: LayoutBuilder(
                                                    builder:
                                                        (context, constraints) {
                                                      return Flex(
                                                          // ignore: sort_child_properties_last
                                                          children:
                                                              List.generate(
                                                                  (constraints.constrainWidth() /
                                                                          10)
                                                                      .floor(),
                                                                  (index) =>
                                                                      const SizedBox(
                                                                        height:
                                                                            1,
                                                                        width:
                                                                            5,
                                                                        child:
                                                                            DecoratedBox(
                                                                          decoration:
                                                                              BoxDecoration(color: Colors.grey),
                                                                        ),
                                                                      )),
                                                          direction:
                                                              Axis.horizontal,
                                                          mainAxisSize:
                                                              MainAxisSize.max,
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween);
                                                    },
                                                  ),
                                                ),
                                                Center(
                                                    child: Transform.rotate(
                                                  angle: 1.5,
                                                  child: Icon(
                                                    Icons.local_airport,
                                                    color:
                                                        Colors.indigo.shade300,
                                                    size: 24,
                                                  ),
                                                ))
                                              ],
                                            ),
                                          ),
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          children: [
                                            Text(
                                              data[index]["landingTime"],
                                              style: TextStyle(
                                                  fontSize: 17,
                                                  fontWeight: FontWeight.bold,
                                                  color: themeState.getDarkTheme
                                                      ? Colors.white
                                                      : Colors.black),
                                            ),
                                            Row(
                                              children: [
                                                Text(
                                                  wordBeforeAirport2,
                                                  style: TextStyle(
                                                      fontSize: 11,
                                                      color: themeState
                                                              .getDarkTheme
                                                          ? Colors.white
                                                          : Colors.black),
                                                ),
                                                Text(
                                                  " - $edate",
                                                  style: TextStyle(
                                                      fontSize: 11,
                                                      color: Colors.grey),
                                                ),
                                              ],
                                            )
                                          ],
                                        ),
                                      ],
                                    ),
                                    const Divider(
                                      thickness: 1,
                                    ),
                                    SizedBox(
                                      height: mq.size.height * 0.01,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        SizedBox(
                                          child: Row(
                                            children: [
                                              Icon(Icons.chair_outlined,
                                                  color: themeState.getDarkTheme
                                                      ? Colors.white
                                                      : Colors.black),
                                              const SizedBox(
                                                width: 5,
                                              ),
                                              Text(
                                                widget.classname!,
                                                style: TextStyle(
                                                    color:
                                                        themeState.getDarkTheme
                                                            ? Colors.white
                                                            : Colors.black),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Text(
                                          "₹ ${data[index]["price"]}",
                                          style: TextStyle(
                                              fontSize: 19,
                                              fontWeight: FontWeight.bold,
                                              color: themeState.getDarkTheme
                                                  ? Colors.white
                                                  : Colors.black),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: mq.size.height * 0.025,
                                    ),
                                    SizedBox(
                                      height: mq.size.height * 0.055,
                                      width: mq.size.width,
                                      child: commenButton(
                                        title: "Check",
                                        callback: () {
                                          indexFlightDate += "$index";
                                          Navigator.of(context)
                                              .push(MaterialPageRoute(
                                            builder: (context) => FlightDetail(
                                                startingsortfrom:
                                                    wordBeforeAirport3,
                                                travellingsortto:
                                                    wordBeforeAirport4,
                                                startingfrom:
                                                    wordBeforeAirport1,
                                                sdate: sdate1,
                                                edate: edate1,
                                                timeduration: timeduration2,
                                                classtype: widget.classname!,
                                                travellingto:
                                                    wordBeforeAirport2,
                                                addFlight: AddFlight(
                                                    startingFrom: data[index]
                                                        ["startingFrom"],
                                                    travelingTo: data[index]
                                                        ["travelingTo"],
                                                    flightNumber: data[index]
                                                        ["flightNumber"],
                                                    startDate: data[index]
                                                        ["startDate"],
                                                    endDate: data[index]
                                                        ["endDate"],
                                                    takeoffTime: data[index]
                                                        ["takeoffTime"],
                                                    landingTime: data[index]
                                                        ["landingTime"],
                                                    price: data[index]["price"],
                                                    flightname: data[index]
                                                        ["flightname"])),
                                          ));
                                        },
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      });
                }),
          ),
        ));
  }

  String getWordBeforeAirport(String airportString) {
    List<String> parts = airportString.split(' ');
    int index = parts.indexOf('-');
    if (index > 0) {
      return parts[index - 1];
    } else {
      return "";
    }
  }

  String getWordafterAirport(String airportString) {
    List<String> parts = airportString.split(' ');

    return parts.last;
  }

  String getdate(String date) {
    DateTime datetime = DateFormat('dd-MM-yyyy').parse(date);
    String formattedDate = DateFormat('dd MMM').format(datetime);
    return formattedDate;
  }

  String getdate1(String date) {
    DateTime datetime = DateFormat('dd-MM-yyyy').parse(date);
    String formattedDate = DateFormat('EEE dd MMM').format(datetime);
    return formattedDate;
  }

  String gettime(String stime, String etime) {
    DateFormat format = DateFormat('hh:mm a');
    DateTime time1 = format.parse(etime);
    DateTime time2 = format.parse(stime);

    Duration difference = time1.difference(time2);

    return "${difference.inHours.toString().padLeft(2, '0')} hr ${difference.inMinutes.remainder(60).toString().padLeft(2, '0')} min";
  }

  String gettime2(String stime, String etime) {
    DateFormat format = DateFormat('hh:mm a');
    DateTime time1 = format.parse(etime);
    DateTime time2 = format.parse(stime);

    Duration difference = time1.difference(time2);

    return "${difference.inHours.toString()}h : ${difference.inMinutes.remainder(60).toString()}m";
  }
}

int indexFlight = 0;
String indexFlightDate = "";
List flighSeatBook = [];
List flighSeat = [];
