// ignore_for_file: camel_case_types, unused_local_variable, non_constant_identifier_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demo/models/Hotel%20models/hoteladd.dart';
import 'package:demo/provider/dark_theme_provider.dart';
import 'package:demo/widget/textwidget.dart';
import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';

import 'package:iconly/iconly.dart';
import 'package:provider/provider.dart';

import 'hoteldetails.dart';

// ignore: must_be_immutable
class show_hotel extends StatefulWidget {
  String destination;

  String check_In;
  String check_Out;
  int room;
  int adults;
  int child;
  show_hotel(
      {super.key,
      required this.adults,
      required this.destination,
      required this.room,
      required this.check_In,
      required this.check_Out,
      required this.child});

  @override
  State<show_hotel> createState() => _show_hotelState();
}

class _show_hotelState extends State<show_hotel> {
  addToFavorite(String hotelid) async {
    QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection("Hotel")
        .where("id", isEqualTo: hotelid)
        .get();
    if (snapshot.docs.isNotEmpty) {
      DocumentSnapshot document = snapshot.docs.first;
      CollectionReference collectionReference =
          FirebaseFirestore.instance.collection("Favoritehotel");
      await collectionReference
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection("hotels")
          .doc(document.id)
          .set({
        "fid": document.id,
        "name": document["name"],
        "description": document["description"],
        "facilities": document["facilities"],
        "images": document["images"],
        "price": document["price"],
        "cityName": document["cityName"],
        "disttocenter": document["disttocenter"],
        "address": document["address"],
        "latitude": document["latitude"],
        "longitude": document["longitude"],
        "checkinfrom": document["checkinfrom"],
        "checkinUntil": document["checkinUntil"],
        "checkoutUntil": document["checkoutUntil"],
        "transeferFee": document["transeferFee"],
        "distFromAirport": document["distFromAirport"],
        "traveltimetoairport": document["traveltimetoairport"],
      });
    }
  }

  removFavorite(String hotelid) async {
    CollectionReference collectionReference =
        FirebaseFirestore.instance.collection("Favoritehotel");
    await collectionReference
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection("hotels")
        .doc(hotelid)
        .delete();
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
          title: const Text("Book Trip"),
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(IconlyLight.arrow_left_2, color: Colors.white))),
      body: StreamBuilder(
          stream: FirebaseFirestore.instance.collection("Hotel").snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(
                  color: Color(0xff0078aa),
                ),
              );
            }
            if (!snapshot.hasData ||
                snapshot.data == null ||
                snapshot.data!.docs.isEmpty) {
              return Center(
                child: Text(
                  "NO DATA FOUND!",
                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 22),
                ),
              );
            }
            final data = snapshot.data!.docs.where((documentSnapshot) {
              var searchQuery = widget.destination.toLowerCase();
              var city = documentSnapshot['cityName'].toString().toLowerCase();
              return city.contains(searchQuery);
            }).toList();
            if (data.isEmpty) {
              return const Center(
                child: Text(
                  "HOTEL NOT FOUND!",
                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 22),
                ),
              );
            }

            return SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.only(top: mq.size.height * 0.02),
                child: ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: data.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 12),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => HotelDetails(
                                      check_In: widget.check_In,
                                      check_Out: widget.check_Out,
                                      child: widget.child,
                                      room: widget.room,
                                      adults: widget.adults,
                                      id: data[index].id,
                                      hotel: Hotel(
                                          facilities: data[index]["facilities"],
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
                                              ["traveltimetoairport"])),
                                ));
                          },
                          child: Container(
                            width: mq.size.width,
                            color: themeState.getDarkTheme
                                ? const Color(0xff212121)
                                : const Color(0xffffffff),
                            // elevation: 5,
                            //  shape: RoundedRectangleBorder(
                            //    borderRadius: BorderRadius.circular(10)),
                            child: Padding(
                              padding: EdgeInsets.all(mq.size.width * 0.026),
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
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Expanded(
                                        child: Column(
                                          children: <Widget>[
                                            Padding(
                                              padding: EdgeInsets.symmetric(
                                                  vertical:
                                                      mq.size.width * 0.023),
                                              child: Row(
                                                children: [
                                                  Titletext(
                                                      title: data[index]
                                                          ["name"]),
                                                  Spacer(),
                                                  StreamBuilder(
                                                      stream: FirebaseFirestore
                                                          .instance
                                                          .collection(
                                                              "Favoritehotel")
                                                          .doc(FirebaseAuth
                                                              .instance
                                                              .currentUser!
                                                              .uid)
                                                          .collection("hotels")
                                                          .where("fid",
                                                              isEqualTo:
                                                                  data[index]
                                                                      .id)
                                                          .snapshots(),
                                                      builder: (context,
                                                          AsyncSnapshot<
                                                                  QuerySnapshot>
                                                              snapshot) {
                                                        if (snapshot.data ==
                                                            null) {
                                                          return const Text("");
                                                        }
                                                        return InkWell(
                                                            onTap: () {
                                                              print(data[index]
                                                                  .id);

                                                              snapshot
                                                                          .data!
                                                                          .docs
                                                                          .length ==
                                                                      0
                                                                  ? addToFavorite(
                                                                      data[index]
                                                                          [
                                                                          "id"])
                                                                  : removFavorite(
                                                                      data[index]
                                                                          ["id"]);
                                                            },
                                                            child: Icon(
                                                              snapshot
                                                                          .data!
                                                                          .docs
                                                                          .length ==
                                                                      0
                                                                  ? Icons
                                                                      .favorite_outline
                                                                  : Icons
                                                                      .favorite,
                                                              color: snapshot
                                                                          .data!
                                                                          .docs
                                                                          .length ==
                                                                      0
                                                                  ? color
                                                                  : Colors.red,
                                                            ));
                                                      })
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
                                                  Icons.location_on_outlined,
                                                  color: themeState.getDarkTheme
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
                                                              .withOpacity(0.75)
                                                          : Colors.black
                                                              .withOpacity(
                                                                  0.6)),
                                                ),
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                Spacer(),
                                                Padding(
                                                  padding: EdgeInsets.only(
                                                      top: mq.size.width *
                                                          0.023,
                                                      bottom:
                                                          mq.size.width * 0.03 -
                                                              mq.size.width *
                                                                  0.021),
                                                  child: Text(
                                                    "${widget.room} Hotel rooms : ${widget.room} bed",
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
                                                      bottom:
                                                          mq.size.width * 0.03 -
                                                              mq.size.width *
                                                                  0.023),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment.end,
                                                    children: [
                                                      Text(
                                                          "Price for 1 night, 1 adult",
                                                          style: TextStyle(
                                                              fontSize: 13,
                                                              color: themeState
                                                                      .getDarkTheme
                                                                  ? Colors.white
                                                                  : Colors
                                                                      .black,
                                                              //  fontWeight: FontWeight.w500,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500)),
                                                      SizedBox(
                                                        height: 2,
                                                      ),
                                                      Text(
                                                        "₹${data[index]["price"]}",
                                                        style: TextStyle(
                                                            color: themeState
                                                                    .getDarkTheme
                                                                ? Colors.white
                                                                : Colors.black,
                                                            fontWeight:
                                                                FontWeight.w500,
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
                    }),
              ),
            );
          }),
    );
  }
}