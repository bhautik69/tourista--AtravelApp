import 'package:card_swiper/card_swiper.dart';
import 'package:demo/Screen/Navigationpages/home/tabbarScreen/Hotel%20Management/bottomsheetdescription.dart';
import 'package:demo/Screen/Navigationpages/home/tabbarScreen/Hotel%20Management/hotel_user_info.dart';
import 'package:demo/consts/hotelmap.dart';
import 'package:demo/models/Hotel%20models/hoteladd.dart';
import 'package:demo/provider/dark_theme_provider.dart';
import 'package:demo/widget/button.dart';
import 'package:demo/widget/textwidget.dart';
import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:iconly/iconly.dart';
//import 'package:ionicons/ionicons.dart';
import 'package:ionicons/ionicons.dart';

import 'package:provider/provider.dart';

// ignore: must_be_immutable
class HotelDetails extends StatefulWidget {
  String id;
  Hotel hotel;
  String check_In = "";
  String check_Out = "";
  int room = 0;
  int adults = 0;
  int child = 0;

  HotelDetails(
      {super.key,
      required this.hotel,
      required this.id,
      required this.adults,
      required this.room,
      required this.check_In,
      required this.check_Out,
      required this.child});

  @override
  State<HotelDetails> createState() => _HotelDetailsState();
}

class _HotelDetailsState extends State<HotelDetails> {
  final List<Map<String, dynamic>> facilities = [
    {"name": "Free Wi-Fi", "icon": Ionicons.wifi_outline},
    {"name": "Beds", "icon": Ionicons.bed_outline},
    {"name": "Pets Allowed", "icon": Ionicons.paw_outline},
    {"name": "Garden", "icon": Ionicons.rose_outline},
    {"name": "Bedrooms", "icon": Icons.meeting_room_outlined},
    {"name": "Kitchen", "icon": Icons.restaurant_outlined},
    {"name": "Family Rooms", "icon": Icons.family_restroom_outlined},
    {"name": "Parking", "icon": Icons.local_parking_outlined},
    {"name": "Private Bathroom", "icon": Icons.bathtub_outlined},
    {"name": "Swimming Pool", "icon": Icons.pool_outlined},
    {"name": "Bar", "icon": Ionicons.wine_outline},
    {"name": "Airport Transfer", "icon": Icons.flight_land_outlined},
    {"name": "Safety", "icon": Icons.lock_outline},
    {"name": "Room Service", "icon": Icons.room_service_outlined},
  ];
  @override
  Widget build(BuildContext context) {
    var mq = MediaQuery.of(context);
    final themeState = Provider.of<DarkThemeProvider>(context);
    return SafeArea(
      child: Scaffold(
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
                                          Titletext(title: widget.hotel.name!)
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
                                              itemCount:
                                                  widget.hotel.images!.length,
                                              pagination: const SwiperPagination(
                                                  alignment:
                                                      Alignment.bottomCenter,
                                                  builder:
                                                      DotSwiperPaginationBuilder(
                                                          size: 7,
                                                          activeSize: 7,
                                                          color: Colors.white,
                                                          activeColor: Color(
                                                              0xff0078aa))),
                                              //control: SwiperControl(),
                                              autoplay: true,
                                              itemBuilder: (context, index) {
                                                return FancyShimmerImage(
                                                    imageUrl: widget
                                                        .hotel.images![index]);
                                              },
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          height: mq.size.height * 0.02,
                                        ),
                                        Container(
                                          height: mq.size.height * 0.091,
                                          child: ListView.builder(
                                            shrinkWrap: true,
                                            scrollDirection: Axis.horizontal,
                                            itemCount: facilities.length,
                                            itemBuilder: (context, index) {
                                              return Visibility(
                                                visible:
                                                    widget.hotel.facilities![
                                                        index.toString()],
                                                child: Padding(
                                                  padding: EdgeInsets.only(
                                                    right:
                                                        mq.size.height * 0.027,
                                                  ),
                                                  child: SizedBox(
                                                    width: mq.size.width * 0.25,
                                                    child: Column(
                                                      children: [
                                                        CircleAvatar(
                                                            backgroundColor:
                                                                Colors.grey
                                                                    .withOpacity(
                                                                        0.17),
                                                            child: Icon(
                                                              facilities[index]
                                                                  ["icon"],
                                                              color: themeState
                                                                      .getDarkTheme
                                                                  ? Colors.white
                                                                  : Colors
                                                                      .black,
                                                            )),
                                                        SizedBox(
                                                          height:
                                                              mq.size.height *
                                                                  0.015,
                                                        ),
                                                        Text(
                                                          facilities[index]
                                                              ["name"],
                                                          style: TextStyle(
                                                              fontSize: 11,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500),
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              );
                                            },
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Titletext(
                                            title: "Check-in",
                                            size: 15,
                                          ),
                                          Text(widget.check_In)
                                        ],
                                      ),
                                      SizedBox(
                                        width: mq.size.width * 0.28,
                                      ),
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Titletext(
                                            title: "Check-out",
                                            size: 15,
                                          ),
                                          Text(widget.check_Out)
                                        ],
                                      )
                                    ],
                                  ),
                                  SizedBox(
                                    height: mq.size.height * 0.015,
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Titletext(
                                        title: "Rooms and guests",
                                        size: 15,
                                      ),
                                      Text(
                                        "${widget.room} rooms . ${widget.adults} adults " +
                                            (widget.child == 0
                                                ? " "
                                                : ". ${widget.child} children"),
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
                                              latitude: widget.hotel.latitude,
                                              longitude: widget.hotel.longitude,
                                              hotelname: widget.hotel.name,
                                              add: widget.hotel.address,
                                              imges: widget.hotel.images!.first,
                                              viewdetailcallback: () {
                                                Navigator.pop(context);
                                              },
                                            ),
                                          ));
                                    },
                                    child: ClipRRect(
                                        borderRadius: BorderRadius.circular(7),
                                        child:
                                            Image.asset("assets/img/map.jpg")),
                                  ),
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  Text(widget.hotel.address!)
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            height: mq.size.height * 0.0135,
                          ),
                          Container(
                            width: mq.size.width,
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
                                    child: Text(widget.hotel.description!),
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
                                        builder: (context) => Description(
                                            description:
                                                widget.hotel.description!),
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
                                          padding: EdgeInsets.only(
                                              left: 15, right: 1),
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
                                          padding: EdgeInsets.only(
                                              left: 15, right: 1),
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
                                            fee: widget.hotel.transeferFee,
                                            distance:
                                                widget.hotel.distFromAirport,
                                            time: widget
                                                .hotel.traveltimetoairport),
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
                                          padding: EdgeInsets.only(
                                              left: 15, right: 1),
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
                                            checkinfrom:
                                                widget.hotel.checkinfrom!,
                                            checkinuntil:
                                                widget.hotel.checkinUntil!,
                                            checkout:
                                                widget.hotel.checkoutUntil!),
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
                                          padding: EdgeInsets.only(
                                              left: 15, right: 1),
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
                          Titletext(title: "₹ 120000"),
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
                          height: mq.size.height * 0.067,
                          width: mq.size.width * 0.44,
                          child: commenButton(
                              title: "Next",
                              callback: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => HotelUserInfo(hotel: Hotel(name:widget.hotel.name, description: widget.hotel.description, facilities: widget.hotel.facilities, images: widget.hotel.images, price: widget.hotel.price, cityName: widget.hotel.cityName, disttocenter: widget.hotel.disttocenter, address: widget.hotel.address, latitude: widget.hotel.latitude, longitude: widget.hotel.longitude, checkinfrom: widget.hotel.checkinfrom, checkinUntil: widget.hotel.checkinUntil, checkoutUntil: widget.hotel.checkoutUntil, transeferFee: widget.hotel.transeferFee, distFromAirport: widget.hotel.distFromAirport, traveltimetoairport: widget.hotel.traveltimetoairport),),
                                    ));
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
}
