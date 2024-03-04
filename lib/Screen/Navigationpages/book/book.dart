import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demo/Screen/Navigationpages/home/tabbarScreen/Trip%20Management/details.dart';
import 'package:demo/models/Trip%20models/packagemodel.dart';
import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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

  @override
  Widget build(BuildContext context) {
    var mq = MediaQuery.of(context);
    final themeState = Provider.of<DarkThemeProvider>(context);
    // Color color = themeState.getDarkTheme ? Colors.white : Colors.black;
    return Scaffold(
        appBar: AppBar(
          title: const Text("Booking"),
          //centerTitle: true,
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
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
                      onNotification:
                          (OverscrollIndicatorNotification overscroll) {
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
                            if (!snapshot.hasData) {
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
                            if (snapshot.data!.docs.isEmpty) {
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
                                        fontWeight: FontWeight.w700,
                                        fontSize: 25),
                                  ),
                                  const SizedBox(
                                    height: 18,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 15),
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
                                              builder: (context) =>
                                                  PlaceDetails(
                                                    id: data[index]["id"],
                                                    package: Package(
                                                      latitude:  data[index]["latitude"],
                                                      longitude: data[index]["longitude"]
,
                                                        ActivityList: data[index]
                                                            ["activityList"],
                                                        startingForm: data[index]
                                                            ["startingForm"],
                                                        traveligTo: data[index]
                                                            ["traveligTo"],
                                                        startDate: data[index]
                                                            ["startDate"],
                                                        endDate: data[index]
                                                            ["endDate"],
                                                        imgUrl: data[index]
                                                            ["imgUrl"],
                                                        decs: data[index]
                                                            ["decs"],
                                                        price: data[index]
                                                            ["price"],
                                                        img1: data[index]
                                                            ["img1"],
                                                        img2: data[index]
                                                            ["img2"],
                                                        img3: data[index]
                                                            ["img3"],
                                                        img4: data[index]
                                                            ["img4"],
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
                                                        hotelImg: data[index]["hotelImg"],
                                                        hotelAdd: data[index]["hotelAdd"],
                                                        hotelPhone: data[index]["hotelPhone"],
                                                        hotelRate: data[index]["hotelRate"],
                                                        retunfligthdate: data[index]["retunFligthDate"],
                                                        retunreachfligthdate: data[index]["retunReachFligthDate"],
                                                        retunfligthtime: data[index]["retunFligthTime"],
                                                        retunreachfligthtime: data[index]["retunReachFligthTime"]),
                                                  )));
                                    },
                                    child: Card(
                                      elevation: 3,
                                      child: Container(
                                        decoration: BoxDecoration(
                                            color: themeState.getDarkTheme
                                                ? const Color(0xff212121)
                                                : const Color(0xffffffff),
                                            borderRadius:
                                                const BorderRadius.all(
                                                    Radius.circular(10))),
                                        width: mq.size.width,
                                        height: mq.size.height * 0.352,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            SizedBox(
                                                height: mq.size.width * 0.45,
                                                width: double.infinity,
                                                child: FancyShimmerImage(
                                                  boxFit: BoxFit.cover,
                                                  imageUrl: data[index]
                                                      ["imgUrl"],
                                                )),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 8, top: 8),
                                              child: Titletext(
                                                  title: data[index]
                                                      ["traveligTo"]),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 5, top: 8),
                                              child: Row(
                                                children: [
                                                  const Icon(
                                                    Icons.location_on_outlined,
                                                    size: 16,
                                                  ),
                                                  Text.rich(
                                                    TextSpan(
                                                        text:
                                                            " Starting from : ",
                                                        children: [
                                                          TextSpan(
                                                              text: data[index][
                                                                  "startingForm"],
                                                              style: TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                  color: themeState
                                                                          .getDarkTheme
                                                                      ? Colors
                                                                          .white
                                                                          .withOpacity(
                                                                              0.6)
                                                                      : Colors
                                                                          .black
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
                                                          color: themeState
                                                                  .getDarkTheme
                                                              ? Colors.white
                                                              : Colors.black,
                                                        ),
                                                        children: [
                                                          TextSpan(
                                                              text: data[index]
                                                                  ["startDate"],
                                                              style: TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                  color: themeState
                                                                          .getDarkTheme
                                                                      ? Colors
                                                                          .white
                                                                          .withOpacity(
                                                                              0.6)
                                                                      : Colors
                                                                          .black
                                                                          .withOpacity(
                                                                              0.6)))
                                                        ]),
                                                  ),
                                                  const Spacer(),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            bottom: 6),
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      children: [
                                                        Text(
                                                          data[index]
                                                                  ["totalprice"]
                                                              .toString(),
                                                          style: const TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                              fontSize: 20),
                                                        ),
                                                        Text(
                                                            data[index]["travellerlist"]
                                                                        .isEmpty ||
                                                                    data[index][
                                                                                "travellerlist"]
                                                                            .length ==
                                                                        1
                                                                ? "1 Traveller"
                                                                : "${data[index]["travellerlist"].length} Traveller",
                                                            style: TextStyle(
                                                                fontSize: 13,
                                                                color: themeState
                                                                        .getDarkTheme
                                                                    ? Colors
                                                                        .white54
                                                                    : Colors
                                                                        .black54,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400))
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
            ))
          ],
        ));
  }
}
