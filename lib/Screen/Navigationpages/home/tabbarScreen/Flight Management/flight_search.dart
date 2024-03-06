import 'package:demo/Screen/Navigationpages/home/tabbarScreen/Flight%20Management/flight_detail.dart';
import 'package:demo/provider/dark_theme_provider.dart';
import 'package:demo/widget/button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FlightSearch extends StatefulWidget {
  const FlightSearch({super.key});

  @override
  State<FlightSearch> createState() => _FlightSearchState();
}

class _FlightSearchState extends State<FlightSearch> {
  @override
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
            child: ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: 3,
                itemBuilder: (context, index) {
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
                                    width: 70,
                                    height: 43,
                                    decoration: BoxDecoration(
                                        //color: Colors.amber,
                                        border: Border.all(
                                            color: themeState.getDarkTheme
                                                ? Colors.white12
                                                : Colors.black12),
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: const Center(
                                        child: Text(
                                      "!ndigo",
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                          color: Color(0xff0078aa)),
                                    )),
                                  ),
                                  Text(
                                    "01 hr 40min",
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
                                    children: [
                                      Text(
                                        "10:50 am",
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
                                            "Surat",
                                            style: TextStyle(
                                                fontSize: 11,
                                                color: themeState.getDarkTheme
                                                    ? Colors.white
                                                    : Colors.black),
                                          ),
                                          const Text(
                                            " - 17 Feb",
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
                                              builder: (context, constraints) {
                                                return Flex(
                                                    // ignore: sort_child_properties_last
                                                    children: List.generate(
                                                        (constraints.constrainWidth() /
                                                                10)
                                                            .floor(),
                                                        (index) =>
                                                            const SizedBox(
                                                              height: 1,
                                                              width: 5,
                                                              child:
                                                                  DecoratedBox(
                                                                decoration:
                                                                    BoxDecoration(
                                                                        color: Colors
                                                                            .grey),
                                                              ),
                                                            )),
                                                    direction: Axis.horizontal,
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
                                              color: Colors.indigo.shade300,
                                              size: 24,
                                            ),
                                          ))
                                        ],
                                      ),
                                    ),
                                  ),
                                  Column(
                                    children: [
                                      Text(
                                        "10:50 am",
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
                                            "Surat",
                                            style: TextStyle(
                                                fontSize: 11,
                                                color: themeState.getDarkTheme
                                                    ? Colors.white
                                                    : Colors.black),
                                          ),
                                          const Text(
                                            " - 17 Feb",
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
                                          "Economy",
                                          style: TextStyle(
                                              color: themeState.getDarkTheme
                                                  ? Colors.white
                                                  : Colors.black),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Text(
                                    "₹ 10,0000",
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
                                    int indexNumber = index;
                                    indexFlightDate += "$index";
                                    Navigator.of(context)
                                        .push(MaterialPageRoute(
                                      builder: (context) =>
                                          const FlightDetail(),
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
                }),
          ),
        ));
  }
}

int indexNumber = 0;
int indexFlight = 0;
String indexFlightDate = "";
List flighSeatBook = [];
List flighSeat = [];
