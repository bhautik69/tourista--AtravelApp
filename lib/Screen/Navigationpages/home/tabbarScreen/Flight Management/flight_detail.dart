import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demo/Screen/Navigationpages/home/tabbarScreen/Flight%20Management/flight_search.dart';
import 'package:demo/Screen/Navigationpages/home/tabbarScreen/Flight%20Management/seat_booking.dart';
import 'package:demo/provider/dark_theme_provider.dart';
import 'package:demo/widget/button.dart';
import 'package:demo/widget/textwidget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FlightDetail extends StatefulWidget {
  const FlightDetail({super.key});

  @override
  State<FlightDetail> createState() => _FlightDetailState();
}



class _FlightDetailState extends State<FlightDetail> {
   @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  
void getFirebaseData()async{
  var data= await FirebaseFirestore.instance.collection("flight"). doc("$indexFlightDate").get();
  if(data.exists){
    flighSeatBook=data['favourite']  ;
    print("data------$flighSeatBook");
    print("data------$indexFlightDate");
  }
  print("data-----${data.exists}");
  print("data------$flighSeatBook");
  print("data------$indexFlightDate");

}
  
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
                              const Text(
                                "Flight to Sharjah",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              const Row(
                                children: [
                                  Text("Direct -"),
                                  Text("3h 25m -"),
                                  Text("Ecomony")
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
                                    Container(
                                      height: mq.size.height / 5,
                                      width: mq.size.width / 1.5,
                                      // color: Colors.amber,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Container(
                                            height: mq.size.height * 0.063,
                                            // width: mq.size.width,
                                            // color: Colors.green,
                                            child: const Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Row(
                                                  children: [
                                                    Text("Sat 17 Feb - "),
                                                    Text("3:40 pm"),
                                                  ],
                                                ),
                                                Row(
                                                  children: [
                                                    Text(
                                                      "BOM - ",
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                    Text(
                                                      "Mumbai",
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                          // Container(
                                          //   height: mq.size.height / 9.2,
                                          //   width: mq.size.width / 1.5,
                                          //   // color: Colors.blue,
                                          // ),
                                          Container(
                                            height: mq.size.height * 0.063,
                                            // width: mq.size.width,
                                            // color: Colors.red,
                                            child: const Column(
                                              //   crossAxisAlignment:
                                              //       CrossAxisAlignment.end,
                                              children: [
                                                Row(
                                                  children: [
                                                    Text("Sat 17 Feb - "),
                                                    Text("3:40 pm"),
                                                  ],
                                                ),
                                                Row(
                                                  children: [
                                                    Text(
                                                      "BOM - ",
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                    Text(
                                                      "Mumbai",
                                                      style: TextStyle(
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
                            const Text(
                              "Included baggage",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            const Text(
                                "Total baggage allowance for each flight"),
                            SizedBox(
                              height: mq.size.height * 0.02,
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Icon(
                                  Icons.card_travel_outlined,
                                  size: 30,
                                ),
                                SizedBox(
                                  width: mq.size.width * 0.02,
                                ),
                                const Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("1 personam iten",
                                        style: TextStyle(
                                            fontWeight: FontWeight.w500)),
                                    // SizedBox(
                                    //   height: mq.size.height * 0.01,
                                    // ),
                                    Text("Fits under the seat in front of you",
                                        style: TextStyle(
                                            fontWeight: FontWeight.w500)),
                                    // SizedBox(
                                    //   height: mq.size.height / 250,
                                    // ),
                                    Text("Included",
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
                                  Icons.luggage_outlined,
                                  size: 30,
                                ),
                                SizedBox(
                                  width: mq.size.width * 0.025,
                                ),
                                const Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("1 personam item",
                                        style: TextStyle(
                                            fontWeight: FontWeight.w500)),
                                    Text("Fits under the seat in front of you",
                                        style: TextStyle(
                                            fontWeight: FontWeight.w500)),
                                    Text("Included",
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
                                  Icons.luggage_outlined,
                                  size: 30,
                                ),
                                SizedBox(
                                  width: mq.size.width * 0.025,
                                ),
                                const Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("1 personam iten",
                                        style: TextStyle(
                                            fontWeight: FontWeight.w500)),
                                    Text("Fits under the seat in front of you",
                                        style: TextStyle(
                                            fontWeight: FontWeight.w500)),
                                    Text("Included",
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
                            const Text("Need extra baggage?",
                                style: TextStyle(fontWeight: FontWeight.bold)),
                            SizedBox(
                              height: mq.size.height * 0.02,
                            ),
                            Row(
                              children: [
                                const Icon(
                                  Icons.leave_bags_at_home_outlined,
                                  size: 30,
                                ),
                                SizedBox(
                                  width: mq.size.width * 0.02,
                                ),
                                const Expanded(
                                  child: Text(
                                      "No more extra  ------------------------------------------------------------------------------------"),
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
                            const Text("CO2 emissions estimate",
                                style: TextStyle(fontWeight: FontWeight.bold)),
                            SizedBox(
                              height: mq.size.height * 0.02,
                            ),
                            const Text(
                                "No more extra  ------------------------------------------------------------------------------------------")
                          ],
                        ),
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
                          Titletext(title: "₹ 15,135"),
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
                              title: "SELECT",
                              callback: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => ChooseSeat(),
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
