import 'package:card_swiper/card_swiper.dart';
import 'package:demo/Screen/Navigationpages/home/tabbarScreen/Hotel%20Management/bottomsheetdescription.dart';
import 'package:demo/consts/hotelmap.dart';
import 'package:demo/provider/dark_theme_provider.dart';
import 'package:demo/widget/textwidget.dart';
import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';

import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
//import 'package:ionicons/ionicons.dart';
import 'package:ionicons/ionicons.dart';

import 'package:provider/provider.dart';

class HotelDetails extends StatefulWidget {
  const HotelDetails({super.key});

  @override
  State<HotelDetails> createState() => _HotelDetailsState();
}

List<dynamic> placesimage = [
  "https://images.pexels.com/photos/271624/pexels-photo-271624.jpeg?auto=compress&cs=tinysrgb&w=600",
  "https://images.pexels.com/photos/189296/pexels-photo-189296.jpeg?auto=compress&cs=tinysrgb&w=600",
  "https://images.pexels.com/photos/262047/pexels-photo-262047.jpeg?auto=compress&cs=tinysrgb&w=600",
  "https://images.pexels.com/photos/189296/pexels-photo-189296.jpeg?auto=compress&cs=tinysrgb&w=600",
  "https://images.pexels.com/photos/189296/pexels-photo-189296.jpeg?auto=compress&cs=tinysrgb&w=600"
];
String description =
    "A story is a great way to get your kids engaged. Probably one of the clearest memories of your childhood is that of the stories you read as a childMost of the stories of your childhood were probably stories with morals. These are not the kind of stories we see very often these days. Wouldn’t it be amazing to share these stories with your child? Why not start with this list that we have put together for you";

class _HotelDetailsState extends State<HotelDetails> {
  @override
  Widget build(BuildContext context) {
    var mq = MediaQuery.of(context);
    final themeState = Provider.of<DarkThemeProvider>(context);
    return Scaffold(
      backgroundColor: themeState.getDarkTheme
          ? const Color(0xff121212)
          : const Color.fromARGB(255, 236, 235, 235),
      body: Column(
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
                        Container(
                          color: themeState.getDarkTheme
                              ? const Color(0xff212121)
                              : const Color(0xffffffff),
                          child: Flexible(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
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
                                        const Titletext(title: "Hotel Name")
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
                                                        color: Colors.white,
                                                        activeColor:
                                                            Color(0xff0078aa))),
                                            //control: SwiperControl(),
                                            autoplay: true,
                                            itemBuilder: (context, index) {
                                              return FancyShimmerImage(
                                                  imageUrl: placesimage[index]);
                                            },
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: mq.size.height * 0.02,
                                      ),
                                      SingleChildScrollView(
                                        scrollDirection: Axis.horizontal,
                                        child: Row(
                                          children: [
                                            Column(
                                              children: [
                                                CircleAvatar(
                                                  backgroundColor: Colors.grey
                                                      .withOpacity(0.17),
                                                  child: Icon(
                                                    Ionicons.wifi_outline,
                                                    color:
                                                        themeState.getDarkTheme
                                                            ? Colors.white
                                                            : Colors.black,
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: mq.size.height * 0.02,
                                                ),
                                                const Text(
                                                  "Free Wi-Fi",
                                                  style: TextStyle(
                                                      fontSize: 11,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                )
                                              ],
                                            ),
                                            SizedBox(
                                              width: mq.size.height * 0.025,
                                            ),
                                            Column(
                                              children: [
                                                CircleAvatar(
                                                    backgroundColor: Colors.grey
                                                        .withOpacity(0.17),
                                                    child: Icon(
                                                      Ionicons.bed_outline,
                                                      color: themeState
                                                              .getDarkTheme
                                                          ? Colors.white
                                                          : Colors.black,
                                                    )),
                                                SizedBox(
                                                  height: mq.size.height * 0.02,
                                                ),
                                                const Text(
                                                  "21 beds",
                                                  style: TextStyle(
                                                      fontSize: 11,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                )
                                              ],
                                            ),
                                            SizedBox(
                                              width: mq.size.height * 0.025,
                                            ),
                                            Column(
                                              children: [
                                                CircleAvatar(
                                                    backgroundColor: Colors.grey
                                                        .withOpacity(0.17),
                                                    child: Icon(
                                                      Ionicons.rose_outline,
                                                      color: themeState
                                                              .getDarkTheme
                                                          ? Colors.white
                                                          : Colors.black,
                                                    )),
                                                SizedBox(
                                                  height: mq.size.height * 0.02,
                                                ),
                                                const Text(
                                                  "Garden",
                                                  style: TextStyle(
                                                      fontSize: 11,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                )
                                              ],
                                            ),
                                            SizedBox(
                                              width: mq.size.height * 0.025,
                                            ),
                                            Column(
                                              children: [
                                                CircleAvatar(
                                                    backgroundColor: Colors.grey
                                                        .withOpacity(0.17),
                                                    child: Icon(
                                                      Icons
                                                          .meeting_room_outlined,
                                                      color: themeState
                                                              .getDarkTheme
                                                          ? Colors.white
                                                          : Colors.black,
                                                    )),
                                                SizedBox(
                                                  height: mq.size.height * 0.02,
                                                ),
                                                const Text(
                                                  "2 bedrooms",
                                                  style: TextStyle(
                                                      fontSize: 11,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                )
                                              ],
                                            ),
                                            SizedBox(
                                              width: mq.size.height * 0.025,
                                            ),
                                            Column(
                                              children: [
                                                CircleAvatar(
                                                    backgroundColor: Colors.grey
                                                        .withOpacity(0.17),
                                                    child: Icon(
                                                      Icons.restaurant_outlined,
                                                      color: themeState
                                                              .getDarkTheme
                                                          ? Colors.white
                                                          : Colors.black,
                                                    )),
                                                SizedBox(
                                                  height: mq.size.height * 0.02,
                                                ),
                                                const Text(
                                                  "Kitchen",
                                                  style: TextStyle(
                                                      fontSize: 11,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                )
                                              ],
                                            ),
                                            SizedBox(
                                              width: mq.size.height * 0.025,
                                            ),
                                            Column(
                                              children: [
                                                CircleAvatar(
                                                    backgroundColor: Colors.grey
                                                        .withOpacity(0.17),
                                                    child: Icon(
                                                      Icons
                                                          .local_parking_outlined,
                                                      color: themeState
                                                              .getDarkTheme
                                                          ? Colors.white
                                                          : Colors.black,
                                                    )),
                                                SizedBox(
                                                  height: mq.size.height * 0.02,
                                                ),
                                                const Text(
                                                  "Parking",
                                                  style: TextStyle(
                                                      fontSize: 11,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                )
                                              ],
                                            ),
                                            SizedBox(
                                              width: mq.size.height * 0.025,
                                            ),
                                            Column(
                                              children: [
                                                CircleAvatar(
                                                    backgroundColor: Colors.grey
                                                        .withOpacity(0.17),
                                                    child: Icon(
                                                      Icons.bathtub_outlined,
                                                      color: themeState
                                                              .getDarkTheme
                                                          ? Colors.white
                                                          : Colors.black,
                                                    )),
                                                SizedBox(
                                                  height: mq.size.height * 0.02,
                                                ),
                                                const Text(
                                                  "Private bathroom",
                                                  style: TextStyle(
                                                      fontSize: 11,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                )
                                              ],
                                            ),
                                            SizedBox(
                                              width: mq.size.height * 0.025,
                                            ),
                                            Column(
                                              children: [
                                                CircleAvatar(
                                                    backgroundColor: Colors.grey
                                                        .withOpacity(0.17),
                                                    child: Icon(
                                                      Ionicons.paw_outline,
                                                      color: themeState
                                                              .getDarkTheme
                                                          ? Colors.white
                                                          : Colors.black,
                                                    )),
                                                SizedBox(
                                                  height: mq.size.height * 0.02,
                                                ),
                                                const Text(
                                                  "Pets allowed",
                                                  style: TextStyle(
                                                      fontSize: 11,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                )
                                              ],
                                            ),
                                            SizedBox(
                                              width: mq.size.height * 0.025,
                                            ),
                                            Column(
                                              children: [
                                                CircleAvatar(
                                                    backgroundColor: Colors.grey
                                                        .withOpacity(0.17),
                                                    child: Image.asset(
                                                      "assets/img/swimming.png",
                                                      scale: 20,
                                                      color: themeState
                                                              .getDarkTheme
                                                          ? Colors.white
                                                          : Colors.black,
                                                    )),
                                                SizedBox(
                                                  height: mq.size.height * 0.02,
                                                ),
                                                const Text(
                                                  "Swimming pool",
                                                  style: TextStyle(
                                                      fontSize: 11,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                )
                                              ],
                                            ),
                                            SizedBox(
                                              width: mq.size.height * 0.025,
                                            ),
                                            Column(
                                              children: [
                                                CircleAvatar(
                                                    backgroundColor: Colors.grey
                                                        .withOpacity(0.17),
                                                    child: Icon(
                                                      Ionicons.wine_outline,
                                                      color: themeState
                                                              .getDarkTheme
                                                          ? Colors.white
                                                          : Colors.black,
                                                    )),
                                                SizedBox(
                                                  height: mq.size.height * 0.02,
                                                ),
                                                const Text(
                                                  "Bar",
                                                  style: TextStyle(
                                                      fontSize: 11,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                )
                                              ],
                                            ),
                                            SizedBox(
                                              width: mq.size.height * 0.025,
                                            ),
                                            Column(
                                              children: [
                                                CircleAvatar(
                                                    backgroundColor: Colors.grey
                                                        .withOpacity(0.17),
                                                    child: Icon(
                                                      Icons.lock_outline,
                                                      color: themeState
                                                              .getDarkTheme
                                                          ? Colors.white
                                                          : Colors.black,
                                                    )),
                                                SizedBox(
                                                  height: mq.size.height * 0.02,
                                                ),
                                                const Text(
                                                  "Safety",
                                                  style: TextStyle(
                                                      fontSize: 11,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                )
                                              ],
                                            ),
                                            SizedBox(
                                              width: mq.size.height * 0.025,
                                            ),
                                            Column(
                                              children: [
                                                CircleAvatar(
                                                    backgroundColor: Colors.grey
                                                        .withOpacity(0.17),
                                                    child: Icon(
                                                      Icons
                                                          .room_service_outlined,
                                                      color: themeState
                                                              .getDarkTheme
                                                          ? Colors.white
                                                          : Colors.black,
                                                    )),
                                                SizedBox(
                                                  height: mq.size.height * 0.02,
                                                ),
                                                const Text(
                                                  "Room service",
                                                  style: TextStyle(
                                                      fontSize: 11,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                )
                                              ],
                                            ),
                                            SizedBox(
                                              width: mq.size.height * 0.025,
                                            ),
                                            Column(
                                              children: [
                                                CircleAvatar(
                                                    backgroundColor: Colors.grey
                                                        .withOpacity(0.17),
                                                    child: Icon(
                                                      Icons
                                                          .family_restroom_outlined,
                                                      color: themeState
                                                              .getDarkTheme
                                                          ? Colors.white
                                                          : Colors.black,
                                                    )),
                                                SizedBox(
                                                  height: mq.size.height * 0.02,
                                                ),
                                                const Text(
                                                  "Family rooms",
                                                  style: TextStyle(
                                                      fontSize: 11,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                )
                                              ],
                                            ),
                                            SizedBox(
                                              width: mq.size.height * 0.025,
                                            ),
                                            Column(
                                              children: [
                                                CircleAvatar(
                                                    backgroundColor: Colors.grey
                                                        .withOpacity(0.17),
                                                    child: Icon(
                                                      Icons
                                                          .flight_land_outlined,
                                                      color: themeState
                                                              .getDarkTheme
                                                          ? Colors.white
                                                          : Colors.black,
                                                    )),
                                                SizedBox(
                                                  height: mq.size.height * 0.02,
                                                ),
                                                const Text(
                                                  "Airport transfer",
                                                  style: TextStyle(
                                                      fontSize: 11,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                )
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        height: mq.size.height * 0.02,
                                      ),
                                    ],
                                  ),
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
                                horizontal: 12, vertical: 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Titletext(
                                          title: "Check-in",
                                          size: 15,
                                        ),
                                        Text("29-2-2024")
                                      ],
                                    ),
                                    SizedBox(
                                      width: mq.size.width * 0.28,
                                    ),
                                    const Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Titletext(
                                          title: "Check-out",
                                          size: 15,
                                        ),
                                        Text("1-3-2024")
                                      ],
                                    )
                                  ],
                                ),
                                SizedBox(
                                  height: mq.size.height * 0.015,
                                ),
                                const Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Titletext(
                                      title: "Rooms and guests",
                                      size: 15,
                                    ),
                                    Text(
                                      "6 rooms, 10 adults, 2 children",
                                      style: TextStyle(
                                          //    color: Color(0xff0078aa),
                                          //  fontWeight: FontWeight.bold
                                          ),
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
                                horizontal: 12, vertical: 12),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Titletext(
                                  size: 18,
                                  title: "Property location",
                                  //  size: 18,
                                ),
                                SizedBox(
                                  height: mq.size.height * 0.025,
                                ),
                                InkWell(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => Hotelmaps(
                                            latitude: "26.863592",
                                            longitude: "75.795826",
                                            hotelname: "surat marriott hotel",
                                            add:
                                                "ADAJAN, PAL, BESIDE SUMER 370, 395009 Surat, India",
                                            imges: placesimage[1],
                                          ),
                                        ));
                                  },
                                  child: ClipRRect(
                                      borderRadius: BorderRadius.circular(7),
                                      child: Image.asset("assets/img/map.jpg")),
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                                const Text(
                                    "Located along Tapti River, Surat Marriott Hotel features an outdoor pool, spa and gym, ADAJAN, PAL, BESIDE SUMER 370, 395009 Surat, India")
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
                                horizontal: 12, vertical: 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Titletext(
                                    size: 18, title: "Resort description"),
                                SizedBox(
                                  height: mq.size.height * 0.02,
                                ),
                                SizedBox(
                                  height: 65,
                                  child: Text(description),
                                ),
                                SizedBox(
                                  height: mq.size.height * 0.02,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    showModalBottomSheet(
                                      context: context,
                                      shape: const RoundedRectangleBorder(
                                          borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(20),
                                              topRight: Radius.circular(20))),
                                      builder: (context) =>
                                          Description(description: description),
                                    );
                                  },
                                  child: const Text(
                                    "Read full description",
                                    style: TextStyle(
                                        color: Colors.blue,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                  ),
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
                                horizontal: 12, vertical: 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Titletext(
                                  title: "Languages spoken",
                                  size: 18,
                                ),
                                SizedBox(
                                  height: mq.size.height * 0.02,
                                ),
                                Row(
                                  children: [
                                    Row(
                                      children: [
                                        Image.asset(
                                          "assets/img/unitedkingdom.png",
                                          scale: 20,
                                        ),
                                        const Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 15),
                                          child: Text(
                                            "English",
                                            style: TextStyle(fontSize: 16),
                                          ),
                                        )
                                      ],
                                    ),
                                    SizedBox(
                                      width: mq.size.width * 0.2,
                                    ),
                                    Row(
                                      children: [
                                        Image.asset(
                                          "assets/img/india.png",
                                          scale: 20,
                                        ),
                                        const Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 15),
                                          child: Text("Hindi",
                                              style: TextStyle(fontSize: 16)),
                                        )
                                      ],
                                    ),
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
                                horizontal: 12, vertical: 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Titletext(
                                  title: "Highlights",
                                  size: 18,
                                ),
                                SizedBox(
                                  height: mq.size.height * 0.02,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    showModalBottomSheet(
                                      context: context,
                                      shape: const RoundedRectangleBorder(
                                          borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(20),
                                              topRight: Radius.circular(20))),
                                      builder: (context) => const Great(),
                                    );
                                  },
                                  child: Row(
                                    children: [
                                      const Icon(
                                        Icons.thumb_up_alt,
                                        color: Color(0xff0078aa),
                                        size: 20,
                                      ),
                                      const Padding(
                                        padding:
                                            EdgeInsets.only(left: 15, right: 1),
                                        child: Text(
                                          "Great for activities",
                                          style: TextStyle(fontSize: 15),
                                        ),
                                      ),
                                      Icon(
                                        Icons.report_sharp,
                                        color: themeState.getDarkTheme
                                            ? Colors.white
                                            : Colors.black,
                                        size: 16,
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: mq.size.height * 0.009,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    showModalBottomSheet(
                                      context: context,
                                      shape: const RoundedRectangleBorder(
                                          borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(20),
                                              topRight: Radius.circular(20))),
                                      builder: (context) => const Hygiene(),
                                    );
                                  },
                                  child: Row(
                                    children: [
                                      const Icon(
                                        Icons.add_moderator,
                                        color: Color(0xff0078aa),
                                        size: 19,
                                      ),
                                      const Padding(
                                        padding:
                                            EdgeInsets.only(left: 15, right: 1),
                                        child: Text("Hygiene Plus",
                                            style: TextStyle(fontSize: 15)),
                                      ),
                                      Icon(
                                        Icons.report_sharp,
                                        color: themeState.getDarkTheme
                                            ? Colors.white
                                            : Colors.black,
                                        size: 16,
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: mq.size.height * 0.009,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    showModalBottomSheet(
                                      context: context,
                                      shape: const RoundedRectangleBorder(
                                          borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(20),
                                              topRight: Radius.circular(20))),
                                      builder: (context) => Airport(
                                          fee: 1300, distance: 12, time: 60),
                                    );
                                  },
                                  child: Row(
                                    children: [
                                      const Icon(
                                        Icons.flight_land,
                                        color: Color(0xff0078aa),
                                        size: 20,
                                      ),
                                      const Padding(
                                        padding:
                                            EdgeInsets.only(left: 15, right: 1),
                                        child: Text("Airport transfer",
                                            style: TextStyle(fontSize: 15)),
                                      ),
                                      Icon(
                                        Icons.report_sharp,
                                        color: themeState.getDarkTheme
                                            ? Colors.white
                                            : Colors.black,
                                        size: 16,
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: mq.size.height * 0.009,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    showModalBottomSheet(
                                      context: context,
                                      shape: const RoundedRectangleBorder(
                                          borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(20),
                                              topRight: Radius.circular(20))),
                                      builder: (context) => Checkin(
                                          checkinfrom: "02:00 PM",
                                          checkinuntil: "11:00 AM",
                                          checkout: "11:00 AM"),
                                    );
                                  },
                                  child: Row(
                                    children: [
                                      const Icon(
                                        Icons.meeting_room_rounded,
                                        color: Color(0xff0078aa),
                                        size: 20,
                                      ),
                                      const Padding(
                                        padding:
                                            EdgeInsets.only(left: 15, right: 1),
                                        child: Text("Check-in [24-hour]",
                                            style: TextStyle(fontSize: 15)),
                                      ),
                                      Icon(
                                        Icons.report_sharp,
                                        color: themeState.getDarkTheme
                                            ? Colors.white
                                            : Colors.black,
                                        size: 16,
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: mq.size.height * 0.014,
                        ),
                      ],
                    ),
                  ))),
        ],
      ),
    );
  }
}
