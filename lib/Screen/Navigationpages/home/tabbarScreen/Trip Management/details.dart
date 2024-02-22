// ignore_for_file: empty_statements

import 'package:card_swiper/card_swiper.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demo/Screen/Navigationpages/home/tabbarScreen/Trip%20Management/booking.dart';
import 'package:demo/Screen/Navigationpages/main_page.dart';
import 'package:demo/consts/hotelmap.dart';
import 'package:demo/models/bookingmodel.dart';
import 'package:demo/models/packagemodel.dart';
import 'package:demo/widget/button.dart';
import 'package:demo/widget/textwidget.dart';
import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:provider/provider.dart';

import '../../../../../provider/dark_theme_provider.dart';
import '../../../../../widget/details.dart';

// ignore: must_be_immutable
class PlaceDetails extends StatefulWidget {
  String? id;
  Package? package;
  PlaceDetails({super.key, required this.id, required this.package});

  @override
  State<PlaceDetails> createState() => _PlaceDetailsState();
}

class _PlaceDetailsState extends State<PlaceDetails> {
  List<dynamic> placesimage = [];

  @override
  void initState() {
    super.initState();
    getimg();
  }

  void getimg() async {
    placesimage.add(widget.package!.img1);
    placesimage.add(widget.package!.img2);
    placesimage.add(widget.package!.img3);
    placesimage.add(widget.package!.img4);
  }

  @override
  Widget build(BuildContext context) {
    var mq = MediaQuery.of(context);
    final themeState = Provider.of<DarkThemeProvider>(context);
    return SafeArea(
      child: Scaffold(
        /*appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
        ),*/
        body: placesimage.isEmpty
            ? const Center(
                child: CircularProgressIndicator(
                  color: Color(0xff0078aa),
                ),
              )
            : Column(
                children: [
                  Expanded(
                    child: NotificationListener(
                      onNotification: (OverscrollIndicatorNotification
                          overscrollIndicatorNotification) {
                        overscrollIndicatorNotification.disallowIndicator();
                        return true;
                      },
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Card(
                              elevation: 2.5,
                              child: Flexible(
                                child: Container(
                                  color: themeState.getDarkTheme
                                      ? const Color(0xff212121)
                                      : const Color(0xffffffff),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                          height: mq.size.height * 0.085,
                                          child: Row(
                                            children: [
                                              IconButton(
                                                  onPressed: () {
                                                    Navigator.pop(context);
                                                  },
                                                  icon: const Icon(
                                                    IconlyLight.arrow_left_2,
                                                  )),
                                              const SizedBox(
                                                width: 10,
                                              ),
                                              Titletext(
                                                  title: widget
                                                      .package!.traveligTo!)
                                            ],
                                          )),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 12,
                                        ),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            SizedBox(
                                              height: mq.size.height * 0.28,
                                              child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(15),
                                                child: Swiper(
                                                  itemCount: placesimage.length,
                                                  pagination: const SwiperPagination(
                                                      alignment: Alignment
                                                          .bottomCenter,
                                                      builder:
                                                          DotSwiperPaginationBuilder(
                                                              size: 7,
                                                              activeSize: 7,
                                                              color:
                                                                  Colors.white,
                                                              activeColor: Color(
                                                                  0xff0078aa))),
                                                  //control: SwiperControl(),
                                                  autoplay: true,
                                                  itemBuilder:
                                                      (context, index) {
                                                    return FancyShimmerImage(
                                                        imageUrl:
                                                            placesimage[index]);
                                                  },
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                top: 20,
                                              ),
                                              child: Titletext(
                                                title:
                                                    "Amazing ${widget.package!.traveligTo!} Trip",
                                                size: 19,
                                              ),
                                            ),
                                            SizedBox(
                                              height: mq.size.height * 0.01,
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 15),
                                              child: Align(
                                                alignment: Alignment.center,
                                                child: Container(
                                                  alignment: Alignment.center,
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              13),
                                                      border: Border.all(
                                                          width: 1,
                                                          //color: themeState.getDarkTheme
                                                          //  ? Colors.white
                                                          //: Colors.black
                                                          color: const Color(
                                                              0xff0078aa))),
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            12),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      children: [
                                                        Text(
                                                          "${widget.package!.startingForm!} To ${widget.package!.traveligTo!}",
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              color: themeState
                                                                      .getDarkTheme
                                                                  ? Colors.white
                                                                  : Colors
                                                                      .black,
                                                              fontSize: 17),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 10, bottom: 10),
                                              child: Text(
                                                widget.package!.decs!,
                                                style: TextStyle(
                                                    color: themeState
                                                            .getDarkTheme
                                                        ? Colors.white
                                                            .withOpacity(0.7)
                                                        : Colors.black
                                                            .withOpacity(0.7)),
                                              ),
                                            ),
                                            SizedBox(
                                              height: mq.size.height * 0.025,
                                            )
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: mq.size.height * 0.01,
                            ),
                            Card(
                              elevation: 2.5,
                              color: themeState.getDarkTheme
                                  ? const Color(0xff212121)
                                  : const Color(0xffffffff),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 12, vertical: 5),
                                child: fligth(
                                    context: context,
                                    title:
                                        "Arrival in ${widget.package!.traveligTo!} via fligth",
                                    flgthtime: widget.package!.flightTime!,
                                    reachtime: widget.package!.reachTime!,
                                    fligthdate: widget.package!.flightDate!,
                                    rechdate: widget.package!.reachDate!,
                                    to: widget.package!.traveligTo!,
                                    from: widget.package!.startingForm!),
                              ),
                            ),
                            SizedBox(
                              height: mq.size.height * 0.01,
                            ),
                            Card(
                              elevation: 2.5,
                              color: themeState.getDarkTheme
                                  ? const Color(0xff212121)
                                  : const Color(0xffffffff),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 12, vertical: 5),
                                child: hotel(
                                    showMap: () {
                                      setState(() {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) => Hotelmaps(
                                                latitude:
                                                    widget.package!.latitude,
                                                longitude:
                                                    widget.package!.longitude,
                                                hotelname:
                                                    widget.package!.hotelName!,
                                                add: widget.package!.hotelAdd!,
                                                imges:
                                                    widget.package!.hotelImg!,
                                              ),
                                            ));
                                      });
                                    },
                                    viewDetails: () {},
                                    context: context,
                                    to: widget.package!.traveligTo!,
                                    hotelname: widget.package!.hotelName!,
                                    img: widget.package!.hotelImg!,
                                    phone: widget.package!.hotelPhone!,
                                    address: widget.package!.hotelAdd!,
                                    rating: widget.package!.hotelRate!),
                              ),
                            ),
                            SizedBox(
                              height: mq.size.height * 0.01,
                            ),
                            Card(
                              elevation: 2.5,
                              color: themeState.getDarkTheme
                                  ? const Color(0xff212121)
                                  : const Color(0xffffffff),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 12, vertical: 5),
                                child: activity(
                                    context: context,
                                    to: widget.package!.traveligTo!,
                                    allactivity: widget.package!.ActivityList!),
                              ),
                            ),
                            SizedBox(
                              height: mq.size.height * 0.01,
                            ),
                            Card(
                              elevation: 2.5,
                              color: themeState.getDarkTheme
                                  ? const Color(0xff212121)
                                  : const Color(0xffffffff),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 12, vertical: 5),
                                child: returnfligth(
                                    context: context,
                                    form: widget.package!.startingForm!,
                                    to: widget.package!.traveligTo!,
                                    flgthtime: widget.package!.retunfligthtime!,
                                    reachtime:
                                        widget.package!.retunreachfligthtime!,
                                    fligthdate:
                                        widget.package!.retunfligthdate!,
                                    rechdate:
                                        widget.package!.retunreachfligthdate!),
                              ),
                            ),
                          ],
                        ),
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
                                Titletext(title: "₹${widget.package!.price!}"),
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
                                height: mq.size.height * 0.065,
                                child: StreamBuilder(
                                    stream: FirebaseFirestore.instance
                                        .collection("booking")
                                        .doc(FirebaseAuth
                                            .instance.currentUser!.uid)
                                        .collection("bookingPkg")
                                        .where("id", isEqualTo: widget.id)
                                        .snapshots(),
                                    builder: (context,
                                        AsyncSnapshot<QuerySnapshot> snapshot) {
                                      if (snapshot.data == null) {
                                        return const Text("");
                                      }
                                      return commenButton(
                                          title: snapshot.data!.docs.isEmpty
                                              ? "Book Now"
                                              : "CANCEL BOOKING",
                                          callback: () {
                                            snapshot.data!.docs.isEmpty
                                                ? book(context)
                                                : showDialog(
                                                    context: context,
                                                    builder: (context) {
                                                      return AlertDialog(
                                                          title: const Text(
                                                            "Cancel Booking",
                                                            style: TextStyle(
                                                                fontSize: 18),
                                                          ),
                                                          content: const Text(
                                                              style: TextStyle(
                                                                  fontSize: 15),
                                                              "Are you sure you want do cancel trip ?"),
                                                          actions: [
                                                            TextButton(
                                                                onPressed: () {
                                                                  Navigator.pop(
                                                                      context);
                                                                },
                                                                child: const Text(
                                                                    "CANCEL")),
                                                            TextButton(
                                                                onPressed: () {
                                                                  setState(() {
                                                                    themeState
                                                                            .setDarkTheme =
                                                                        false;
                                                                  });
                                                                  cancelBook(
                                                                      widget
                                                                          .id!);
                                                                  Navigator.pop(
                                                                      context);
                                                                },
                                                                child: const Text(
                                                                    "PROCEED")),
                                                          ],
                                                          contentPadding:
                                                              const EdgeInsets
                                                                  .only(
                                                                  top: 20,
                                                                  left: 25,
                                                                  right: 25));
                                                    },
                                                  );
                                            ;
                                          });
                                    }))
                          ]),
                        ),
                      ],
                    ),
                  )
                ],
              ),
      ),
    );
  }

  void book(BuildContext context) {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => BookingDone(
              id: widget.id!,
              package: Package(
                  latitude: widget.package!.latitude,
                  longitude: widget.package!.longitude,
                  retunfligthdate: widget.package!.retunfligthdate,
                  retunreachfligthdate: widget.package!.retunreachfligthdate,
                  retunfligthtime: widget.package!.retunfligthtime,
                  retunreachfligthtime: widget.package!.retunreachfligthtime,
                  ActivityList: widget.package!.ActivityList,
                  startingForm: widget.package!.startingForm,
                  traveligTo: widget.package!.traveligTo,
                  startDate: widget.package!.startDate,
                  endDate: widget.package!.endDate,
                  imgUrl: widget.package!.imgUrl,
                  decs: widget.package!.decs,
                  price: widget.package!.price,
                  img1: widget.package!.img1,
                  img2: widget.package!.img2,
                  img3: widget.package!.img3,
                  img4: widget.package!.img4,
                  flightDate: widget.package!.flightDate,
                  reachDate: widget.package!.reachDate,
                  flightTime: widget.package!.flightTime,
                  reachTime: widget.package!.reachTime,
                  hotelName: widget.package!.hotelName,
                  hotelImg: widget.package!.hotelImg,
                  hotelAdd: widget.package!.hotelAdd,
                  hotelPhone: widget.package!.hotelPhone,
                  hotelRate: widget.package!.hotelRate)),
        ));
  }

  cancelBook(String id) async {
    await Booking.deleteBookPackage(id);
    // ignore: use_build_context_synchronously
    Navigator.pop(context);

    // ignore: use_build_context_synchronously
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const Mainpage(),
        ));
  }
}
