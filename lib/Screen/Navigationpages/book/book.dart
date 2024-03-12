import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demo/Screen/Navigationpages/home/tabbarScreen/Flight%20Management/flight_detail.dart';
import 'package:demo/Screen/Navigationpages/home/tabbarScreen/Flight%20Management/flight_search.dart';
import 'package:demo/Screen/Navigationpages/home/tabbarScreen/Hotel%20Management/hoteldetails.dart';
import 'package:demo/Screen/Navigationpages/home/tabbarScreen/Trip%20Management/details.dart';
import 'package:demo/models/Flight%20models/addFlight.dart';
import 'package:demo/models/Hotel%20models/hoteladd.dart';
import 'package:demo/models/Trip%20models/packagemodel.dart';
import 'package:demo/widget/button.dart';
import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ionicons/ionicons.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../../provider/dark_theme_provider.dart';
import '../../../widget/textwidget.dart';

class Book extends StatefulWidget {
  const Book({super.key});

  @override
  State<Book> createState() => _BookState();
}

var isempty = false;

class _BookState extends State<Book> {
  Future<void> deletePackagesByStartDate(String startDate) async {
    CollectionReference packagesRef = FirebaseFirestore.instance
        .collection("booking")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection("bookingPkg");
    QuerySnapshot packagesSnapshot =
        await packagesRef.where('startDate', isEqualTo: startDate).get();
    // ignore: avoid_function_literals_in_foreach_calls
    packagesSnapshot.docs.forEach((doc) async {
      await packagesRef.doc(doc.id).delete();
    });
  }

  List ids = [];
  getid() async {
    FirebaseFirestore.instance
        .collection("package")
        .get()
        .then((QuerySnapshot<Map<String, dynamic>> snapshot) {
      for (var element in snapshot.docs) {
        setState(() {
          ids.add(element['id']);
        });
      }
    });
  }

  deleteUnusedItems() async {
    final items = await FirebaseFirestore.instance
        .collection('booking')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('bookingPkg')
        .get();

    // ignore: avoid_function_literals_in_foreach_calls
    items.docs.forEach((item) {
      final pid = item['id'];

      if (!ids.contains(pid)) {
        // delete unused favorite item
        FirebaseFirestore.instance
            .collection('favorite')
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .collection('items')
            .doc(item.id)
            .delete();
      }
    });
  }

  Future<void> initData() async {
    await getid();
    await deleteUnusedItems();
  }

  @override
  void initState() {
    DateTime dateTime = DateTime.now();
    String datetime1 = "${dateTime.day}-${dateTime.month}-${dateTime.year}";
    deletePackagesByStartDate(datetime1);
    initData();
    super.initState();
  }

  bool focus1 = true;
  bool focus2 = false;
  bool focus3 = false;

  @override
  Widget build(BuildContext context) {
    var mq = MediaQuery.of(context);
    final themeState = Provider.of<DarkThemeProvider>(context);
    Color color = themeState.getDarkTheme ? Colors.white : Colors.black;
    Color color1 = themeState.getDarkTheme ? Colors.white38 : Colors.black38;

    return Scaffold(
        backgroundColor: themeState.getDarkTheme
            ? const Color(0xff121212)
            : const Color.fromARGB(255, 236, 235, 235),
        appBar: AppBar(
          title: const Text("Booking"),

          //centerTitle: true,
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    InkWell(
                      onTap: () {
                        setState(() {
                          focus1 = true;
                          if (focus1 == true) {
                            focus2 = false;
                            focus3 = false;
                          }
                        });
                      },
                      child: Container(
                        height: 40,
                        width: 35.w,
                        decoration: BoxDecoration(
                            color: focus1
                                ? Colors.blue.shade50
                                : Colors.transparent,
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                                color:
                                    focus1 ? const Color(0xff0078aa) : color1,
                                width: 1.5)),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.hiking_outlined,
                                  color:
                                      focus1 ? const Color(0xff0078aa) : color),
                              const SizedBox(
                                width: 10,
                              ),
                              Text(
                                "Trips",
                                style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    color: focus1
                                        ? const Color(0xff0078aa)
                                        : color),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    InkWell(
                      onTap: () {
                        setState(() {
                          focus2 = true;
                          if (focus2 == true) {
                            focus1 = false;
                            focus3 = false;
                          }
                        });
                      },
                      child: Container(
                        height: 40,
                        width: 35.w,
                        decoration: BoxDecoration(
                            color: focus2
                                ? Colors.blue.shade50
                                : Colors.transparent,
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                                color:
                                    focus2 ? const Color(0xff0078aa) : color1,
                                width: 1.5)),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Ionicons.bed_outline,
                                color: focus2 ? const Color(0xff0078aa) : color,
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Text(
                                "Hotels",
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  color:
                                      focus2 ? const Color(0xff0078aa) : color,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    InkWell(
                      onTap: () {
                        setState(() {
                          focus3 = true;
                          if (focus3 == true) {
                            focus2 = false;
                            focus1 = false;
                          }
                        });
                      },
                      child: Container(
                        height: 40,
                        width: 35.w,
                        decoration: BoxDecoration(
                            color: focus3
                                ? Colors.blue.shade50
                                : Colors.transparent,
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                                color:
                                    focus3 ? const Color(0xff0078aa) : color1,
                                width: 1.5)),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Ionicons.airplane_outline,
                                color: focus3 ? const Color(0xff0078aa) : color,
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Text(
                                "Flight",
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  color:
                                      focus3 ? const Color(0xff0078aa) : color,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            focus1
                ? viewTripBooking(mq, themeState)
                : focus2
                    ? viewHotelBooking(mq, themeState)
                    : viewFlightBooking(mq, themeState)
          ],
        ));
  }

  Expanded viewTripBooking(MediaQueryData mq, DarkThemeProvider themeState) {
    return Expanded(
        child: NotificationListener(
      onNotification: (OverscrollIndicatorNotification overscroll) {
        overscroll.disallowIndicator();
        return true;
      },
      child: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 8,
            ),
            NotificationListener(
              onNotification: (OverscrollIndicatorNotification overscroll) {
                overscroll.disallowIndicator();
                return true;
              },
              child: StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection("booking")
                      .doc(FirebaseAuth.instance.currentUser!.uid)
                      .collection("bookingPkg")
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(
                        child: Column(
                          children: [
                            SizedBox(
                              height: mq.size.height * 0.4,
                            ),
                            const CircularProgressIndicator(
                                color: Color(0xff0078aa)),
                          ],
                        ),
                      );
                    }
                    if (!snapshot.hasData ||
                        snapshot.data == null ||
                        snapshot.data!.docs.isEmpty) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        // mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(height: mq.size.height * 0.084),
                          SizedBox(
                            child: Image.asset(
                              "assets/img/wheretonextvector.png",
                              fit: BoxFit.cover,
                            ),
                          ),
                          SizedBox(
                            height: mq.size.height * 0.008,
                          ),
                          const Text(
                            "Where to next?",
                            style: TextStyle(
                                fontWeight: FontWeight.w700, fontSize: 25),
                          ),
                          const SizedBox(
                            height: 18,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 15),
                            child: Text(
                              "You haven't started any trips yet. When you've made a booking, it will appear here.",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                  color: themeState.getDarkTheme
                                      ? Colors.white
                                      : Colors.black),
                            ),
                          ),
                        ],
                      );
                    }
                    var data = snapshot.data!.docs;
                    return ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(8),
                          child: InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => PlaceDetails(
                                            id: data[index]["id"],
                                            totalPrice: data[index]
                                                ["totalprice"],
                                            traveller: data[index]
                                                    ["travellerlist"]
                                                .length,
                                            package: Package(
                                                latitude: data[index]
                                                    ["latitude"],
                                                longitude: data[index]
                                                    ["longitude"],
                                                ActivityList: data[index]
                                                    ["activityList"],
                                                startingForm: data[index]
                                                    ["startingForm"],
                                                traveligTo: data[index]
                                                    ["traveligTo"],
                                                startDate: data[index]
                                                    ["startDate"],
                                                endDate: data[index]["endDate"],
                                                imgUrl: data[index]["imgUrl"],
                                                decs: data[index]["decs"],
                                                price: data[index]["price"],
                                                img1: data[index]["img1"],
                                                img2: data[index]["img2"],
                                                img3: data[index]["img3"],
                                                img4: data[index]["img4"],
                                                flightDate: data[index]
                                                    ["flightDate"],
                                                reachDate: data[index]
                                                    ["reachDate"],
                                                flightTime: data[index]
                                                    ["flightTime"],
                                                reachTime: data[index]
                                                    ["reachTime"],
                                                hotelName: data[index]
                                                    ["hotelName"],
                                                hotelImg: data[index]
                                                    ["hotelImg"],
                                                hotelAdd: data[index]
                                                    ["hotelAdd"],
                                                hotelPhone: data[index]
                                                    ["hotelPhone"],
                                                hotelRate: data[index]
                                                    ["hotelRate"],
                                                retunfligthdate: data[index]
                                                    ["retunFligthDate"],
                                                retunreachfligthdate: data[
                                                        index]
                                                    ["retunReachFligthDate"],
                                                retunfligthtime: data[index]
                                                    ["retunFligthTime"],
                                                retunreachfligthtime: data[
                                                        index]
                                                    ["retunReachFligthTime"]),
                                          )));
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                  color: themeState.getDarkTheme
                                      ? const Color(0xff212121)
                                      : const Color(0xffffffff),
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(10))),
                              width: mq.size.width,
                              height: mq.size.height * 0.4,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                      height: mq.size.width * 0.45,
                                      width: double.infinity,
                                      child: FancyShimmerImage(
                                        boxFit: BoxFit.cover,
                                        imageUrl: data[index]["imgUrl"],
                                      )),
                                  Padding(
                                    padding:
                                        const EdgeInsets.only(left: 8, top: 8),
                                    child: Titletext(
                                        title: data[index]["traveligTo"]),
                                  ),
                                  Padding(
                                    padding:
                                        const EdgeInsets.only(left: 5, top: 8),
                                    child: Row(
                                      children: [
                                        const Icon(
                                          Icons.location_on_outlined,
                                          size: 16,
                                        ),
                                        Text.rich(
                                          TextSpan(
                                              text: " Starting from : ",
                                              children: [
                                                TextSpan(
                                                    text: data[index]
                                                        ["startingForm"],
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        color: themeState
                                                                .getDarkTheme
                                                            ? Colors.white
                                                                .withOpacity(
                                                                    0.6)
                                                            : Colors.black
                                                                .withOpacity(
                                                                    0.6)))
                                              ]),
                                        )
                                      ],
                                    ),
                                  ),
                                  const Spacer(),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        right: 5, bottom: 5, left: 5),
                                    child: Row(
                                      children: [
                                        Text.rich(
                                          TextSpan(
                                              text: " Date : ",
                                              style: TextStyle(
                                                color: themeState.getDarkTheme
                                                    ? Colors.white
                                                    : Colors.black,
                                              ),
                                              children: [
                                                TextSpan(
                                                    text: data[index]
                                                        ["startDate"],
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        color: themeState
                                                                .getDarkTheme
                                                            ? Colors.white
                                                                .withOpacity(
                                                                    0.6)
                                                            : Colors.black
                                                                .withOpacity(
                                                                    0.6)))
                                              ]),
                                        ),
                                        const Spacer(),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(bottom: 6),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Text(
                                                data[index]["totalprice"]
                                                    .toString(),
                                                style: const TextStyle(
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 20),
                                              ),
                                              Text(
                                                  data[index]["travellerlist"]
                                                              .isEmpty ||
                                                          data[index]["travellerlist"]
                                                                  .length ==
                                                              1
                                                      ? "1 Traveller"
                                                      : "${data[index]["travellerlist"].length} Traveller",
                                                  style: TextStyle(
                                                      fontSize: 13,
                                                      color: themeState
                                                              .getDarkTheme
                                                          ? Colors.white54
                                                          : Colors.black54,
                                                      fontWeight:
                                                          FontWeight.w400))
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  }),
            ),
            const SizedBox(
              height: 8,
            ),
          ],
        ),
      ),
    ));
  }

  Expanded viewHotelBooking(MediaQueryData mq, DarkThemeProvider themeState) {
    return Expanded(
        child: NotificationListener(
      onNotification: (OverscrollIndicatorNotification overscroll) {
        overscroll.disallowIndicator();
        return true;
      },
      child: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 8,
            ),
            NotificationListener(
              onNotification: (OverscrollIndicatorNotification overscroll) {
                overscroll.disallowIndicator();
                return true;
              },
              child: StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection("HotelBooking")
                      .doc(FirebaseAuth.instance.currentUser!.uid)
                      .collection("UserBooking")
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(
                        child: Column(
                          children: [
                            SizedBox(
                              height: mq.size.height * 0.4,
                            ),
                            const CircularProgressIndicator(
                                color: Color(0xff0078aa)),
                          ],
                        ),
                      );
                    }
                    if (!snapshot.hasData ||
                        snapshot.data == null ||
                        snapshot.data!.docs.isEmpty) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        // mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(height: mq.size.height * 0.084),
                          SizedBox(
                            child: Image.asset(
                              "assets/img/wheretonextvector.png",
                              fit: BoxFit.cover,
                            ),
                          ),
                          SizedBox(
                            height: mq.size.height * 0.008,
                          ),
                          const Text(
                            "Where to next?",
                            style: TextStyle(
                                fontWeight: FontWeight.w700, fontSize: 25),
                          ),
                          const SizedBox(
                            height: 18,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 15),
                            child: Text(
                              "You haven't started any trips yet. When you've made a booking, it will appear here.",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                  color: themeState.getDarkTheme
                                      ? Colors.white
                                      : Colors.black),
                            ),
                          ),
                        ],
                      );
                    }

                    var data = snapshot.data!.docs;
                    return ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: data.length,
                        itemBuilder: (context, index) {
                          var date = getNight(data[index]["check_in"],
                              data[index]["check_out"]);

                          return Padding(
                            padding: const EdgeInsets.only(bottom: 12),
                            child: GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => HotelDetails(
                                        check_In: data[index]["check_in"],
                                        check_Out: data[index]["check_out"],
                                        child:
                                            int.parse(data[index]["children"]),
                                        room: int.parse(data[index]["room"]),
                                        adults: int.parse(data[index]["adult"]),
                                        totalPrice: int.parse(
                                                data[index]["totalPrice"]) *
                                            date,
                                        id: data[index].id,
                                        hotel: Hotel(
                                            facilities: data[index]
                                                ["facilities"],
                                            name: data[index]["name"],
                                            description: data[index]
                                                ["description"],
                                            images: data[index]["images"],
                                            price: data[index]["price"],
                                            cityName: data[index]["cityName"],
                                            disttocenter: data[index]
                                                ["disttocenter"],
                                            address: data[index]["address"],
                                            latitude: data[index]["latitude"],
                                            longitude: data[index]["longitude"],
                                            checkinfrom: data[index]
                                                ["checkinfrom"],
                                            checkinUntil: data[index]
                                                ["checkinUntil"],
                                            checkoutUntil: data[index]
                                                ["checkoutUntil"],
                                            transeferFee: data[index]
                                                ["transeferFee"],
                                            distFromAirport: data[index]
                                                ["distFromAirport"],
                                            traveltimetoairport: data[index]
                                                ["traveltimetoairport"]),
                                      ),
                                    ));
                              },
                              child: Container(
                                // width: mq.size.width,
                                color: themeState.getDarkTheme
                                    ? const Color(0xff212121)
                                    : const Color(0xffffffff),
                                // elevation: 5,
                                //  shape: RoundedRectangleBorder(
                                //    borderRadius: BorderRadius.circular(10)),
                                child: Padding(
                                  padding:
                                      EdgeInsets.all(mq.size.width * 0.026),
                                  child: Column(
                                    children: <Widget>[
                                      AspectRatio(
                                          aspectRatio: 1.8,
                                          child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                              child: FancyShimmerImage(
                                                imageUrl:
                                                    data[index]["images"].first,
                                                boxFit: BoxFit.cover,
                                              ))),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Expanded(
                                            child: Column(
                                              children: <Widget>[
                                                Padding(
                                                  padding: EdgeInsets.symmetric(
                                                      vertical: mq.size.width *
                                                          0.023),
                                                  child: Row(
                                                    children: [
                                                      Titletext(
                                                          title: data[index]
                                                              ["name"]),
                                                      const Spacer(),
                                                    ],
                                                  ),
                                                ),
                                                Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  children: <Widget>[
                                                    Icon(
                                                      Icons
                                                          .location_on_outlined,
                                                      color: themeState
                                                              .getDarkTheme
                                                          ? Colors.white
                                                          : Colors.black,
                                                      size: 16,
                                                    ),
                                                    Text(
                                                      "${data[index]["cityName"]} - ${data[index]["disttocenter"]} km to center",
                                                      style: TextStyle(
                                                          color: themeState
                                                                  .getDarkTheme
                                                              ? Colors.white
                                                                  .withOpacity(
                                                                      0.75)
                                                              : Colors.black
                                                                  .withOpacity(
                                                                      0.6)),
                                                    ),
                                                  ],
                                                ),
                                                Row(
                                                  children: [
                                                    const Spacer(),
                                                    Padding(
                                                      padding: EdgeInsets.only(
                                                          top: mq.size.width *
                                                              0.023,
                                                          bottom: mq.size
                                                                      .width *
                                                                  0.03 -
                                                              mq.size.width *
                                                                  0.021),
                                                      child: Text(
                                                        "${data[index]["room"]} Hotel rooms : ${data[index]["room"]} bed",
                                                        style: TextStyle(
                                                            color: themeState
                                                                    .getDarkTheme
                                                                ? Colors.white
                                                                    .withOpacity(
                                                                        0.75)
                                                                : Colors.black
                                                                    .withOpacity(
                                                                        0.6)),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                Row(
                                                  children: [
                                                    const Spacer(),
                                                    Padding(
                                                      padding: EdgeInsets.only(
                                                          // top: mq.size.width * 0.023,
                                                          bottom: mq.size
                                                                      .width *
                                                                  0.03 -
                                                              mq.size.width *
                                                                  0.023),
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .end,
                                                        children: [
                                                          Text(
                                                              "Price for $date night, ${int.parse(data[index]["adult"]) + int.parse(data[index]["children"])} Travellers",
                                                              style: TextStyle(
                                                                  fontSize: 13,
                                                                  color: themeState
                                                                          .getDarkTheme
                                                                      ? Colors
                                                                          .white
                                                                      : Colors
                                                                          .black,
                                                                  //  fontWeight: FontWeight.w500,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500)),
                                                          const SizedBox(
                                                            height: 2,
                                                          ),
                                                          Text(
                                                            "₹${int.parse(data[index]["totalPrice"]) * date}",
                                                            style: TextStyle(
                                                                color: themeState
                                                                        .getDarkTheme
                                                                    ? Colors
                                                                        .white
                                                                    : Colors
                                                                        .black,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                                fontSize: 20),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                )
                                              ],
                                            ),
                                          ),
                                        ],
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
            const SizedBox(
              height: 8,
            ),
          ],
        ),
      ),
    ));
  }

  Expanded viewFlightBooking(MediaQueryData mq, DarkThemeProvider themeState) {
    return Expanded(
        child: NotificationListener(
      onNotification: (OverscrollIndicatorNotification overscroll) {
        overscroll.disallowIndicator();
        return true;
      },
      child: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 8,
            ),
            NotificationListener(
              onNotification: (OverscrollIndicatorNotification overscroll) {
                overscroll.disallowIndicator();
                return true;
              },
              child: StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection("FlightBooking")
                      .doc(FirebaseAuth.instance.currentUser!.uid)
                      .collection("FlightUserBooking")
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(
                        child: Column(
                          children: [
                            SizedBox(
                              height: mq.size.height * 0.4,
                            ),
                            const CircularProgressIndicator(
                                color: Color(0xff0078aa)),
                          ],
                        ),
                      );
                    }
                    if (!snapshot.hasData ||
                        snapshot.data == null ||
                        snapshot.data!.docs.isEmpty) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        // mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(height: mq.size.height * 0.084),
                          SizedBox(
                            child: Image.asset(
                              "assets/img/wheretonextvector.png",
                              fit: BoxFit.cover,
                            ),
                          ),
                          SizedBox(
                            height: mq.size.height * 0.008,
                          ),
                          const Text(
                            "Where to next?",
                            style: TextStyle(
                                fontWeight: FontWeight.w700, fontSize: 25),
                          ),
                          const SizedBox(
                            height: 18,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 15),
                            child: Text(
                              "You haven't started any trips yet. When you've made a booking, it will appear here.",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                  color: themeState.getDarkTheme
                                      ? Colors.white
                                      : Colors.black),
                            ),
                          ),
                        ],
                      );
                    }

                    var data = snapshot.data!.docs;
                    return ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: data.length,
                        itemBuilder: (context, index) {
                          var time = gettime(data[index]["takeoffTime"],
                              data[index]["landingTime"]);
                          var time2 = gettime2(data[index]["takeoffTime"],
                              data[index]["landingTime"]);
                          var sDate = getdate(data[index]["startDate"]);
                          var eDate = getdate(data[index]["endDate"]);
                          var sdate1 = getdate1(data[index]["startDate"]);
                          var edate1 = getdate1(data[index]["endDate"]);
                          var c1 =
                              getWordBeforeAirport(data[index]["startingFrom"]);
                          var c2 =
                              getWordBeforeAirport(data[index]["travelingTo"]);
                          var c4 =
                              getWordafterAirport(data[index]["travelingTo"]);
                          var c3 =
                              getWordafterAirport(data[index]["startingFrom"]);
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 12),
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
                                  padding:
                                      const EdgeInsetsDirectional.symmetric(
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
                                                    color:
                                                        themeState.getDarkTheme
                                                            ? Colors.white24
                                                            : Colors.black26),
                                                borderRadius:
                                                    BorderRadius.circular(10)),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 8,
                                                      horizontal: 8),
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
                                            time,
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
                                                    color:
                                                        themeState.getDarkTheme
                                                            ? Colors.white
                                                            : Colors.black),
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    c1,
                                                    style: TextStyle(
                                                        fontSize: 11,
                                                        color: themeState
                                                                .getDarkTheme
                                                            ? Colors.white
                                                            : Colors.black),
                                                  ),
                                                  Text(
                                                    " - $sDate",
                                                    style: const TextStyle(
                                                        fontSize: 11,
                                                        color: Colors.grey),
                                                  ),
                                                ],
                                              )
                                            ],
                                          ),
                                          Expanded(
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Stack(
                                                children: [
                                                  SizedBox(
                                                    height: 24,
                                                    child: LayoutBuilder(
                                                      builder: (context,
                                                          constraints) {
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
                                                                MainAxisSize
                                                                    .max,
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
                                                      color: Colors
                                                          .indigo.shade300,
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
                                                    color:
                                                        themeState.getDarkTheme
                                                            ? Colors.white
                                                            : Colors.black),
                                              ),
                                              Row(
                                                children: [
                                                  Text(
                                                    c2,
                                                    style: TextStyle(
                                                        fontSize: 11,
                                                        color: themeState
                                                                .getDarkTheme
                                                            ? Colors.white
                                                            : Colors.black),
                                                  ),
                                                  Text(
                                                    " - $eDate",
                                                    style: const TextStyle(
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
                                                    color:
                                                        themeState.getDarkTheme
                                                            ? Colors.white
                                                            : Colors.black),
                                                const SizedBox(
                                                  width: 5,
                                                ),
                                                Text(
                                                  data[index]["classtype"],
                                                  style: TextStyle(
                                                      color: themeState
                                                              .getDarkTheme
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
                                          title: "View Booking",
                                          callback: () {
                                            indexFlightDate += "$index";
                                            Navigator.of(context)
                                                .push(MaterialPageRoute(
                                              builder: (context) => FlightDetail(
                                                  id: data[index]["id"],
                                                  startingsortfrom: c3,
                                                  travellingsortto: c4,
                                                  startingfrom: c1,
                                                  sdate: sdate1,
                                                  edate: edate1,
                                                  timeduration: time2,
                                                  classtype: data[index]
                                                      ["classtype"],
                                                  travellingto: c2,
                                                  addFlight: AddFlight(
                                                      id: data[index]["id"],
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
                                                      price: data[index]
                                                          ["price"],
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
            const SizedBox(
              height: 8,
            ),
          ],
        ),
      ),
    ));
  }

  int getNight(String checkIn, String checkOut) {
    DateFormat dateFormat = DateFormat("dd-MM-yyyy");
    DateTime dateTime1 = dateFormat.parse(checkIn);
    DateTime dateTime2 = dateFormat.parse(checkOut);
    Duration duration = dateTime2.difference(dateTime1);
    return duration.inDays;
  }

  String gettime2(String stime, String etime) {
    DateFormat format = DateFormat('hh:mm a');
    DateTime time1 = format.parse(etime);
    DateTime time2 = format.parse(stime);

    Duration difference = time1.difference(time2);

    return "${difference.inHours.toString()}h : ${difference.inMinutes.remainder(60).toString()}m";
  }

  String getdate1(String date) {
    DateTime datetime = DateFormat('dd-MM-yyyy').parse(date);
    String formattedDate = DateFormat('EEE dd MMM').format(datetime);
    return formattedDate;
  }

  String getdate(String date) {
    DateTime datetime = DateFormat('dd-MM-yyyy').parse(date);
    String formattedDate = DateFormat('dd MMM').format(datetime);
    return formattedDate;
  }

  String getWordafterAirport(String airportString) {
    List<String> parts = airportString.split(' ');

    return parts.last;
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

  String gettime(String stime, String etime) {
    DateFormat format = DateFormat('hh:mm a');
    DateTime time1 = format.parse(etime);
    DateTime time2 = format.parse(stime);

    Duration difference = time1.difference(time2);

    return "${difference.inHours.toString().padLeft(2, '0')} hr ${difference.inMinutes.remainder(60).toString().padLeft(2, '0')} min";
  }
}
