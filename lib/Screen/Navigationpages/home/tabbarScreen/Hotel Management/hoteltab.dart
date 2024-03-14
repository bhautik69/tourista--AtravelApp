// ignore_for_file: use_build_context_synchronously, deprecated_member_use

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demo/Screen/Navigationpages/home/tabbarScreen/Hotel%20Management/findhotel.dart';
import 'package:demo/Screen/Navigationpages/home/tabbarScreen/Hotel%20Management/hotelottie.dart';
import 'package:demo/Screen/Navigationpages/home/tabbarScreen/Hotel%20Management/roomandguest.dart';
import 'package:demo/provider/dark_theme_provider.dart';

import 'package:demo/widget/button.dart';
import 'package:demo/widget/textwidget.dart';
import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Hoteltab extends StatefulWidget {
  const Hoteltab({super.key});

  @override
  State<Hoteltab> createState() => _HoteltabState();
}

class _HoteltabState extends State<Hoteltab> {
  List<dynamic> getSuggestion(String query) => List.of(cityList).where((city) {
        final cityLower = city.toLowerCase();
        final queryLower = query.toLowerCase();
        return cityLower.startsWith(queryLower);
      }).toList();

  final _formKey = GlobalKey<FormState>();
  int adults1 = 1;
  int child1 = 0;
  int room1 = 1;
  int total = 0;
  List<String> ages1 = [];
  var destination = TextEditingController();
  var rac = TextEditingController();
  var checkin = TextEditingController();
  var checkout = TextEditingController();
  List cityList = [
    "Agra",
    "Ahmedabad",
    "Allahabad",
    "Amritsar",
    "Bangalore",
    "Bhopal",
    "Chandigarh",
    "Chennai",
    "Delhi",
    "Goa",
    "Haridwar",
    "Himalayas",
    "Hyderabad",
    "Indore",
    "Jaipur",
    "Jaisalmer",
    "Jodhpur",
    "Kanpur",
    "Khajuraho",
    "Kerala",
    "Locknow",
    "Kochi",
    "Kolkata",
    "mahabaleshwar",
    "Mumbai",
    "Mysore",
    "Nashik",
    "Patna",
    "Pune",
    "Rajkot",
    "Shimla",
    "Surat",
    "Saputara",
    "Udaipur",
    "Varanasi"
  ];
  List id = [];

  getID() async {
    await FirebaseFirestore.instance
        .collection("Hotel")
        .get()
        .then((QuerySnapshot? snapshot) {
      for (var element in snapshot!.docs) {
        if (element.exists) {
          id.add(element["id"]);
          setState(() {});
        }
      }
    });
  }

  @override
  void initState() {
    getID();
    super.initState();
  }

  bool search = false;
  bool recentSearch = false;
  @override
  Widget build(BuildContext context) {
    final themeState = Provider.of<DarkThemeProvider>(context);
    var mq = MediaQuery.of(context);
    return NotificationListener(
      onNotification: (OverscrollIndicatorNotification overscroll) {
        overscroll.disallowIndicator();
        return true;
      },
      child: Scaffold(
        // backgroundColor: themeState.getDarkTheme
        //     ? const Color(0xff121212)
        //     : const Color.fromARGB(255, 236, 235, 235),
        body: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  color: themeState.getDarkTheme
                      ? Colors.transparent
                      : const Color(0xffffffff),
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                    child: Column(
                      children: [
                        SizedBox(
                          height: mq.size.height * 0.02,
                        ),
                        TypeAheadFormField(
                          // hideSuggestionsOnKeyboardHide: true,

                          //  animationDuration: Duration(seconds: 1),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "*Required Field";
                            }
                            return null;
                          },
                          textFieldConfiguration: TextFieldConfiguration(
                            controller: destination,
                            decoration: InputDecoration(
                                hintText: "DESTINATION",
                                hintStyle: TextStyle(
                                  color: themeState.getDarkTheme
                                      ? Colors.white54
                                      : Colors.black54,
                                ),
                                contentPadding: const EdgeInsets.symmetric(
                                    vertical: 17, horizontal: 15),
                                prefixIcon: const Icon(Icons.search),
                                //       prefixIconColor: Colors.grey,

                                border: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                        width: 1.5, color: Colors.black12),
                                    borderRadius: BorderRadius.circular(10)),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide(
                                        width: 1.5,
                                        color: themeState.getDarkTheme
                                            ? Colors.white54
                                            : Colors.black54)),
                                enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide(
                                        width: 1.5,
                                        color: themeState.getDarkTheme
                                            ? Colors.white54
                                            : Colors.black54)),
                                // errorStyle:
                                //   const TextStyle(color: Color(0xffB00020)),
                                errorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: const BorderSide(
                                      width: 1.5, color: Colors.red),
                                )),
                          ),
                          suggestionsCallback: getSuggestion,
                          itemBuilder: (context, itemData) {
                            return Container(
                              color: themeState.getDarkTheme
                                  ? const Color(0xff212121)
                                  : const Color(0xffFFFFFF),
                              padding: const EdgeInsets.all(10),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.location_on_outlined,
                                    size: 18,
                                    color: themeState.getDarkTheme
                                        ? Colors.white54
                                        : Colors.black54,
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    itemData,
                                    style: TextStyle(
                                      fontSize: 17,
                                      color: themeState.getDarkTheme
                                          ? Colors.white54
                                          : Colors.black54,
                                    ),
                                  )
                                ],
                              ),
                            );
                          },
                          onSuggestionSelected: (item) {
                            destination.text = item;
                          },
                        ),
                        SizedBox(
                          height: mq.size.height * 0.02,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              width: mq.size.width / 2.2,
                              child: TextFormField(
                                controller: checkin,
                                readOnly: true,
                                decoration: InputDecoration(
                                    hintText: "CHECK-IN",
                                    hintStyle: TextStyle(
                                      color: themeState.getDarkTheme
                                          ? Colors.white54
                                          : Colors.black54,
                                    ),
                                    contentPadding: const EdgeInsets.symmetric(
                                        vertical: 17, horizontal: 15),
                                    prefixIcon: const Icon(
                                        Icons.calendar_month_outlined),
                                    //     prefixIconColor: Colors.grey,
                                    border: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                            width: 1.5, color: Colors.black12),
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide: BorderSide(
                                            width: 1.5,
                                            color: themeState.getDarkTheme
                                                ? Colors.white54
                                                : Colors.black54)),
                                    enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide: BorderSide(
                                            width: 1.5,
                                            color: themeState.getDarkTheme
                                                ? Colors.white54
                                                : Colors.black54)),
                                    // errorStyle:
                                    //   const TextStyle(color: Color(0xffB00020)),
                                    errorBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: const BorderSide(
                                          width: 1.5, color: Colors.red),
                                    )),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return "*Required Field";
                                  }
                                  return null;
                                },
                                onTap: () async {
                                  var dateTime = themeState.getDarkTheme
                                      ? await ligtModeDatepicker(
                                          themeState, context)
                                      : await darkModeDatepicker(context);

                                  if (dateTime != null) {
                                    checkin.text =
                                        "${dateTime.start.day}-${dateTime.start.month}-${dateTime.start.year}";
                                    checkout.text =
                                        "${dateTime.end.day}-${dateTime.end.month}-${dateTime.end.year}";
                                  }
                                },
                              ),
                            ),
                            SizedBox(
                              width: mq.size.width / 2.2,
                              child: TextFormField(
                                controller: checkout,
                                readOnly: true,
                                decoration: InputDecoration(
                                    hintText: "CHECK-OUT",
                                    hintStyle: TextStyle(
                                      color: themeState.getDarkTheme
                                          ? Colors.white54
                                          : Colors.black54,
                                    ),
                                    contentPadding: const EdgeInsets.symmetric(
                                        vertical: 17, horizontal: 15),
                                    prefixIcon: const Icon(
                                        Icons.calendar_month_outlined),
                                    //  prefixIconColor: Colors.grey,
                                    border: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                            width: 1.5, color: Colors.black12),
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide: BorderSide(
                                            width: 1.5,
                                            color: themeState.getDarkTheme
                                                ? Colors.white54
                                                : Colors.black54)),
                                    enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide: BorderSide(
                                            width: 1.5,
                                            color: themeState.getDarkTheme
                                                ? Colors.white54
                                                : Colors.black54)),
                                    // errorStyle:
                                    //   const TextStyle(color: Color(0xffB00020)),
                                    errorBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: const BorderSide(
                                          width: 1.5, color: Colors.red),
                                    )),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return "*Required Field";
                                  }
                                  return null;
                                },
                                onTap: () async {
                                  var dateTime = themeState.getDarkTheme
                                      ? await ligtModeDatepicker(
                                          themeState, context)
                                      : await darkModeDatepicker(context);
                                  if (dateTime != null) {
                                    checkin.text =
                                        "${dateTime.start.day}-${dateTime.start.month}-${dateTime.start.year}";
                                    checkout.text =
                                        "${dateTime.end.day}-${dateTime.end.month}-${dateTime.end.year}";
                                  }
                                },
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: mq.size.height * 0.02,
                        ),
                        TextFormField(
                          controller: rac,
                          readOnly: true,
                          decoration: InputDecoration(
                              hintText: "ROOMS AND GUESTS",
                              hintStyle: TextStyle(
                                color: themeState.getDarkTheme
                                    ? Colors.white54
                                    : Colors.black54,
                              ),
                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: 17, horizontal: 15),
                              prefixIcon: const Icon(Icons.person),
                              //  prefixIconColor: Colors.grey,
                              border: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      width: 1.5, color: Colors.black12),
                                  borderRadius: BorderRadius.circular(10)),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(
                                      width: 1.5,
                                      color: themeState.getDarkTheme
                                          ? Colors.white54
                                          : Colors.black54)),
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(
                                      width: 1.5,
                                      color: themeState.getDarkTheme
                                          ? Colors.white54
                                          : Colors.black54)),
                              // errorStyle:
                              //   const TextStyle(color: Color(0xffB00020)),
                              errorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: const BorderSide(
                                    width: 1.5, color: Colors.red),
                              )),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "*Required Field";
                            }
                            return null;
                          },
                          onTap: () async {
                            setState(() {
                              Navigator.push(
                                context,
                                PageRouteBuilder(
                                  pageBuilder: (context, animation,
                                          secondaryAnimation) =>
                                      roomGuest(
                                    totalRAC:
                                        (rooms, adults, children, agelist) {
                                      setState(() {
                                        room1 = rooms;
                                        adults1 = adults;
                                        child1 = children;
                                        total = adults + children;
                                        ages1 = agelist;
                                        print("$ages1----------- ");
                                        var child;
                                        children == 0
                                            ? child = " "
                                            : child = ". $children child";

                                        rac.text =
                                            "$rooms rooms . $adults adults $child";
                                      });
                                    },
                                  ),
                                  transitionsBuilder: (context, animation,
                                      secondaryAnimation, child) {
                                    const begin = Offset(0.0, 1.0);
                                    const end = Offset.zero;
                                    const curve = Curves.ease;
                                    var tween = Tween(begin: begin, end: end)
                                        .chain(CurveTween(curve: curve));
                                    var offsetAnimation =
                                        animation.drive(tween);

                                    return SlideTransition(
                                      position: offsetAnimation,
                                      child: child,
                                    );
                                  },
                                ),
                              );
                            });
                          },
                        ),
                        SizedBox(
                          height: mq.size.height * 0.02,
                        ),
                        SizedBox(
                          width: mq.size.width,
                          height: 52,
                          child: commenButton(
                            title: "Search",
                            callback: () async {
                              if (_formKey.currentState!.validate()) {
                                setState(() {
                                  search = true;
                                  recentSearch = false;
                                });
                                var store =
                                    await SharedPreferences.getInstance();
                                store.setString("checkInDate", checkin.text);
                                store.setString("checkOutDate", checkout.text);
                                store.setInt("room", room1);
                                store.setInt("adult", adults1);
                                store.setInt("children", child1);
                                store.setInt("total", total);
                                store.setStringList("agelist", ages1);
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => HotelLottie(
                                        destination: destination.text,
                                        check_In: checkin.text,
                                        check_Out: checkout.text,
                                        adults: adults1,
                                        child: child1,
                                        room: room1,
                                        search: search,
                                        recentsearch: recentSearch,
                                      ),
                                    ));
                              }
                            },
                          ),
                        ),
                        SizedBox(
                          height: mq.size.height * 0.01,
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 8, top: 13, left: 8),
                  child: StreamBuilder(
                      stream: FirebaseFirestore.instance
                          .collection("HotelResentsearch")
                          .doc(FirebaseAuth.instance.currentUser!.uid)
                          .collection("HotelSearch")
                          .snapshots(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(child: Text(""));
                        }
                        if (!snapshot.hasData ||
                            snapshot.data == null ||
                            snapshot.data!.docs.isEmpty) {
                          return const Text("");
                        }

                        var data = snapshot.data!.docs
                            .where((element) => id.contains(element["id"]))
                            .toList();

                        if (data.isEmpty) {
                          return const Text("");
                        }
                        return Visibility(
                            visible: data.isEmpty ? false : true,
                            child: Titletext(title: "Continue your search"));
                      }),
                ),
                InkWell(
                  onTap: () {},
                  child: SizedBox(
                    height: mq.size.height * 0.15,
                    child: StreamBuilder(
                        stream: FirebaseFirestore.instance
                            .collection("HotelResentsearch")
                            .doc(FirebaseAuth.instance.currentUser!.uid)
                            .collection("HotelSearch")
                            .snapshots(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Center(child: Text(""));
                          }
                          if (!snapshot.hasData ||
                              snapshot.data == null ||
                              snapshot.data!.docs.isEmpty) {
                            return const Text("");
                          }

                          var data = snapshot.data!.docs
                              .where((element) => id.contains(element["id"]))
                              .toList();

                          if (data.isEmpty) {
                            return const Text("");
                          }

                          return Padding(
                            padding: const EdgeInsets.only(left: 7),
                            child: ListView.builder(
                              itemCount: data.length,
                              scrollDirection: Axis.horizontal,
                              shrinkWrap: true,
                              itemBuilder: (context, index) {
                                var date = getdate(data[index]["checkOut"]);
                                var date1 = getdate1(data[index]["checkIn"]);

                                return Padding(
                                  padding: const EdgeInsets.only(
                                    right: 10,
                                  ),
                                  child: GestureDetector(
                                    onTap: () async {
                                      setState(() {
                                        search = false;
                                        recentSearch = true;
                                        print(search);
                                      });
                                      List<dynamic> agesDynamic =
                                          data[index]["ages"];
                                      List<String> agesString = agesDynamic
                                          .map((age) => age.toString())
                                          .toList();
                                      print(data[index]["ages"]);
                                      
                                      var store =
                                          await SharedPreferences.getInstance();
                                      store.setStringList(
                                          "agelist", agesString);
                                      store.setString("checkInDate",
                                          data[index]["checkIn"]);
                                      store.setString("checkOutDate",
                                          data[index]["checkOut"]);
                                      store.setInt("room",
                                          int.parse(data[index]["room"]));
                                      store.setInt("adult",
                                          int.parse(data[index]["adult"]));
                                      store.setInt("children",
                                          int.parse(data[index]["child"]));
                                      store.setInt(
                                          "total",
                                          int.parse(data[index]["adult"]) +
                                              int.parse(data[index]["child"]));

                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => show_hotel(
                                              search: search,
                                              recentsearch: recentSearch,
                                              adults: int.parse(
                                                  data[index]["adult"]),
                                              destination: data[index]
                                                  ["destination"],
                                              room: int.parse(
                                                  data[index]["room"]),
                                              check_In: data[index]["checkIn"],
                                              check_Out: data[index]
                                                  ["checkOut"],
                                              child: int.parse(
                                                  data[index]["child"]),
                                              ageList: data[index]["ages"],
                                            ),
                                          ));
                                    },
                                    child: Card(
                                      elevation: 5,
                                      child: Container(
                                        width: 260,
                                        decoration: BoxDecoration(
                                            color: themeState.getDarkTheme
                                                ? const Color(0xff212121)
                                                : const Color(0xffffffff),
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 15, top: 5),
                                              child: Row(
                                                children: [
                                                  Icon(
                                                    Icons.location_on_outlined,
                                                    size: 19,
                                                  ),
                                                  SizedBox(
                                                    width: 2,
                                                  ),
                                                  Titletext(
                                                    title: data[index]
                                                        ["destination"],
                                                    size: 18,
                                                  ),
                                                ],
                                              ),
                                            ),
                                            ListTile(
                                              leading: SizedBox(
                                                height: 60,
                                                width: 60,
                                                child: ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                    child: FancyShimmerImage(
                                                      imageUrl: data[index]
                                                          ["url"],
                                                      boxFit: BoxFit.cover,
                                                    )),
                                              ),
                                              title: Padding(
                                                padding: const EdgeInsets.only(
                                                    bottom: 7),
                                                child: Text(
                                                  data[index]["hotelname"],
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  maxLines: 1,
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w500),
                                                ),
                                              ),
                                              subtitle: Text(date1 +
                                                  date +
                                                  ", ${int.parse(data[index]["adult"]) + int.parse(data[index]["child"])} Traveller"),
                                              // ' To ' +
                                              // data[index]['endDate'],
                                              // style:
                                              //TextStyle(color: Colors.white.withOpacity(0.85)),
                                              // ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          );
                        }),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  String getdate(String date) {
    DateTime datetime = DateFormat('dd-MM-yyyy').parse(date);
    String formattedDate = DateFormat('dd MMM').format(datetime);
    return formattedDate;
  }

  String getdate1(String date) {
    DateTime datetime = DateFormat('dd-MM-yyyy').parse(date);
    String formattedDate = DateFormat('dd - ').format(datetime);
    return formattedDate;
  }

  Future<DateTimeRange?> ligtModeDatepicker(
      DarkThemeProvider themeState, BuildContext context) {
    return showDateRangePicker(
        builder: (context, child) {
          return NotificationListener(
            onNotification: (OverscrollIndicatorNotification overscroll) {
              overscroll.disallowIndicator();
              return true;
            },
            child: Theme(
                data: ThemeData(
                  textTheme: Theme.of(context).textTheme.copyWith(
                        // Adjust the color of the text as per your requirement
                        bodyText1: const TextStyle(
                            color: Colors.white), // Example color
                        bodyText2: const TextStyle(
                            color: Colors.white), // Example color
                        // Add more text styles as needed
                      ),
                  colorScheme: const ColorScheme.dark(
                      onSurface: Colors.white,
                      surface: Colors.black,
                      onPrimary: Colors.black,
                      primary: Color(0xff0078aa)),
                  appBarTheme:
                      const AppBarTheme(backgroundColor: Color(0xff121212)),
                ),
                child: child!),
          );
        },
        context: context,
        firstDate: DateTime.now(),
        lastDate: DateTime(2024, 5));
  }

  Future<DateTimeRange?> darkModeDatepicker(BuildContext context) {
    return showDateRangePicker(
        builder: (context, child) {
          return NotificationListener(
            onNotification: (OverscrollIndicatorNotification overscroll) {
              overscroll.disallowIndicator();
              return true;
            },
            child: Theme(
                data: ThemeData(
                  appBarTheme:
                      const AppBarTheme(backgroundColor: Color(0xff0078aa)),
                ),
                child: child!),
          );
        },
        context: context,
        firstDate: DateTime.now(),
        lastDate: DateTime(2024, 5));
  }
}
