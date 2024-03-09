import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demo/Admin/screen/Admin%20Hotel%20Management/bookhotel/bookingdetail.dart';
import 'package:demo/widget/textwidget.dart';
import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:lottie/lottie.dart';

class ViewHotelBooking extends StatefulWidget {
  const ViewHotelBooking({super.key});

  @override
  State<ViewHotelBooking> createState() => _ViewHotelBookingState();
}

class _ViewHotelBookingState extends State<ViewHotelBooking> {
  var searchController = TextEditingController();
  List foundlist = [];
  List allBookingData = [];

  getData() async {
    await FirebaseFirestore.instance
        .collectionGroup("UserBooking")
        .get()
        .then((QuerySnapshot? snapshot) {
      for (var element in snapshot!.docs) {
        if (element.exists) {
          Map<String, dynamic> data = {
            "id": element["id"],
            "name": element["name"],
            "description": element["description"],
            "facilities": element["facilities"],
            "images": element["images"],
            "price": element["price"],
            "cityName": element["cityName"],
            "disttocenter": element["disttocenter"],
            "address": element["address"],
            "latitude": element["latitude"],
            "longitude": element["longitude"],
            "checkinfrom": element["checkinfrom"],
            "checkinUntil": element["checkinUntil"],
            "checkoutUntil": element["checkoutUntil"],
            "transeferFee": element["transeferFee"],
            "distFromAirport": element["distFromAirport"],
            "traveltimetoairport": element["traveltimetoairport"],
            "email": element["email"],
            "phoneno": element["phoneno"],
            "adultList": element["adultList"],
            "childrenList": element["childrenList"],
            "totalPrice": element["totalPrice"],
            "room": element["room"],
            "adult": element["adult"],
            "children": element["children"],
            "check_out": element["check_out"],
            "check_in": element["check_in"]
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
              element["name"]
                  .toLowerCase()
                  .contains(enteredKeyword.toLowerCase()) ||
              element["cityName"]
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
                                "NO HOTEL FOUND!",
                                style: TextStyle(
                                    fontWeight: FontWeight.w500, fontSize: 22),
                              ),
                            ],
                          ),
                        )
                      : ListView.builder(
                          itemCount: foundlist.length,
                          itemBuilder: (context, index) {
                            return Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(13.0),
                                child: InkWell(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => BookingDetail(
                                            id: foundlist[index]["id"],
                                            email: foundlist[index]["email"],
                                            phone: foundlist[index]["phoneno"],
                                            adultList: foundlist[index]
                                                ["adultList"],
                                            childList: foundlist[index]
                                                ["childrenList"],
                                          ),
                                        ));
                                  },
                                  child: Card(
                                      elevation: 1,
                                      color: Colors.white,
                                      margin: const EdgeInsets.symmetric(
                                          vertical: 2),
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 5, horizontal: 5),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Titletext(
                                              title: foundlist[index]["name"],
                                              size: 18,
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
                                                          BorderRadius.circular(
                                                              5),
                                                      child: FancyShimmerImage(
                                                        imageUrl:
                                                            foundlist[index]
                                                                    ["images"]
                                                                .first,
                                                        boxFit: BoxFit.cover,
                                                      )),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 12, right: 5),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      SizedBox(
                                                        width: mq.size.width *
                                                            0.48,
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .start,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            const Text(
                                                              "City    : ",
                                                              style: TextStyle(
                                                                fontSize: 13.5,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400,
                                                                color: Colors
                                                                    .black,
                                                              ),
                                                            ),
                                                            Flexible(
                                                              child: Text(
                                                                foundlist[index]
                                                                    [
                                                                    "cityName"],
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        13.5,
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
                                                        height: mq.size.height *
                                                            0.007,
                                                      ),
                                                      SizedBox(
                                                        width:
                                                            mq.size.width * 0.5,
                                                        child: Row(
                                                          children: [
                                                            const Text(
                                                              "Check In : ",
                                                              style: TextStyle(
                                                                fontSize: 13.5,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400,
                                                                color: Colors
                                                                    .black,
                                                              ),
                                                            ),
                                                            Text(
                                                              foundlist[index]
                                                                  ["check_in"],
                                                              style: TextStyle(
                                                                  fontSize:
                                                                      13.5,
                                                                  color: Colors
                                                                      .black
                                                                      .withOpacity(
                                                                          0.65)),
                                                              textAlign:
                                                                  TextAlign
                                                                      .start,
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        height: mq.size.height *
                                                            0.007,
                                                      ),
                                                      SizedBox(
                                                        width:
                                                            mq.size.width * 0.5,
                                                        child: Row(
                                                          children: [
                                                            const Text(
                                                              "Check Out : ",
                                                              style: TextStyle(
                                                                fontSize: 13.5,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400,
                                                                color: Colors
                                                                    .black,
                                                              ),
                                                            ),
                                                            Text(
                                                              foundlist[index]
                                                                  ["check_out"],
                                                              style: TextStyle(
                                                                  fontSize:
                                                                      13.5,
                                                                  color: Colors
                                                                      .black
                                                                      .withOpacity(
                                                                          0.65)),
                                                              textAlign:
                                                                  TextAlign
                                                                      .start,
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        height: mq.size.height *
                                                            0.007,
                                                      ),
                                                      Row(
                                                        children: [
                                                          const Text(
                                                            "Price  : ",
                                                            style: TextStyle(
                                                              fontSize: 13.5,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400,
                                                              color:
                                                                  Colors.black,
                                                            ),
                                                          ),
                                                          Text(
                                                            foundlist[index]
                                                                ["totalPrice"],
                                                            style: TextStyle(
                                                                fontSize: 13.5,
                                                                color: Colors
                                                                    .black
                                                                    .withOpacity(
                                                                        0.65)),
                                                          ),
                                                          SizedBox(
                                                            width:
                                                                mq.size.height *
                                                                    0.03,
                                                          ),
                                                          const Text(
                                                            "Travellers : ",
                                                            style: TextStyle(
                                                              fontSize: 13.5,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400,
                                                              color:
                                                                  Colors.black,
                                                            ),
                                                          ),
                                                          Text(
                                                            "${foundlist[index]["adultList"].length + foundlist[index]["childrenList"].length}"
                                                                .toString(),
                                                            style: TextStyle(
                                                                fontSize: 13.5,
                                                                color: Colors
                                                                    .black
                                                                    .withOpacity(
                                                                        0.65)),
                                                          )
                                                        ],
                                                      ),
                                                      SizedBox(
                                                        height: mq.size.height *
                                                            0.007,
                                                      ),
                                                    ],
                                                  ),
                                                )
                                              ],
                                            ),
                                          ],
                                        ),
                                      )),
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
}
