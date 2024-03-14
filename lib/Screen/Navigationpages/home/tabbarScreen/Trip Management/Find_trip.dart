import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demo/Screen/Navigationpages/home/tabbarScreen/Trip%20Management/details.dart';
import 'package:demo/models/Trip%20models/packagemodel.dart';
import 'package:demo/provider/dark_theme_provider.dart';
import 'package:demo/widget/textwidget.dart';
import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class Find_trip extends StatefulWidget {
  bool search;
  String sform;
  String tto;
  String date;
  Find_trip(
      {super.key,
      required this.date,
      required this.sform,
      required this.tto,
      required this.search});

  @override
  State<Find_trip> createState() => _Find_tripState();
}

class _Find_tripState extends State<Find_trip> {
  addToFavorite(String ids) async {
    QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection("package")
        .where("id", isEqualTo: ids)
        .get();

    if (snapshot.docs.isNotEmpty) {
      DocumentSnapshot document = snapshot.docs.first;
      CollectionReference collectionReference =
          FirebaseFirestore.instance.collection("favorite");
      await collectionReference
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection("items")
          .doc(document.id)
          .set({
        "latitude": document["latitude"],
        "longitude": document["longitude"],
        "pid": document["id"],
        'startingForm': document["startingForm"],
        "traveligTo": document["traveligTo"],
        "startDate": document["startDate"],
        "endDate": document["endDate"],
        "imgUrl": document["imgUrl"],
        "decs": document["decs"],
        "price": document["price"],
        "img1": document["img1"],
        "img2": document["img2"],
        "img3": document["img3"],
        "img4": document["img4"],
        "flightDate": document["flightDate"],
        "reachDate": document["reachDate"],
        "flightTime": document["flightTime"],
        "reachTime": document["reachTime"],
        "hotelName": document["hotelName"],
        "hotelImg": document["hotelImg"],
        "hotelAdd": document["hotelAdd"],
        "hotelPhone": document["hotelPhone"],
        "hotelRate": document["hotelRate"],
        "activityList": document["activityList"],
        "isFavorite": document["isFavorite"],
        'retunFligthDate': document["retunFligthDate"],
        'retunReachFligthDate': document["retunReachFligthDate"],
        'retunFligthTime': document["retunFligthTime"],
        'retunReachFligthTime': document["retunReachFligthTime"],
        "type": "favorite"
      });
    }
  }

  removFavorite(String id) async {
    CollectionReference collectionReference =
        FirebaseFirestore.instance.collection("favorite");
    await collectionReference
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection("items")
        .doc(id)
        .delete();
  }

  void pop1() {
    Navigator.pop(context);
    Navigator.pop(context);
  }

  Future<void> recentSearch(String id, String tavelingto, String startingfrom,
      String startdate, String url) async {
    CollectionReference cr =
        FirebaseFirestore.instance.collection("TripResentsearch");

    Map<String, dynamic> data = {
      "id": id,
      "tavelingto": tavelingto,
      "startingfrom": startingfrom,
      "startdate": startdate,
      "url": url
    };
    await cr
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection("tripSearch")
        .doc(id)
        .set(data);
  }

  @override
  Widget build(BuildContext context) {
    final themeState = Provider.of<DarkThemeProvider>(context);
    Color color = themeState.getDarkTheme ? Colors.white : Colors.black;
    var mq = MediaQuery.of(context);
    return Scaffold(
      backgroundColor: themeState.getDarkTheme
          ? const Color(0xff121212)
          : const Color.fromARGB(255, 236, 235, 235),
      appBar: AppBar(
          title: const Text("Search Trips"),
          leading: IconButton(
              onPressed: () {
                widget.search ? pop1() : Navigator.pop(context);
              },
              icon: const Icon(IconlyLight.arrow_left_2, color: Colors.white))),
      body: StreamBuilder(
          stream: FirebaseFirestore.instance.collection("package").snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: Text(""));
            }
            if (!snapshot.hasData ||
                snapshot.data == null ||
                snapshot.data!.docs.isEmpty) {
              return SingleChildScrollView(
                child: SizedBox(
                  height: mq.size.height / 1.3,
                  width: mq.size.width,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Lottie.asset(
                        "assets/img/no_data_found.json",
                      ),
                      const Text(
                        "DATA NOT FOUND!",
                        style: TextStyle(
                            fontWeight: FontWeight.w500, fontSize: 22),
                      ),
                    ],
                  ),
                ),
              );
            }
            final data = snapshot.data!.docs.where((documentSnapshot) {
              var sform1 = widget.sform.toLowerCase();
              var tto1 = widget.tto.toLowerCase();
              var date1 = widget.date.toLowerCase();
              var Startingfrom =
                  documentSnapshot['startingForm'].toString().toLowerCase();
              var travelingto =
                  documentSnapshot['traveligTo'].toString().toLowerCase();
              var startdate =
                  documentSnapshot['startDate'].toString().toLowerCase();
              return Startingfrom.contains(sform1) &&
                  travelingto.contains(tto1) &&
                  startdate.contains(date1);
            }).toList();
            if (data.isEmpty) {
              return SingleChildScrollView(
                child: SizedBox(
                  height: mq.size.height / 1.3,
                  width: mq.size.width,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        "assets/img/pastvector.png",
                        scale: 5,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const Text(
                        "TRIP NOT FOUND!",
                        style: TextStyle(
                            fontWeight: FontWeight.w500, fontSize: 22),
                      ),
                    ],
                  ),
                ),
              );
            }

            return Padding(
              padding: EdgeInsets.only(bottom: mq.size.height * 0.02),
              child: ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: data.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => PlaceDetails(
                              id: data[index].id,
                              package: Package(
                                  latitude: data[index]["latitude"],
                                  longitude: data[index]["longitude"],
                                  id: data[index].id,
                                  ActivityList: data[index]["activityList"],
                                  startingForm: data[index]["startingForm"],
                                  traveligTo: data[index]["traveligTo"],
                                  startDate: data[index]["startDate"],
                                  endDate: data[index]["endDate"],
                                  imgUrl: data[index]["imgUrl"],
                                  decs: data[index]["decs"],
                                  price: data[index]["price"],
                                  img1: data[index]["img1"],
                                  img2: data[index]["img2"],
                                  img3: data[index]["img3"],
                                  img4: data[index]["img4"],
                                  flightDate: data[index]["flightDate"],
                                  reachDate: data[index]["reachDate"],
                                  flightTime: data[index]["flightTime"],
                                  reachTime: data[index]["reachTime"],
                                  hotelName: data[index]["hotelName"],
                                  hotelImg: data[index]["hotelImg"],
                                  hotelAdd: data[index]["hotelAdd"],
                                  hotelPhone: data[index]["hotelPhone"],
                                  hotelRate: data[index]["hotelRate"],
                                  retunfligthdate: data[index]
                                      ["retunFligthDate"],
                                  retunreachfligthdate: data[index]
                                      ["retunReachFligthDate"],
                                  retunfligthtime: data[index]
                                      ["retunFligthTime"],
                                  retunreachfligthtime: data[index]
                                      ["retunReachFligthTime"]),
                            ),
                          ));

                      recentSearch(data[index]["id"], widget.tto, widget.sform,
                          widget.date, data[index]["img1"]);
                    },
                    child: Container(
                      color: themeState.getDarkTheme
                          ? const Color(0xff212121)
                          : const Color(0xffffffff),
                      // elevation: 3,
                      child: Padding(
                        padding: EdgeInsets.all(mq.size.width * 0.023),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(
                                  bottom: mq.size.width * 0.03,
                                  top: mq.size.width * 0.03 -
                                      mq.size.width * 0.023),
                              child: Row(
                                children: [
                                  Titletext(title: data[index]["traveligTo"]),
                                  const Spacer(),
                                  StreamBuilder(
                                      stream: FirebaseFirestore.instance
                                          .collection("favorite")
                                          .doc(FirebaseAuth
                                              .instance.currentUser!.uid)
                                          .collection("items")
                                          .where("pid",
                                              isEqualTo: data[index].id)
                                          .snapshots(),
                                      builder: (context,
                                          AsyncSnapshot<QuerySnapshot>
                                              snapshot) {
                                        if (snapshot.data == null) {
                                          return const Text("");
                                        }
                                        return InkWell(
                                            onTap: () {
                                              snapshot.data!.docs.length == 0
                                                  ? addToFavorite(
                                                      data[index].id)
                                                  : removFavorite(
                                                      data[index].id);
                                            },
                                            child: Icon(
                                              snapshot.data!.docs.length == 0
                                                  ? Icons.favorite_outline
                                                  : Icons.favorite,
                                              color:
                                                  snapshot.data!.docs.length ==
                                                          0
                                                      ? color
                                                      : Colors.red,
                                            ));
                                      })
                                ],
                              ),
                            ),
                            SizedBox(
                                height: mq.size.width * 0.45,
                                width: double.infinity,
                                child: FancyShimmerImage(
                                  imageUrl: data[index]["imgUrl"]!,
                                )),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: mq.size.width * 0.023),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.location_on_outlined,
                                    color: themeState.getDarkTheme
                                        ? Colors.white
                                        : Colors.black,
                                    size: 16,
                                  ),
                                  Text.rich(
                                    TextSpan(
                                        text: " Starting from : ",
                                        style: TextStyle(
                                          color: themeState.getDarkTheme
                                              ? Colors.white
                                              : Colors.black,
                                        ),
                                        children: [
                                          TextSpan(
                                              text: data[index]["startingForm"],
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w500,
                                                  color: themeState.getDarkTheme
                                                      ? Colors.white
                                                          .withOpacity(0.6)
                                                      : Colors.black
                                                          .withOpacity(0.6)))
                                        ]),
                                  ),
                                ],
                              ),
                            ),
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
                                        text: data[index]["startDate"],
                                        style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            color: themeState.getDarkTheme
                                                ? Colors.white.withOpacity(0.6)
                                                : Colors.black
                                                    .withOpacity(0.6)))
                                  ]),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: mq.size.width * 0.023),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    children: [
                                      RotatedBox(
                                          quarterTurns: 1,
                                          child: Icon(
                                            Icons.flight,
                                            color: themeState.getDarkTheme
                                                ? Colors.white
                                                : Colors.black,
                                          )),
                                      Padding(
                                        padding: EdgeInsets.all(
                                            mq.size.width * 0.0115),
                                        child: Text(
                                          "2 Flight",
                                          style: TextStyle(
                                              fontWeight: FontWeight.normal,
                                              color: themeState.getDarkTheme
                                                  ? Colors.white
                                                      .withOpacity(0.7)
                                                  : Colors.black
                                                      .withOpacity(0.7)),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      Icon(
                                        Icons.business_outlined,
                                        color: themeState.getDarkTheme
                                            ? Colors.white
                                            : Colors.black,
                                      ),
                                      Padding(
                                        padding: EdgeInsets.all(
                                            mq.size.width * 0.0115),
                                        child: Text(
                                          "1 Hotel",
                                          style: TextStyle(
                                              fontWeight: FontWeight.normal,
                                              color: themeState.getDarkTheme
                                                  ? Colors.white
                                                      .withOpacity(0.7)
                                                  : Colors.black
                                                      .withOpacity(0.7)),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      Icon(
                                        Icons.hiking_sharp,
                                        color: themeState.getDarkTheme
                                            ? Colors.white
                                            : Colors.black,
                                      ),
                                      Padding(
                                        padding: EdgeInsets.all(
                                            mq.size.width * 0.0115),
                                        child: Text(
                                          "${data[index]["activityList"]!.length} Activities",
                                          style: TextStyle(
                                              fontWeight: FontWeight.normal,
                                              color: themeState.getDarkTheme
                                                  ? Colors.white
                                                      .withOpacity(0.7)
                                                  : Colors.black
                                                      .withOpacity(0.7)),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 2,
                            ),
                            Row(
                              children: [
                                const Spacer(),
                                Padding(
                                  padding: EdgeInsets.only(
                                      bottom: mq.size.width * 0.03 -
                                          mq.size.width * 0.023),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        "₹${data[index]["price"]}",
                                        style: TextStyle(
                                            color: themeState.getDarkTheme
                                                ? Colors.white
                                                : Colors.black,
                                            fontWeight: FontWeight.w500,
                                            fontSize: 20),
                                      ),
                                      Text("per person",
                                          style: TextStyle(
                                              fontSize: 13,
                                              color: themeState.getDarkTheme
                                                  ? Colors.white54
                                                  : Colors.black54,
                                              fontWeight: FontWeight.w400))
                                    ],
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            );
          }),
    );
  }
}
