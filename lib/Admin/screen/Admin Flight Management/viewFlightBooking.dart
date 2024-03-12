import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demo/Admin/screen/Admin%20Flight%20Management/flightBookingDetail.dart';
import 'package:demo/widget/textwidget.dart';
import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:lottie/lottie.dart';

class ViewFlightBooking extends StatefulWidget {
  const ViewFlightBooking({super.key});

  @override
  State<ViewFlightBooking> createState() => _ViewFlightBookingState();
}

class _ViewFlightBookingState extends State<ViewFlightBooking> {
  var searchController = TextEditingController();
  List foundlist = [];
  List allBookingData = [];
  String wordBeforeAirport1 = "";
  String wordBeforeAirport2 = "";
  String? travelingTo;
  String? startingFrom;

  getData() async {
    await FirebaseFirestore.instance
        .collectionGroup("FlightUserBooking")
        .get()
        .then((QuerySnapshot? snapshot) {
      for (var element in snapshot!.docs) {
        if (element.exists) {
          Map<String, dynamic> data = {
            "id": element["id"],
            "classtype": element["classtype"],
            "startingFrom": element["startingFrom"],
            "travelingTo": element["travelingTo"],
            "flightNumber": element["flightNumber"],
            "startDate": element["startDate"],
            "endDate": element["endDate"],
            "seatList": element["seatList"],
            "takeoffTime": element["takeoffTime"],
            "landingTime": element["landingTime"],
            "price": element["price"],
            "flightname": element["flightname"],
            "email": element["email"],
            "phoneno": element["phoneno"],
            "adultList": element["adultList"],
            "childrenList": element["childrenList"],
            "totalPrice": element["totalPrice"],
            "adult": element["adult"],
            "children": element["children"],
          };
          setState(() {
            allBookingData.add(data);
          });
        }
      }
    });
  }

  void _runFilter(String enteredKeyword) {
    List results = [];
    if (enteredKeyword.isEmpty) {
      // if the search field is empty or only contains white-space, we'll display all users
      results = allBookingData;
    } else {
      results = allBookingData
          .where((element) =>
              element["startingFrom"]
                  .toLowerCase()
                  .contains(enteredKeyword.toLowerCase()) ||
              element["travelingTo"]
                  .toLowerCase()
                  .contains(enteredKeyword.toLowerCase()))
          .toList();
      // we use the toLowerCase() method to make it case-insensitive
    }
    // Refresh the UI
    setState(() {
      foundlist = results;
    });
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
  void initState() {
    getData();
    foundlist = allBookingData;
    setState(() {});
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var mq = MediaQuery.of(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("View Booking"),
        centerTitle: true,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(IconlyLight.arrow_left_2)),
      ),
      body: allBookingData.isEmpty
          ? const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(
                      color: Color(0xff0078aa), strokeWidth: 5),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Please wait!!",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
                  )
                ],
              ),
            )
          : Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(13.0),
                  child: TextField(
                    controller: searchController,
                    onChanged: (value) => _runFilter(value),
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 15),
                      hintText: "Search",
                      suffixIcon: const Icon(
                        Icons.search,
                        color: Colors.grey,
                      ),
                      // prefix: Icon(Icons.search),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                        borderSide: const BorderSide(),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                        borderSide: const BorderSide(),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: foundlist.isEmpty
                      ? SingleChildScrollView(
                          child: Column(
                            children: [
                              Lottie.asset("assets/img/no_data_found.json"),
                              const Text(
                                "NO FLIGHT FOUND!",
                                style: TextStyle(
                                    fontWeight: FontWeight.w500, fontSize: 22),
                              ),
                            ],
                          ),
                        )
                      : ListView.builder(
                          itemCount: foundlist.length,
                          itemBuilder: (context, index) {
                            startingFrom = foundlist[index]["startingFrom"];
                            travelingTo = foundlist[index]["travelingTo"];
                            wordBeforeAirport1 =
                                getWordBeforeAirport(startingFrom!);
                            wordBeforeAirport2 =
                                getWordBeforeAirport(travelingTo!);
                            return Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(13.0),
                                child: InkWell(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              FlightBookingDetail(
                                            id: foundlist[index]["id"],
                                            email: foundlist[index]["email"],
                                            phone: foundlist[index]["phoneno"],
                                            adultList: foundlist[index]
                                                ["adultList"],
                                            childList: foundlist[index]
                                                ["childrenList"],
                                            classType: foundlist[index]
                                                ["classtype"],
                                            seatList: foundlist[index]
                                                ["seatList"],
                                          ),
                                        ));
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 5, horizontal: 5),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Titletext(
                                          title:
                                              "$wordBeforeAirport1 To $wordBeforeAirport2",
                                          size: 15,
                                        ),
                                        SizedBox(
                                          height: mq.size.height * 0.014,
                                        ),
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            SizedBox(
                                              height: 90,
                                              width: 90,
                                              child: ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(5),
                                                  child: Image.asset(ficonlist[
                                                      foundlist[index]
                                                          ["flightname"]])),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 12, right: 5),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  SizedBox(
                                                    width: mq.size.width * 0.48,
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        const Text(
                                                          "Class Type : ",
                                                          style: TextStyle(
                                                            fontSize: 13.5,
                                                            fontWeight:
                                                                FontWeight.w400,
                                                            color: Colors.black,
                                                          ),
                                                        ),
                                                        Flexible(
                                                          child: Text(
                                                            foundlist[index]
                                                                ["classtype"],
                                                            style: TextStyle(
                                                                fontSize: 13.5,
                                                                color: Colors
                                                                    .black
                                                                    .withOpacity(
                                                                        0.65)),
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height:
                                                        mq.size.height * 0.007,
                                                  ),
                                                  SizedBox(
                                                    width: mq.size.width * 0.5,
                                                    child: Row(
                                                      children: [
                                                        const Text(
                                                          "Flight Number : ",
                                                          style: TextStyle(
                                                            fontSize: 13.5,
                                                            fontWeight:
                                                                FontWeight.w400,
                                                            color: Colors.black,
                                                          ),
                                                        ),
                                                        Text(
                                                          foundlist[index]
                                                              ["flightNumber"],
                                                          style: TextStyle(
                                                              fontSize: 13.5,
                                                              color: Colors
                                                                  .black
                                                                  .withOpacity(
                                                                      0.65)),
                                                          textAlign:
                                                              TextAlign.start,
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height:
                                                        mq.size.height * 0.007,
                                                  ),
                                                  SizedBox(
                                                    width: mq.size.width * 0.5,
                                                    child: Row(
                                                      children: [
                                                        const Text(
                                                          "Takeoff Date : ",
                                                          style: TextStyle(
                                                            fontSize: 13.5,
                                                            fontWeight:
                                                                FontWeight.w400,
                                                            color: Colors.black,
                                                          ),
                                                        ),
                                                        Text(
                                                          foundlist[index]
                                                              ["startDate"],
                                                          style: TextStyle(
                                                              fontSize: 13.5,
                                                              color: Colors
                                                                  .black
                                                                  .withOpacity(
                                                                      0.65)),
                                                          textAlign:
                                                              TextAlign.start,
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height:
                                                        mq.size.height * 0.007,
                                                  ),
                                                  Row(
                                                    children: [
                                                      const Text(
                                                        "Price  : ",
                                                        style: TextStyle(
                                                          fontSize: 13.5,
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          color: Colors.black,
                                                        ),
                                                      ),
                                                      Text(
                                                        foundlist[index]
                                                            ["price"],
                                                        style: TextStyle(
                                                            fontSize: 13.5,
                                                            color: Colors.black
                                                                .withOpacity(
                                                                    0.65)),
                                                      ),
                                                      SizedBox(
                                                        width: mq.size.height *
                                                            0.03,
                                                      ),
                                                      const Text(
                                                        "Travellers : ",
                                                        style: TextStyle(
                                                          fontSize: 13.5,
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          color: Colors.black,
                                                        ),
                                                      ),
                                                      Text(
                                                        "${foundlist[index]["adultList"].length + foundlist[index]["childrenList"].length}"
                                                            .toString(),
                                                        style: TextStyle(
                                                            fontSize: 13.5,
                                                            color: Colors.black
                                                                .withOpacity(
                                                                    0.65)),
                                                      )
                                                    ],
                                                  ),
                                                  SizedBox(
                                                    height:
                                                        mq.size.height * 0.007,
                                                  ),
                                                ],
                                              ),
                                            )
                                          ],
                                        ),
                                        const Divider(
                                          thickness: 1.5,
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                ),
              ],
            ),
    );
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
}
