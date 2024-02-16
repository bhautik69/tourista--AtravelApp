// ignore_for_file: sized_box_for_whitespace, avoid_unnecessary_containers, prefer_const_constructors, avoid_function_literals_in_foreach_calls, prefer_typing_uninitialized_variables, prefer_const_constructors_in_immutables, unused_local_variable

import 'package:demo/provider/dark_theme_provider.dart';
import 'package:demo/widget/button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class ChooseSeat extends StatefulWidget {
  ChooseSeat({Key? key}) : super(key: key);

  @override
  State<ChooseSeat> createState() => _ChooseSeatState();
}

class _ChooseSeatState extends State<ChooseSeat> {
  // var isBooked
  var countSeatLeft = 3 * 31;
  var countSeatRight = 3 * 31;
  var listSeatLeft = [];
  var listSeatRight = [];

  @override
  void initState() {
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
          seat["isBooked"] = true;
        });
      }
    });
    listSeatRight.forEach((seat) {
      if (seat["isSelected"]) {
        setState(() {
          seat["isBooked"] = true;
        });
      }
    });
    //this function to loop every side of seat, from selected to booked, u also can this function to send to u'r serves side
  }

  @override
  Widget build(BuildContext context) {
    var mq = MediaQuery.of(context);
    final themeState = Provider.of<DarkThemeProvider>(context);
    Color color = themeState.getDarkTheme ? Colors.white : Colors.black;
    return Scaffold(
        backgroundColor: themeState.getDarkTheme
            ? const Color(0xff212121)
            : const Color(0xffffffff),
        appBar: AppBar(
          title: const Text("Choose Seat"),
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
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  //crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
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
                                        color: Color.fromRGBO(0, 0, 128, 1),
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
                                        border: Border.all(color: Colors.black),
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
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 23),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: mq.size.width / 90,
                            height: mq.size.height * 1.717,
                            color: Color.fromARGB(255, 214, 214, 214),
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
                                      height: mq.size.height / 20,
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
                                      height: mq.size.height / 20,
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
                                      child: widgetSeat(listSeatLeft, false),
                                    ),
                                    Container(
                                      width: mq.size.width / 11,
                                      height: mq.size.height * 1.66,
                                      // color: Colors.deepOrange,
                                      child: buildNumberColumn(),
                                    ),
                                    Container(
                                      //color: Colors.amber,
                                      //margin: EdgeInsets.symmetric(horizontal: 10),
                                      // height: 100,
                                      width: mq.size.width / 2.8,
                                      child: widgetSeat(listSeatRight, false),
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
                            height: mq.size.height * 1.717,
                            color: const Color.fromARGB(255, 214, 214, 214),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              width: mq.size.width,
              height: mq.size.height * 0.1,
              decoration: BoxDecoration(
                  color: themeState.getDarkTheme
                      ? const Color(0xff121212)
                      : const Color(0xFFffffff),
                  border:
                      Border(top: BorderSide(width: 2, color: Colors.grey))),
              child: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: 16, vertical: mq.size.height * 0.015),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "₹ 15,135.87",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text("1 travellers")
                      ],
                    ),
                    SizedBox(
                      width: mq.size.width * 0.35,
                      height: mq.size.height * 0.06,
                      child: commenButton(
                        title: "Select",
                        callback: () {
                          setSelectedToBooked();
                        },
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ));
  }

  Widget widgetSeat(List dataSeat, bool isCenter) {
    return Container(
      width: MediaQuery.of(context).size.width / 2.9,
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: isCenter ? 4 : 3,
          childAspectRatio: isCenter ? 1 : 1,
        ),
        itemCount: dataSeat.length,
        itemBuilder: (BuildContext context, int index) {
          return Visibility(
            visible: dataSeat[index]["isVisible"],
            child: GestureDetector(
              onTap: () {
                setState(() {
                  dataSeat[index]["isSelected"] =
                      !dataSeat[index]["isSelected"];
                });
              },
              //show the seat info
              child: Container(
                  margin: const EdgeInsets.all(2.5),
                  width: 25,
                  height: 25,
                  decoration: BoxDecoration(
                    color: dataSeat[index]["isBooked"]
                        ? Color.fromARGB(255, 211, 209, 209)
                        : dataSeat[index]["isSelected"]
                            ? const Color.fromARGB(255, 198, 239, 199)
                            : const Color.fromRGBO(0, 0, 128, 1),
                    border: dataSeat[index]["isBooked"]
                        ? Border.all(color: Colors.black)
                        : dataSeat[index]["isSelected"]
                            ? Border.all(color: Colors.green)
                            : Border.all(),
                    borderRadius: BorderRadius.circular(3),
                  ),
                  child: dataSeat[index]["isBooked"]
                      ? const Center(
                          child: Icon(
                          Icons.close,
                          size: 35,
                        ))
                      : const Text("")),
            ),
          );
        },
      ),
    );
  }
}

Widget buildNumberColumn() {
  List<Widget> numberWidgets = [];

  for (int i = 1; i <= 31; i++) {
    numberWidgets.add(Column(
      children: [Text('$i'), SizedBox(height: 22.322)],
    ));
  }

  return Center(
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: numberWidgets,
      ),
    ),
  );
}
