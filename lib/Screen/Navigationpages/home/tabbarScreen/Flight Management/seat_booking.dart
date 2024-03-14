// ignore_for_file: sized_box_for_whitespace, avoid_unnecessary_containers, prefer_const_constructors, avoid_function_literals_in_foreach_calls, prefer_typing_uninitialized_variables, prefer_const_constructors_in_immutables, unused_local_variable

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demo/Screen/Navigationpages/home/tabbarScreen/Flight%20Management/Flighttab.dart';
import 'package:demo/Screen/Navigationpages/home/tabbarScreen/Flight%20Management/flight_search.dart';
import 'package:demo/Screen/Navigationpages/home/tabbarScreen/Flight%20Management/user_information.dart';
import 'package:demo/models/Flight%20models/addFlight.dart';
import 'package:demo/provider/dark_theme_provider.dart';
import 'package:demo/widget/button.dart';
import 'package:demo/widget/textwidget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class ChooseSeat extends StatefulWidget {
  String id;
  AddFlight addFlight;
  String clsstype1;
  String ssortname;
  String esortname;
  List? ages = [];
  ChooseSeat({
    Key? key,
    required this.addFlight,
    required this.id,
    this.ages,
    required this.clsstype1,
    required this.ssortname,
    required this.esortname,
  });

  @override
  State<ChooseSeat> createState() => _ChooseSeatState();
}

class _ChooseSeatState extends State<ChooseSeat> {
  // var isBooked
  var countSeatLeft = 3 * 13;
  var countSeatRight = 3 * 13;
  var listSeatLeft = [];
  var listSeatRight = [];
  List addseat = [];

  @override
  void initState() {
    getseetdata();
    //l for left, c for center , r for right
    //first param "listSeatLeft","listSeatCenter","listSeatRight" that similar like object temp that u want to save the data
    // second param is for like how many seat on every side
    // third param is for naming value every seat //look line 38
    initSeatValueToList(listSeatLeft, countSeatLeft, "l");
    initSeatValueToList(listSeatRight, countSeatRight, "r");
    //setVisiblitySeat();
    super.initState();
  }

  initSeatValueToList(List data, count, side) {
    var objectData;
    //init variable to save your object data
    // int counts=classType=="First Class"?10:count;
    for (int i = 0; i < count; i++) {
      objectData = {
        "id": side + "${i + 1}",
        "isBooked": false,
        "isAvailable": true,
        "isSelected": false,
        "isVisible": true,
      };
      //this format object for every seat has
      setState(() {
        data.add(objectData);
        //add object to list
      });
    }
    //print(data);
  }

  setSelectedToBooked() {
    listSeatLeft.forEach((seat) {
      if (seat["isSelected"]) {
        setState(() {
          seat["isBooked"] = false;
        });
      }
    });
    listSeatRight.forEach((seat) {
      if (seat["isSelected"]) {
        setState(() {
          seat["isBooked"] = false;
        });
      }
    });
    //this function to loop every side of seat, from selected to booked, u also can this function to send to u'r serves side
  }

  List firebaseseet = [];
  getseetdata() async {
    await FirebaseFirestore.instance
        .collectionGroup('FlightUserBooking')
        .get()
        .then((QuerySnapshot? snapshot) {
      for (var element in snapshot!.docs) {
        if (element.exists) {
          if (element.id == widget.id) {
            for (int i = 0; i < element["seatList"].length; i++) {
              firebaseseet.add(element["seatList"][i]);
            }
          }
        }
      }
    });
    setState(() {});
    print(firebaseseet);
  }

  @override
  Widget build(BuildContext context) {
    var mq = MediaQuery.of(context);
    final themeState = Provider.of<DarkThemeProvider>(context);
    Color color = themeState.getDarkTheme ? Colors.white : Colors.black;
    return Scaffold(
        appBar: AppBar(
          title: const Text("Choose Seat"),
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
        body: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  //crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ///seat availility show
                    Container(
                      width: mq.size.width,
                      height: mq.size.height / 5,
                      //color: Colors.green,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Expanded(
                              child: Container(
                                child: Row(
                                  children: [
                                    Container(
                                      width: 25,
                                      height: 25,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(3),
                                        color: Color(0xff0078aa),
                                      ),
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(left: 10),
                                      child: Text("Available seat"),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Expanded(
                              child: Container(
                                child: Row(
                                  children: [
                                    Container(
                                      width: 25,
                                      height: 25,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(3),
                                          border:
                                              Border.all(color: Colors.green),
                                          color: Color.fromARGB(
                                              255, 198, 239, 199)),
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(left: 10),
                                      child: Text("Selected seat"),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Expanded(
                              child: Container(
                                child: Row(
                                  children: [
                                    Container(
                                      width: 25,
                                      height: 25,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(3),
                                        border: Border.all(
                                            color: themeState.getDarkTheme
                                                ? Colors.white24
                                                : Colors.black26),
                                        color:
                                            Color.fromARGB(255, 211, 209, 209),
                                      ),
                                      child: const Center(
                                          child: Icon(Icons.close)),
                                    ),
                                    Container(
                                      margin: const EdgeInsets.only(left: 10),
                                      child: Text(
                                        "Unavailable Seat",
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    Divider(
                      thickness: 2,
                    ),

                    ///seat ui show
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 23),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: mq.size.width / 90,
                            height: mq.size.height * 0.8,
                            color: themeState.getDarkTheme
                                ? Colors.grey[800]
                                : Colors.grey[350],
                          ),
                          SizedBox(
                            width: mq.size.width / 50,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 5),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      width: mq.size.width / 2.8,
                                      height: mq.size.height * 0.06,
                                      //color: Colors.deepOrange,
                                      child: const Padding(
                                        padding: EdgeInsets.all(8.0),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              "A",
                                              style: TextStyle(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.w400),
                                            ),
                                            Text(
                                              "B",
                                              style: TextStyle(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.w400),
                                            ),
                                            Text(
                                              "C",
                                              style: TextStyle(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.w400),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: mq.size.width / 11),
                                    Container(
                                      width: mq.size.width / 2.8,
                                      height: mq.size.height * 0.06,
                                      //color: Colors.deepOrange,
                                      child: const Padding(
                                        padding: EdgeInsets.all(8.0),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              "D",
                                              style: TextStyle(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.w400),
                                            ),
                                            Text(
                                              "E",
                                              style: TextStyle(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.w400),
                                            ),
                                            Text(
                                              "F",
                                              style: TextStyle(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.w400),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Container(
                                      //color: Colors.amber,
                                      //margin: EdgeInsets.symmetric(horizontal: 10),
                                      // height: 100,
                                      width: mq.size.width / 2.8,
                                      child: widgetSeat(listSeatLeft, false,
                                          classType, "left"),
                                    ),
                                    Container(
                                      width: mq.size.width / 11,
                                      // height: mq.size.height * 1.66,
                                      // color: Colors.deepOrange,
                                      // child: buildNumberColumn(),
                                    ),
                                    Container(
                                      //color: Colors.amber,
                                      //margin: EdgeInsets.symmetric(horizontal: 10),
                                      // height: 100,
                                      width: mq.size.width / 2.8,
                                      child: widgetSeat(listSeatRight, false,
                                          classType, "right"),
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            width: mq.size.width / 50,
                          ),
                          Container(
                            width: mq.size.width / 90,
                            height: mq.size.height * 0.8,
                            color: themeState.getDarkTheme
                                ? Colors.grey[800]
                                : Colors.grey[350],
                          ),
                        ],
                      ),
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
                          height: mq.size.height * 0.06,
                          width: mq.size.width * 0.44,
                          child: commenButton(
                              title: "next",
                              callback: () {
                                print(addseat);

                                if (addseat.length !=
                                    int.parse(
                                        traveller.text.split(" ").first)) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                          content: Text(
                                              "select ${int.parse(traveller.text.split(" ").first) - addseat.length} more seet according to your selection")));
                                } else {
                                  flighSeat.clear();

                                  setState(() {});

                                  Navigator.push(context, MaterialPageRoute(
                                    builder: (context) {
                                      return Userinfo(
                                          cleaefeld1: () {
                                            addseat.clear();
                                          },
                                          esortname: widget.esortname,
                                          ssortname: widget.ssortname,
                                          classtype: widget.clsstype1,
                                          seelist1: addseat,
                                          addFlight: AddFlight(
                                              startingFrom:
                                                  widget.addFlight.startingFrom,
                                              travelingTo:
                                                  widget.addFlight.travelingTo,
                                              flightNumber:
                                                  widget.addFlight.flightNumber,
                                              startDate:
                                                  widget.addFlight.startDate,
                                              endDate: widget.addFlight.endDate,
                                              takeoffTime:
                                                  widget.addFlight.takeoffTime,
                                              landingTime:
                                                  widget.addFlight.landingTime,
                                              price: widget.addFlight.price,
                                              flightname:
                                                  widget.addFlight.flightname),
                                          id: widget.id, ages: widget.ages!,);
                                    },
                                  ));
                                }
                              }))
                    ]),
                  ),
                ],
              ),
            )
          ],
        ));
  }

  Widget widgetSeat(
      List dataSeat, bool isCenter, String classType, String sideShow) {
    // listSeatLeft
    //listSeatRight
    List<String> classhint = <String>[
      "Economy",
      "Premium",
      "Business",
      "First Class"
    ];
    final themeState = Provider.of<DarkThemeProvider>(context);
    int? count = seatCount[classType];
    return Container(
      width: MediaQuery.of(context).size.width / 2.9,
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          // crossAxisCount: isCenter ? 4 : 3,
          crossAxisCount: 3,
          childAspectRatio: isCenter ? 1 : 1,
        ),
        itemCount: count,
        itemBuilder: (BuildContext context, int index) {
          int count = 0;
          if (classType == "Business") {
            if ("left" == sideShow) {
              print("count--$count");
              int value = (index) ~/ 3;
              count = (3 * value) + (index + 1);
              print("count-++++++-$count");
            } else {
              int value = ((index) ~/ 3) + 1;
              count = (3 * value) + (index + 1);
            }
          }
          if (classType == "Premium") {
            if ("left" == sideShow) {
              print("count--$count");
              int value = (index) ~/ 3;
              count = (3 * value) + (index + 19);
              print("count-++++++-$count");
            } else {
              int value = ((index) ~/ 3) + 1;
              count = (3 * value) + (index + 19);
            }
          }
          if (classType == "First Class") {
            if ("left" == sideShow) {
              print("count--$count");
              int value = (index) ~/ 3;
              count = (3 * value) + (index + 49);
              print("count-++++++-$count");
            } else {
              int value = ((index) ~/ 3) + 1;
              count = (3 * value) + (index + 49);
            }
          }
          if (classType == "Economy") {
            if ("left" == sideShow) {
              print("count--$count");
              int value = (index) ~/ 3;
              count = (3 * value) + (index + 109);
              print("count-++++++-$count");
            } else {
              int value = ((index) ~/ 3) + 1;
              count = (3 * value) + (index + 109);
            }
          }
          return Visibility(
            visible: dataSeat[index]["isVisible"],
            child: GestureDetector(
              onTap: () {
                if (flighSeatBook.contains(count)) {
                  return;
                }

                print("lenght---${flighSeat.length}");
                print(
                    "lenght--1111-${int.parse(traveller.text.split(" ").first)}");
                // if (flighSeat.length <= int.parse(traveller.text.split(" ").first)) {

                dataSeat[index]["isSelected"] = !dataSeat[index]["isSelected"];
                if (flighSeat.contains(count)) {
                  dataSeat[index]["isSelected"] =
                      !dataSeat[index]["isSelected"];
                  flighSeat.remove(count);
                } else {
                  if (flighSeat.length <
                      int.parse(traveller.text.split(" ").first)) {
                    dataSeat[index]["isSelected"] =
                        !dataSeat[index]["isSelected"];
                    flighSeat.add(count);
                  }
                }
                print("lenght---a$flighSeat");
                flighSeat.contains(count) ? addseat.add(count) : null;
                setState(() {});
                !flighSeat.contains(count) ? addseat.remove(count) : "";
              },
              //show the seat info
              child: Container(
                  margin: const EdgeInsets.all(2.5),
                  width: 25,
                  height: 25,
                  decoration: BoxDecoration(
                    // color: dataSeat[index]["isBooked"]
                    //     ? Color.fromARGB(255, 211, 209, 209)
                    //     : dataSeat[index]["isSelected"]
                    //         ? const Color.fromARGB(255, 198, 239, 199)
                    //         : Color(0xff0078aa),
                    // border: dataSeat[index]["isBooked"]
                    //     ? Border.all(
                    //         color: themeState.getDarkTheme
                    //             ? Colors.white24
                    //             : Colors.black26)
                    //     : dataSeat[index]["isSelected"]
                    //         ? Border.all(color: Colors.green)
                    //         : Border.all(
                    //             color: themeState.getDarkTheme
                    //                 ? Colors.black
                    //                 : Colors.white),

                    color: firebaseseet.contains(count)
                        ? Color.fromARGB(255, 211, 209, 209)
                        : flighSeat.contains(count)
                            ? const Color.fromARGB(255, 198, 239, 199)
                            : Color(0xff0078aa),
                    border: firebaseseet.contains(count)
                        ? Border.all(
                            color: themeState.getDarkTheme
                                ? Colors.white24
                                : Colors.black26)
                        : flighSeat.contains(count)
                            ? Border.all(color: Colors.green)
                            : Border.all(
                                color: themeState.getDarkTheme
                                    ? Colors.black
                                    : Colors.white),

                    borderRadius: BorderRadius.circular(3),
                  ),
                  alignment: Alignment.center,
                  child: dataSeat[index]["isBooked"]
                      ? const Center(
                          child: Icon(
                          Icons.close,
                          size: 35,
                        ))
                      : Text(
                          "$count",
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center,
                        )),
            ),
          );
        },
      ),
    );
  }
}

// Widget buildNumberColumn() {
//   List<Widget> numberWidgets = [];

//   for (int i = 1; i <= 31; i++) {
//     numberWidgets.add(Column(
//       children: [Text('$i'), SizedBox(height: 22.322)],
//     ));
//   }

//   return Center(
//     child: Padding(
//       padding: const EdgeInsets.all(8.0),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         // mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: numberWidgets,
//       ),
//     ),
//   );
// }
