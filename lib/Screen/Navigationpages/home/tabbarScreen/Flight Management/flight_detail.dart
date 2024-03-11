import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demo/Screen/Navigationpages/home/tabbarScreen/Flight%20Management/flight_search.dart';
import 'package:demo/Screen/Navigationpages/home/tabbarScreen/Flight%20Management/seat_booking.dart';
import 'package:demo/models/Flight%20models/addFlight.dart';
import 'package:demo/provider/dark_theme_provider.dart';
import 'package:demo/widget/button.dart';
import 'package:demo/widget/textwidget.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class FlightDetail extends StatefulWidget {
  AddFlight addFlight;

  String id;
  String travellingto;
  String classtype;
  String timeduration;
  String sdate;
  String edate;
  String startingfrom;
  String startingsortfrom;
  String travellingsortto;
  FlightDetail(
      {super.key,
      required this.id,
      required this.addFlight,
      required this.startingsortfrom,
      required this.travellingsortto,
      required this.edate,
      required this.sdate,
      required this.travellingto,
      required this.startingfrom,
      required this.classtype,
      required this.timeduration});

  @override
  State<FlightDetail> createState() => _FlightDetailState();
}

class _FlightDetailState extends State<FlightDetail> {
  String path = " ";
  void initState() {
    path = widget.addFlight.flightname!;
    print(path);
    super.initState();
    getFirebaseData();
  }

  void getFirebaseData() async {
    var data = await FirebaseFirestore.instance
        .collection("flight")
        .doc("$indexFlightDate$indexNumber")
        .get();
    if (data.exists) {
      flighSeatBook = data['favourite'];
      print("data------$flighSeatBook");
      print("data------$indexFlightDate");
    }
    print("data-----${data.exists}");
    print("data------$flighSeatBook");
    print("data------$indexFlightDate");
  }

  Map<String, dynamic> ficonlist = {
    "Indigo": "assets/img/indigo.png",
    "Air India": "assets/img/airindia.jpg",
    "Vistara": "assets/img/vistara.png",
    "Go First": "assets/img/gofirst.png",
    "Star Air": "assets/img/starair.png",
    "Air India Express": "assets/img/AirIndiaExpress.png",
    "SpiceJet": "assets/img/spisjeck.png",
    "TruJet": "assets/img/trujet.png"
  };

  @override
  Widget build(BuildContext context) {
    var mq = MediaQuery.of(context);
    final themeState = Provider.of<DarkThemeProvider>(context);
    return Scaffold(
        backgroundColor: themeState.getDarkTheme
            ? const Color(0xff121212)
            : const Color.fromARGB(255, 236, 235, 235),
        appBar: AppBar(
          title: const Text("Flight Details"),
          // centerTitle: true,
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
            Expanded(
              // width: mq.size.width,
              // height: mq.size.height / 1.280,
              // color: Colors.amber,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      color: themeState.getDarkTheme
                          ? const Color(0xff212121)
                          : const Color(0xffffffff),

                      // elevation: 2.5,
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Flight to ${widget.travellingto}",
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold),
                              ),
                              Row(
                                children: [
                                  const Text("Direct - "),
                                  Text("${widget.timeduration} - "),
                                  Text(widget.classtype)
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 10),
                                child: Row(
                                  // crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      height: mq.size.height / 5,
                                      width: mq.size.width / 10,
                                      // color: Colors.amber,
                                      child: Column(
                                        children: [
                                          const CircleAvatar(
                                            radius: 10,
                                            backgroundColor: Colors.white30,
                                            child: CircleAvatar(
                                              radius: 7,
                                              backgroundColor: Colors.blue,
                                            ),
                                          ),
                                          LayoutBuilder(
                                            builder: (context, constraints) {
                                              return Flex(
                                                // ignore: sort_child_properties_last
                                                children: List.generate(
                                                    (constraints.constrainWidth() /
                                                            10)
                                                        .floor(),
                                                    (index) => const SizedBox(
                                                          height: 37,
                                                          width: 3,
                                                          child: DecoratedBox(
                                                            decoration:
                                                                BoxDecoration(
                                                                    color: Colors
                                                                        .grey),
                                                          ),
                                                        )),
                                                direction: Axis.vertical,
                                              );
                                            },
                                          ),
                                          const CircleAvatar(
                                            radius: 10,
                                            backgroundColor: Colors.white30,
                                            child: CircleAvatar(
                                              radius: 7,
                                              backgroundColor: Colors.red,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      width: mq.size.width * 0.01,
                                    ),
                                    SizedBox(
                                      height: mq.size.height / 5,
                                      width: mq.size.width / 1.5,
                                      // color: Colors.amber,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          SizedBox(
                                            height: mq.size.height * 0.043,
                                            // width: mq.size.width,
                                            // color: Colors.green,
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Row(
                                                  children: [
                                                    Text("${widget.sdate} - "),
                                                    Text(
                                                        "${widget.addFlight.takeoffTime}"),
                                                  ],
                                                ),
                                                Row(
                                                  children: [
                                                    Text(
                                                      "${widget.startingsortfrom} - ",
                                                      style: const TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                    Text(
                                                      widget.startingfrom,
                                                      style: const TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                          SizedBox(
                                            height: mq.size.height * 0.07,
                                            width: mq.size.width / 1.6,
                                            child: Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                SizedBox(
                                                  height: 30,
                                                  width: 30,
                                                  child: Image.asset(
                                                      ficonlist[path]),
                                                ),
                                                SizedBox(
                                                  width: mq.size.width * 0.03,
                                                ),
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Text(
                                                      widget.addFlight
                                                          .flightname!,
                                                      style: TextStyle(
                                                          color: themeState
                                                                  .getDarkTheme
                                                              ? Colors.white
                                                                  .withOpacity(
                                                                      0.7)
                                                              : Colors.black
                                                                  .withOpacity(
                                                                      0.7)),
                                                    ),
                                                    Text(
                                                      "Flight ${widget.addFlight.flightNumber!}",
                                                      style: TextStyle(
                                                          color: themeState
                                                                  .getDarkTheme
                                                              ? Colors.white
                                                                  .withOpacity(
                                                                      0.7)
                                                              : Colors.black
                                                                  .withOpacity(
                                                                      0.7)),
                                                    ),
                                                    Text(
                                                      "Flight time ${widget.timeduration}",
                                                      style: TextStyle(
                                                          color: themeState
                                                                  .getDarkTheme
                                                              ? Colors.white
                                                                  .withOpacity(
                                                                      0.7)
                                                              : Colors.black
                                                                  .withOpacity(
                                                                      0.7)),
                                                    )
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                          SizedBox(
                                            height: mq.size.height * 0.043,
                                            // width: mq.size.width,
                                            // color: Colors.red,
                                            child: Column(
                                              //   crossAxisAlignment:
                                              //       CrossAxisAlignment.end,
                                              children: [
                                                Row(
                                                  children: [
                                                    Text("${widget.edate} - "),
                                                    Text(
                                                        "${widget.addFlight.landingTime}"),
                                                  ],
                                                ),
                                                Row(
                                                  children: [
                                                    Text(
                                                      "${widget.travellingsortto} - ",
                                                      style: const TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                    Text(
                                                      widget.travellingto,
                                                      style: const TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ]),
                      ),
                    ),
                    SizedBox(
                      height: mq.size.height * 0.0135,
                    ),
                    Container(
                      color: themeState.getDarkTheme
                          ? const Color(0xff212121)
                          : const Color(0xffffffff),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Titletext(
                              title: "Included baggage",
                              size: 16,
                            ),
                            SizedBox(
                              height: mq.size.height * 0.005,
                            ),
                            Text(
                              "Total baggage allowance for each flight",
                              style: TextStyle(
                                  color: themeState.getDarkTheme
                                      ? Colors.white.withOpacity(0.7)
                                      : Colors.black.withOpacity(0.7)),
                            ),
                            SizedBox(
                              height: mq.size.height * 0.022,
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Icon(
                                  Ionicons.bag_add_outline,
                                  size: 25,
                                ),
                                SizedBox(
                                  width: mq.size.width * 0.05,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      "1 personal item ",
                                      // style: TextStyle(
                                      //     fontWeight: FontWeight.w500)
                                    ),
                                    SizedBox(
                                      height: mq.size.height * 0.005,
                                    ),
                                    const Text(
                                      "Fits under the seat in front of you",
                                    ),
                                    SizedBox(
                                      height: mq.size.height * 0.005,
                                    ),
                                    const Text("Included",
                                        style: TextStyle(
                                            color: Colors.green,
                                            fontWeight: FontWeight.w500)),
                                  ],
                                )
                              ],
                            ),
                            SizedBox(
                              height: mq.size.height * 0.022,
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Icon(
                                  Ionicons.briefcase_outline,
                                  size: 25,
                                ),
                                SizedBox(
                                  width: mq.size.width * 0.05,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      "1 cabin bag",
                                    ),
                                    SizedBox(
                                      height: mq.size.height * 0.005,
                                    ),
                                    const Text(
                                      "Up to 8 kg each 25 x 35 x 55 cm",
                                    ),
                                    SizedBox(
                                      height: mq.size.height * 0.005,
                                    ),
                                    const Text("Included",
                                        style: TextStyle(
                                            color: Colors.green,
                                            fontWeight: FontWeight.w500)),
                                  ],
                                )
                              ],
                            ),
                            SizedBox(
                              height: mq.size.height * 0.02,
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Icon(
                                  Ionicons.bag_check_outline,
                                  size: 25,
                                ),
                                SizedBox(
                                  width: mq.size.width * 0.05,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      "1 checked bag",
                                    ),
                                    SizedBox(
                                      height: mq.size.height * 0.0045,
                                    ),
                                    const Text(
                                      "Max weight 30 kg",
                                    ),
                                    SizedBox(
                                      height: mq.size.height * 0.0045,
                                    ),
                                    const Text("Included",
                                        style: TextStyle(
                                            color: Colors.green,
                                            fontWeight: FontWeight.w500)),
                                  ],
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: mq.size.height * 0.0135,
                    ),
                    Container(
                      color: themeState.getDarkTheme
                          ? const Color(0xff212121)
                          : const Color(0xffffffff),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Titletext(
                              title: "Need extra baggage?",
                              size: 16,
                            ),
                            SizedBox(
                              height: mq.size.height * 0.02,
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Icon(
                                  Ionicons.bag_remove_outline,
                                  size: 25,
                                ),
                                SizedBox(
                                  width: mq.size.width * 0.05,
                                ),
                                const Expanded(
                                  child: Text(
                                      "No more baggage can be added right now - check with the airline after you book"),
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: mq.size.height * 0.0135,
                    ),
                    Container(
                      //elevation: 2.5,
                      color: themeState.getDarkTheme
                          ? const Color(0xff212121)
                          : const Color(0xffffffff),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Titletext(
                              title: "CO2e emissions estimate",
                              size: 16,
                            ),
                            SizedBox(
                              height: mq.size.height * 0.018,
                            ),
                            const Text(
                                "Typical CO2e emissions compared with all flights we offer for this route")
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: mq.size.height * 0.0135,
                    ),
                  ],
                ),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                  color: themeState.getDarkTheme
                      ? const Color(0xff212121)
                      : const Color(0xffffffff),
                  boxShadow: [
                    BoxShadow(
                        offset: const Offset(5, 5),
                        color: themeState.getDarkTheme
                            ? Colors.white12
                            : Colors.black12)
                  ]),
              height: mq.size.height * 0.1,
              child: Column(
                children: [
                  Container(
                      width: mq.size.width,
                      height: 3,
                      color: themeState.getDarkTheme
                          ? Colors.white12
                          : Colors.black12),
                  SizedBox(
                    height: mq.size.height * 0.019,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: Row(children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Titletext(title: "₹ ${widget.addFlight.price}"),
                          SizedBox(
                            height: mq.size.height * 0.01,
                          ),
                          Text("Per person",
                              style: TextStyle(
                                  fontSize: 13,
                                  color: themeState.getDarkTheme
                                      ? Colors.white54
                                      : Colors.black54,
                                  fontWeight: FontWeight.w400))
                        ],
                      ),
                      const Spacer(),
                      SizedBox(
                          height: mq.size.height * 0.065,
                          width: mq.size.width * 0.44,
                          child: commenButton(
                              title: "SELECT",
                              callback: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => ChooseSeat(
                                    esortname: widget.travellingsortto,
                                    ssortname: widget.startingsortfrom,
                                      clsstype1: widget.classtype,
                                      id: widget.id,
                                      addFlight: AddFlight(
                                        startingFrom:
                                            widget.addFlight.startingFrom,
                                        travelingTo:
                                            widget.addFlight.travelingTo,
                                        flightNumber:
                                            widget.addFlight.flightNumber,
                                        startDate: widget.addFlight.startDate,
                                        endDate: widget.addFlight.endDate,
                                        takeoffTime:
                                            widget.addFlight.takeoffTime,
                                        landingTime:
                                            widget.addFlight.landingTime,
                                        price: widget.addFlight.price,
                                        flightname: widget.addFlight.flightname,
                                      )),
                                ));
                              }))
                    ]),
                  ),
                ],
              ),
            )
          ],
        ));
  }
}
