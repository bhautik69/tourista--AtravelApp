// ignore_for_file: avoid_function_literals_in_foreach_calls, prefer_is_empty, prefer_interpolation_to_compose_strings

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demo/Screen/Navigationpages/home/details.dart';

import 'package:demo/Screen/Navigationpages/main_page.dart';
import 'package:demo/models/packagemodel.dart';
import 'package:demo/widget/button.dart';
import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../../provider/dark_theme_provider.dart';
import '../../../widget/textwidget.dart';

// ignore: must_be_immutable
class Saved extends StatefulWidget {
  const Saved({super.key});

  @override
  State<Saved> createState() => _SavedState();
}

class _SavedState extends State<Saved> {
  removFavorite(String id) async {
    CollectionReference collectionReference =
        FirebaseFirestore.instance.collection("favorite");
    await collectionReference
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection("items")
        .doc(id)
        .delete();
    setState(() {});
  }

  /*addToFavorite() async {
    CollectionReference collectionReference =
        FirebaseFirestore.instance.collection("favorite");
    await collectionReference
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection("items")
        .add({"pid": allPackage.first.id});
  }*/
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
        .collection('favorite')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('items')
        .get();

    items.docs.forEach((item) {
      final pid = item['pid'];

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

  @override
  void initState() {
    super.initState();
    initData();
  }

  Future<void> initData() async {
    await getid();
    //await deleteUnusedItems();
  }

  @override
  Widget build(BuildContext context) {
    var mq = MediaQuery.of(context);
    final themeState = Provider.of<DarkThemeProvider>(context);
    Color color = themeState.getDarkTheme ? Colors.white : Colors.black;

    return Scaffold(
        appBar: AppBar(
          title: const Text("My Wishlist "),
        ),
        body: NotificationListener(
          onNotification: (OverscrollIndicatorNotification overscroll) {
            overscroll.disallowIndicator();
            return true;
          },
          child: SingleChildScrollView(
            child: Column(children: [
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
                          .collection("favorite")
                          .doc(FirebaseAuth.instance.currentUser!.uid)
                          .collection("items")
                          .snapshots(),
                      builder: (context, snapshot) {
                        if (!snapshot.hasData) {
                          return Center(
                              child: Column(
                            children: [
                              SizedBox(
                                height: mq.size.height * 0.382,
                              ),
                              const CircularProgressIndicator(
                                color: Color(0xff0078aa),
                              ),
                            ],
                          ));
                        }
                        if (snapshot.data!.docs.isEmpty) {
                          return Padding(
                            padding: const EdgeInsets.all(16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              // mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(height: mq.size.height * 0.09),
                                SizedBox(
                                  height: 28.h,
                                  width: 28.h,
                                  child: Image.asset(
                                    "assets/img/favorite.png",
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                SizedBox(
                                  height: mq.size.height * 0.008,
                                ),
                                const Text(
                                  "Compare properties easily in a list",
                                  textAlign: TextAlign.center,
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
                                    "Just tap the heart icon in your search and choose a list.",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w400,
                                        color: themeState.getDarkTheme
                                            ? Colors.white
                                            : Colors.black),
                                  ),
                                ),
                                SizedBox(
                                  height: 5.h,
                                ),
                                SizedBox(
                                  height: 52,
                                  child: commenButton(
                                      title: "Start searching",
                                      callback: () {
                                        Navigator.pushReplacement(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>  Mainpage(),
                                            ));
                                      }),
                                )
                              ],
                            ),
                          );
                        }
                        final data = snapshot.data!.docs;
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
                                          id: data[index].id,
                                          package: Package(
                                            latitude: data[index]
                                                  ["latitude"],
                                                  longitude:data[index]["longitude"] ,
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
                                              hotelImg: data[index]["hotelImg"],
                                              hotelAdd: data[index]["hotelAdd"],
                                              hotelPhone: data[index]
                                                  ["hotelPhone"],
                                              hotelRate: data[index]
                                                  ["hotelRate"],
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
                                },
                                child: Card(
                                  elevation: 3,
                                  child: Container(
                                    decoration: BoxDecoration(
                                        color: themeState.getDarkTheme
                                            ? const Color(0xff212121)
                                            : const Color(0xffffffff),
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(6))),
                                    width: mq.size.width,
                                    height: mq.size.height * 0.4,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 10),
                                            child: Row(
                                              children: [
                                                Titletext(
                                                    title: data[index]
                                                        ["traveligTo"]),
                                                const Spacer(),
                                                StreamBuilder(
                                                    stream: FirebaseFirestore
                                                        .instance
                                                        .collection("favorite")
                                                        .doc(FirebaseAuth
                                                            .instance
                                                            .currentUser!
                                                            .uid)
                                                        .collection("items")
                                                        .where("pid",
                                                          isEqualTo:
                                                                data[index].id)
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
                                                            removFavorite(
                                                                data[index].id);

                                                            setState(() {});
                                                          },
                                                          child: Icon(
                                                            snapshot.data!.docs
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
                                          SizedBox(
                                              height: mq.size.width * 0.45,
                                              width: double.infinity,
                                              child: FancyShimmerImage(
                                                imageUrl: data[index]["imgUrl"],
                                              )),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                              top: 10,
                                            ),
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
                                            padding:
                                                const EdgeInsets.only(left: 1),
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
                                                        "₹" +
                                                            data[index]
                                                                ["price"],
                                                        style: const TextStyle(
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            fontSize: 20),
                                                      ),
                                                      Text("per person",
                                                          style: TextStyle(
                                                              fontSize: 13,
                                                              color: themeState
                                                                      .getDarkTheme
                                                                  ? Colors
                                                                      .white54
                                                                  : Colors
                                                                      .black54
                                                                      ,
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
                              ),
                            );
                          },
                        );
                      })),
              const SizedBox(
                height: 8,
              ),
            ]),
          ),
        ));
  }
}
