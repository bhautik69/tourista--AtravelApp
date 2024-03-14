// ignore_for_file: prefer_is_empty

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demo/Screen/Navigationpages/home/tabbarScreen/Trip%20Management/Find_trip.dart';

import 'package:demo/Screen/Navigationpages/home/tabbarScreen/Trip%20Management/triplottey.dart';
import 'package:demo/models/Trip%20models/packagemodel.dart';
import 'package:demo/provider/dark_theme_provider.dart';
import 'package:demo/widget/button.dart';
import 'package:demo/widget/textwidget.dart';
import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class Triptab extends StatefulWidget {
  const Triptab({super.key});

  @override
  State<Triptab> createState() => _TriptabState();
}

class _TriptabState extends State<Triptab> {
  final _formKey = GlobalKey<FormState>();
  var from = TextEditingController();
  var to = TextEditingController();
  var date = TextEditingController();
  List<dynamic> foundlist = [];
  List<Package> allPackage = [];
  List<Package> fvopkg = [];
  List<Map<String, dynamic>> triplst = [];
  bool _formFieldTouched = false;
  bool _dateFieldTouched = false;
  bool _toFieldTouched = false;
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
        .collection("package")
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

  List<dynamic> getSuggestion(String query) => List.of(cityList).where((city) {
        final cityLower = city.toLowerCase();
        final queryLower = query.toLowerCase();
        return cityLower.startsWith(queryLower);
      }).toList();
  Future<void> deletePackagesByStartDate(String startDate) async {
    CollectionReference packagesRef =
        FirebaseFirestore.instance.collection('package');
    QuerySnapshot packagesSnapshot =
        await packagesRef.where('startDate', isEqualTo: startDate).get();
    // ignore: avoid_function_literals_in_foreach_calls
    packagesSnapshot.docs.forEach((doc) async {
      await packagesRef.doc(doc.id).delete();
    });
  }

  getData() async {
    await FirebaseFirestore.instance
        .collection("package")
        .get()
        .then((QuerySnapshot? snapshot) {
      for (var element in snapshot!.docs) {
        if (element.exists) {
          allPackage.add(
            Package(
              latitude: element["latitude"],
              longitude: element["longitude"],
              id: element["id"],
              ActivityList: element['activityList'],
              startingForm: element['startingForm'],
              traveligTo: element['traveligTo'],
              startDate: element['startDate'],
              endDate: element['endDate'],
              imgUrl: element['imgUrl'],
              decs: element['decs'],
              price: element['price'],
              img1: element['img1'],
              img2: element['img2'],
              img3: element['img3'],
              img4: element['img4'],
              flightDate: element['flightDate'],
              reachDate: element['reachDate'],
              flightTime: element['flightTime'],
              reachTime: element['reachTime'],
              hotelName: element['hotelName'],
              hotelImg: element['hotelImg'],
              hotelAdd: element['hotelAdd'],
              hotelPhone: element['hotelPhone'],
              hotelRate: element['hotelRate'],
              isFavorite: element['isFavorite'],
              retunfligthdate: element['retunFligthDate'],
              retunreachfligthdate: element['retunReachFligthDate'],
              retunfligthtime: element['retunFligthTime'],
              retunreachfligthtime: element['retunReachFligthTime'],
            ),
          );
          setState(() {});
        }
      }
    });
  }

  bool search = false;
  bool recentSearch = true;

  @override
  void initState() {
    DateTime dateTime = DateTime.now();
    String datetime1 = "${dateTime.day}-${dateTime.month}-${dateTime.year}";
    deletePackagesByStartDate(datetime1);
    foundlist = allPackage;
    getID();
    getData();
    super.initState();
  }

  void runFilter(String from, String to, String date) {
    List<dynamic> result = [];
    if (from.isEmpty && to.isEmpty && date.isEmpty) {
      result = allPackage;
    } else {
      result = allPackage.where((element) {
        return element.startingForm!
                .toLowerCase()
                .contains(from.toLowerCase()) &&
            element.traveligTo!.toLowerCase().contains(to.toLowerCase()) &&
            element.startDate!.toLowerCase().contains(date.toLowerCase());
      }).toList();
    }
    setState(() {
      foundlist = result;
    });
  }

  @override
  Widget build(BuildContext context) {
    final themeState = Provider.of<DarkThemeProvider>(context);
    var mq = MediaQuery.of(context);
    // ignore: unused_local_variable
    Color color = themeState.getDarkTheme ? Colors.white : Colors.black;
    return allPackage.isEmpty
        ? const Center(
            child: CircularProgressIndicator(
              color: Color(0xff0078aa),
            ),
          )
        : Scaffold(
            backgroundColor: themeState.getDarkTheme
                ? const Color(0xff121212)
                : const Color.fromARGB(255, 236, 235, 235),
            body: Form(
              key: _formKey,
              child: NotificationListener(
                onNotification: (OverscrollIndicatorNotification overscroll) {
                  overscroll.disallowIndicator();
                  return true;
                },
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            color: themeState.getDarkTheme
                                ? Colors.transparent
                                : const Color(0xffffffff),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 8),
                              child: Column(
                                children: [
                                  SizedBox(
                                    height: mq.size.height * 0.02,
                                  ),
                                  TypeAheadFormField(
                                    // hideSuggestionsOnKeyboardHide: true,

                                    //  animationDuration: Duration(seconds: 1),
                                    validator: (value) {
                                      if (_formFieldTouched) {
                                        if (value == null || value.isEmpty) {
                                          return "*Required Field";
                                        }
                                        return null;
                                      }
                                      return null;
                                    },
                                    textFieldConfiguration:
                                        TextFieldConfiguration(
                                      controller: from,
                                      onTap: () {
                                        setState(() {
                                          _formFieldTouched = false;
                                          _formKey.currentState?.validate();
                                        });
                                      },
                                      decoration: InputDecoration(
                                          hintText: "STARTING FROM",
                                          hintStyle: TextStyle(
                                            color: themeState.getDarkTheme
                                                ? Colors.white54
                                                : Colors.black54,
                                          ),
                                          contentPadding:
                                              const EdgeInsets.symmetric(
                                                  vertical: 17, horizontal: 15),
                                          prefixIcon: const Icon(
                                              Icons.location_on_outlined),
                                          //  prefixIconColor: Colors.grey,
                                          border: OutlineInputBorder(
                                              borderSide: const BorderSide(
                                                  width: 1.5,
                                                  color: Colors.black12),
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                          focusedBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              borderSide: BorderSide(
                                                  width: 1.5,
                                                  color: themeState.getDarkTheme
                                                      ? Colors.white54
                                                      : Colors.black54)),
                                          enabledBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              borderSide: BorderSide(
                                                  width: 1.5,
                                                  color: themeState.getDarkTheme
                                                      ? Colors.white54
                                                      : Colors.black54)),
                                          // errorStyle:
                                          //   const TextStyle(color: Color(0xffB00020)),
                                          errorBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(10),
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
                                      from.text = item;
                                    },
                                  ),
                                  SizedBox(
                                    height: mq.size.height * 0.02,
                                  ),
                                  TypeAheadFormField(
                                    // animationDuration: Duration(seconds: 1),
                                    validator: (value) {
                                      if (_toFieldTouched) {
                                        if (value == null || value.isEmpty) {
                                          return "*Required Field";
                                        } else if (from.text == to.text) {
                                          return "*Origin and destination can't be the same";
                                        }
                                        return null;
                                      }
                                      return null;
                                    },
                                    textFieldConfiguration:
                                        TextFieldConfiguration(
                                      controller: to,
                                      onTap: () {
                                        setState(() {
                                          _toFieldTouched = false;
                                          _formKey.currentState?.validate();
                                        });
                                      },
                                      decoration: InputDecoration(
                                          hintText: "TRAVELLING TO",
                                          hintStyle: TextStyle(
                                            color: themeState.getDarkTheme
                                                ? Colors.white54
                                                : Colors.black54,
                                          ),
                                          contentPadding:
                                              const EdgeInsets.symmetric(
                                                  vertical: 17, horizontal: 15),
                                          prefixIcon: const Icon(
                                              Icons.location_on_outlined),
                                          //  prefixIconColor: Colors.grey,
                                          border: OutlineInputBorder(
                                              borderSide: const BorderSide(
                                                  width: 1.5,
                                                  color: Colors.black12),
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                          focusedBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              borderSide: BorderSide(
                                                  width: 1.5,
                                                  color: themeState.getDarkTheme
                                                      ? Colors.white54
                                                      : Colors.black54)),
                                          enabledBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              borderSide: BorderSide(
                                                  width: 1.5,
                                                  color: themeState.getDarkTheme
                                                      ? Colors.white54
                                                      : Colors.black54)),
                                          // errorStyle:
                                          //   const TextStyle(color: Color(0xffB00020)),
                                          errorBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(10),
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
                                      to.text = item;
                                    },
                                  ),
                                  SizedBox(
                                    height: mq.size.height * 0.02,
                                  ),
                                  TextFormField(
                                    controller: date,
                                    readOnly: true,
                                    decoration: InputDecoration(
                                        hintText: "STARTING DATE",
                                        hintStyle: TextStyle(
                                          color: themeState.getDarkTheme
                                              ? Colors.white54
                                              : Colors.black54,
                                        ),
                                        contentPadding:
                                            const EdgeInsets.symmetric(
                                                vertical: 17, horizontal: 15),
                                        prefixIcon: const Icon(
                                            Icons.calendar_month_outlined),
                                        //   prefixIconColor: Colors.grey,
                                        border: OutlineInputBorder(
                                            borderSide: const BorderSide(
                                                width: 1.5,
                                                color: Colors.black12),
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        focusedBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            borderSide: BorderSide(
                                                width: 1.5,
                                                color: themeState.getDarkTheme
                                                    ? Colors.white54
                                                    : Colors.black54)),
                                        enabledBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            borderSide: BorderSide(
                                                width: 1.5,
                                                color: themeState.getDarkTheme
                                                    ? Colors.white54
                                                    : Colors.black54)),
                                        // errorStyle:
                                        //   const TextStyle(color: Color(0xffB00020)),
                                        errorBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          borderSide: const BorderSide(
                                              width: 1.5, color: Colors.red),
                                        )),
                                    validator: (value) {
                                      if (_dateFieldTouched) {
                                        if (value == null || value.isEmpty) {
                                          return "*Required Field";
                                        }
                                        return null;
                                      }
                                      return null;
                                    },
                                    onTap: () async {
                                      setState(() {
                                        _dateFieldTouched = false;
                                        _formKey.currentState?.validate();
                                      });
                                      var dateTime = await showDatePicker(
                                          builder: (BuildContext context,
                                              Widget? child) {
                                            return Theme(
                                              data: ThemeData().copyWith(
                                                  colorScheme:
                                                      const ColorScheme.light(
                                                primary: Color(0xff0078aa),
                                                onPrimary: Colors.white,
                                                onSurface: Colors.black,
                                              )),
                                              child: child!,
                                            );
                                          },
                                          context: context,
                                          initialDate: DateTime.now(),
                                          firstDate: DateTime.now(),
                                          lastDate: DateTime(2024, 5));

                                      date.text =
                                          "${dateTime?.day}-${dateTime?.month}-${dateTime!.year}";
                                    },
                                  ),
                                  SizedBox(
                                    height: mq.size.height * 0.02,
                                  ),
                                  SizedBox(
                                      height: 52,
                                      width: mq.size.width,
                                      child: commenButton(
                                          title: "Search",
                                          callback: () {
                                            triplst.clear();
                                            setState(
                                              () {
                                                _dateFieldTouched = true;
                                                _formFieldTouched = true;
                                                _toFieldTouched = true;
                                              },
                                            );
                                            if (_formKey.currentState!
                                                .validate()) {
                                              search = true;
                                              recentSearch = false;
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        Triploty(
                                                            search: search,
                                                            date: date.text,
                                                            sform: from.text,
                                                            tto: to.text),
                                                  ));
                                            }
                                          })),
                                  SizedBox(
                                    height: mq.size.height * 0.01,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Padding(
                            padding:
                                EdgeInsets.only(bottom: 8, top: 13, left: 8),
                            child: StreamBuilder(
                                stream: FirebaseFirestore.instance
                                    .collection("TripResentsearch")
                                    .doc(FirebaseAuth.instance.currentUser!.uid)
                                    .collection("tripSearch")
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
                                      .where((element) =>
                                          id.contains(element["id"]))
                                      .toList();

                                  if (data.isEmpty) {
                                    return const Text("");
                                  }
                                  return Visibility(
                                      visible: data.isEmpty ? false : true,
                                      child: Titletext(
                                          title: "Continue your search"));
                                }),
                          ),
                          InkWell(
                            onTap: () {},
                            child: SizedBox(
                              height: mq.size.height * 0.15,
                              child: StreamBuilder(
                                  stream: FirebaseFirestore.instance
                                      .collection("TripResentsearch")
                                      .doc(FirebaseAuth
                                          .instance.currentUser!.uid)
                                      .collection("tripSearch")
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
                                        .where((element) =>
                                            id.contains(element.id))
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
                                          var date = getdate1(
                                              data[index]["startdate"]);
                                          return Padding(
                                            padding: const EdgeInsets.only(
                                              right: 10,
                                            ),
                                            child: GestureDetector(
                                              onTap: () async {
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) =>
                                                          Find_trip(
                                                        search: search,
                                                        date: data[index]
                                                            ["startdate"],
                                                        sform: data[index]
                                                            ["startingfrom"],
                                                        tto: data[index]
                                                            ["tavelingto"],
                                                      ),
                                                    ));
                                              },
                                              child: Card(
                                                elevation: 5,
                                                child: Container(
                                                  width: 260,
                                                  decoration: BoxDecoration(
                                                      color: themeState
                                                              .getDarkTheme
                                                          ? const Color(
                                                              0xff212121)
                                                          : const Color(
                                                              0xffffffff),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10)),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(
                                                                left: 15,
                                                                top: 5),
                                                        child: Row(
                                                          children: [
                                                            Icon(
                                                              Icons
                                                                  .location_on_outlined,
                                                              size: 19,
                                                            ),
                                                            SizedBox(
                                                              width: 2,
                                                            ),
                                                            Titletext(
                                                              title: data[index]
                                                                  [
                                                                  "tavelingto"],
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
                                                                  BorderRadius
                                                                      .circular(
                                                                          10),
                                                              child:
                                                                  FancyShimmerImage(
                                                                imageUrl:
                                                                    data[index]
                                                                        ["url"],
                                                                boxFit: BoxFit
                                                                    .cover,
                                                              )),
                                                        ),
                                                        title: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .only(
                                                                  bottom: 7),
                                                          child: Text(
                                                            data[index][
                                                                    "startingfrom"] +
                                                                " To " +
                                                                data[index][
                                                                    "tavelingto"],
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                            maxLines: 1,
                                                            style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500),
                                                          ),
                                                        ),
                                                        subtitle: Text(date),
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
                    ],
                  ),
                ),
              ),
            ),
          );
  }

  String getdate1(String date) {
    DateTime datetime = DateFormat('dd-MM-yyyy').parse(date);
    String formattedDate = DateFormat('dd MMM yyyy').format(datetime);
    return formattedDate;
  }
}
