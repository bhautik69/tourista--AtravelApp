// ignore_for_file: avoid_function_literals_in_foreach_calls, prefer_is_empty, prefer_interpolation_to_compose_strings

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demo/Screen/Navigationpages/home/tabbarScreen/Hotel%20Management/hoteldetails.dart';
import 'package:demo/Screen/Navigationpages/home/tabbarScreen/Trip%20Management/details.dart';

import 'package:demo/Screen/Navigationpages/main_page.dart';
import 'package:demo/models/Hotel%20models/hoteladd.dart';
import 'package:demo/models/Trip%20models/packagemodel.dart';
import 'package:demo/widget/button.dart';
import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
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
  TripremovFavorite(String id) async {
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

 
  List Hotelids = [];
  gethotelid() async {
    FirebaseFirestore.instance
        .collection("Hotel")
        .get()
        .then((QuerySnapshot<Map<String, dynamic>> snapshot) {
      for (var element in snapshot.docs) {
        setState(() {
          Hotelids.add(element['id']);
        });
      }
    });
  }
  deleteUnusedhitelItems() async {
    final items = await FirebaseFirestore.instance
        .collection('Favoritehotel')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('hotels')
        .get();

    items.docs.forEach((item) {
      final fid = item['fid'];

      if (!Hotelids.contains(fid)) {
        // delete unused favorite item
        FirebaseFirestore.instance
            .collection('Favoritehotel')
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .collection('hotels')
            .doc(item.id)
            .delete();
      }
    });
  }

  HotelremovFavorite(String hotelid) async {
    CollectionReference collectionReference =
        FirebaseFirestore.instance.collection("Favoritehotel");
    await collectionReference
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection("hotels")
        .doc(hotelid)
        .delete();
  }

  @override
  void initState() {
    super.initState();
    initData();
    getdata();
  }

  Future<void> initData() async {
    await getid();
    //await deleteUnusedItems();
  }

  bool focus1 = true;
  bool focus2 = false;
  int room = 1;
  int adult = 1;
  int child = 0;
  String check_In = "";
  String check_Out = "";

  getdata() async {
    var store = await SharedPreferences.getInstance();
    var v1 = store.getString("checkInDate");
    var v2 = store.getString("checkOutDate");
    var v3 = store.getInt("room");
    var v4 = store.getInt("adult");
    var v5 = store.getInt("child");

    setState(() {
      check_In = v1!;
      check_Out = v2!;
      room = v3!;
      adult = v4!;
      child = v5!;
    });
  }

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
          title: const Text("My Wishlist "),
        ),
        body: NotificationListener(
          onNotification: (OverscrollIndicatorNotification overscroll) {
            overscroll.disallowIndicator();
            return true;
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    InkWell(
                      onTap: () {
                        setState(() {
                          focus1 = true;
                          focus1 == true ? focus2 = false : focus2 = true;
                        });
                      },
                      child: Container(
                        height: 40,
                        width: 40.w,
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
                          focus2 == true ? focus1 = false : focus1 = true;
                        });
                      },
                      child: Container(
                        height: 40,
                        width: 40.w,
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
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              focus1
                  ? tripwishlist(mq, themeState, color)
                  : hotelwishlist(mq, themeState, color),
            ],
          ),
        ));
  }

  Expanded tripwishlist(
      MediaQueryData mq, DarkThemeProvider themeState, Color color) {
    return Expanded(
      child: SingleChildScrollView(
        child: Column(children: [
          const SizedBox(
            height: 8,
          ),
          StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection("favorite")
                  .doc(FirebaseAuth.instance.currentUser!.uid)
                  .collection("items")
                  .snapshots(),
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
                              fontWeight: FontWeight.w700, fontSize: 25),
                        ),
                        const SizedBox(
                          height: 18,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
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
                                      builder: (context) => const Mainpage(),
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
                                      latitude: data[index]["latitude"],
                                      longitude: data[index]["longitude"],
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
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              color: themeState.getDarkTheme
                                  ? const Color(0xff212121)
                                  : const Color(0xffffffff),
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(6))),
                          width: mq.size.width,
                          height: mq.size.height * 0.4,
                          child: Padding(
                            padding: const EdgeInsets.all(8),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 10),
                                  child: Row(
                                    children: [
                                      Titletext(
                                          title: data[index]["traveligTo"]),
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
                                                  TripremovFavorite(
                                                      data[index].id);

                                                  setState(() {});
                                                },
                                                child: Icon(
                                                  snapshot.data!.docs.length ==
                                                          0
                                                      ? Icons.favorite_outline
                                                      : Icons.favorite,
                                                  color: snapshot.data!.docs
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
                                                  text: data[index]
                                                      ["startingForm"],
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      color: themeState
                                                              .getDarkTheme
                                                          ? Colors.white
                                                              .withOpacity(0.6)
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
                                  padding: const EdgeInsets.only(left: 1),
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
                                                              .withOpacity(0.6)
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
                                              "₹" + data[index]["price"],
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 20),
                                            ),
                                            Text("per person",
                                                style: TextStyle(
                                                    fontSize: 13,
                                                    color:
                                                        themeState.getDarkTheme
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
                      ),
                    );
                  },
                );
              }),
          const SizedBox(
            height: 8,
          ),
        ]),
      ),
    );
  }

  Expanded hotelwishlist(
      MediaQueryData mq, DarkThemeProvider themeState, Color color) {
    return Expanded(
      child: SingleChildScrollView(
        child: Column(children: [
          const SizedBox(
            height: 8,
          ),
          StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection("Favoritehotel")
                  .doc(FirebaseAuth.instance.currentUser!.uid)
                  .collection("hotels")
                  .snapshots(),
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
                              fontWeight: FontWeight.w700, fontSize: 25),
                        ),
                        const SizedBox(
                          height: 18,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
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
                                      builder: (context) => const Mainpage(),
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
                                  builder: (context) => HotelDetails(
                                        adults: adult,
                                        check_In: check_In,
                                        check_Out: check_Out,
                                        child: child,
                                        room: room,
                                        id: data[index].id,
                                        hotel: Hotel(
                                          name: data[index]["name"],
                                          description: data[index]
                                              ["description"],
                                          facilities: data[index]["facilities"],
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
                                              ["traveltimetoairport"],
                                        ),
                                      )));
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
                                        borderRadius: BorderRadius.circular(12),
                                        child: FancyShimmerImage(
                                          imageUrl: data[index]["images"].first,
                                          boxFit: BoxFit.cover,
                                        ))),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
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
                                                    title: data[index]["name"]),
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
                                                            HotelremovFavorite(
                                                                data[index].id);
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
                                                            .withOpacity(0.6)),
                                              ),
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              Spacer(),
                                              Padding(
                                                padding: EdgeInsets.only(
                                                    top: mq.size.width * 0.023,
                                                    bottom: mq.size.width *
                                                            0.03 -
                                                        mq.size.width * 0.021),
                                                child: Text(
                                                  "$room Hotel rooms : $room bed",
                                                  style: TextStyle(
                                                      color: themeState
                                                              .getDarkTheme
                                                          ? Colors.white
                                                              .withOpacity(0.75)
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
                                                    bottom: mq.size.width *
                                                            0.03 -
                                                        mq.size.width * 0.023),
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
                                                                : Colors.black,
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
                  },
                );
              }),
          const SizedBox(
            height: 8,
          ),
        ]),
      ),
    );
  }
}
