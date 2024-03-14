// ignore_for_file: prefer_is_empty

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demo/Screen/Navigationpages/home/tabbarScreen/Trip%20Management/details.dart';
import 'package:demo/models/Trip%20models/packagemodel.dart';
import 'package:demo/provider/dark_theme_provider.dart';
import 'package:demo/widget/button.dart';
import 'package:demo/widget/textwidget.dart';
import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
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

  addToFavorite(String ide) async {
    fvopkg = allPackage.where((element) => element.id == ide).toList();
    CollectionReference collectionReference =
        FirebaseFirestore.instance.collection("favorite");
    await collectionReference
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection("items")
        .doc(fvopkg.first.id)
        .set({
      "latitude": fvopkg.first.latitude,
      "longitude": fvopkg.first.longitude,
      "pid": fvopkg.first.id,
      'startingForm': fvopkg.first.startingForm,
      "traveligTo": fvopkg.first.traveligTo,
      "startDate": fvopkg.first.startDate,
      "endDate": fvopkg.first.endDate,
      "imgUrl": fvopkg.first.imgUrl,
      "decs": fvopkg.first.decs,
      "price": fvopkg.first.price,
      "img1": fvopkg.first.img1,
      "img2": fvopkg.first.img2,
      "img3": fvopkg.first.img3,
      "img4": fvopkg.first.img4,
      "flightDate": fvopkg.first.flightDate,
      "reachDate": fvopkg.first.reachDate,
      "flightTime": fvopkg.first.flightTime,
      "reachTime": fvopkg.first.reachTime,
      "hotelName": fvopkg.first.hotelName,
      "hotelImg": fvopkg.first.hotelImg,
      "hotelAdd": fvopkg.first.hotelAdd,
      "hotelPhone": fvopkg.first.hotelPhone,
      "hotelRate": fvopkg.first.hotelRate,
      "activityList": fvopkg.first.ActivityList,
      "isFavorite": fvopkg.first.isFavorite,
      'retunFligthDate': fvopkg.first.retunfligthdate,
      'retunReachFligthDate': fvopkg.first.retunreachfligthdate,
      'retunFligthTime': fvopkg.first.retunfligthtime,
      'retunReachFligthTime': fvopkg.first.retunreachfligthtime,
      "type": "favorite"
    });
    fvopkg.clear();
  }

  @override
  void initState() {
    DateTime dateTime = DateTime.now();
    String datetime1 = "${dateTime.day}-${dateTime.month}-${dateTime.year}";
    deletePackagesByStartDate(datetime1);
    foundlist = allPackage;
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

  removFavorite(String id) async {
    CollectionReference collectionReference =
        FirebaseFirestore.instance.collection("favorite");
    await collectionReference
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection("items")
        .doc(id)
        .delete();
  }

  @override
  Widget build(BuildContext context) {
    final themeState = Provider.of<DarkThemeProvider>(context);
    var mq = MediaQuery.of(context);
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
                                ? const Color(0xff212121)
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
                                              runFilter(from.text, to.text,
                                                  date.text);
                                            }
                                          })),
                                  SizedBox(
                                    height: mq.size.height * 0.01,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            height: mq.size.height * 0.02,
                          ),
                          foundlist.isEmpty
                              ? Padding(
                                  padding: EdgeInsets.only(
                                      top: mq.size.height * 0.1),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      const Icon(
                                        Icons.search_off_outlined,
                                        color: Color(0xff0078aa),
                                        size: 70,
                                      ),
                                      SizedBox(
                                        height: mq.size.height * 0.014,
                                      ),
                                      Text(
                                        "Oops! We didn't get you ",
                                        style: TextStyle(
                                            color: themeState.getDarkTheme
                                                ? Colors.white
                                                : Colors.black,
                                            fontWeight: FontWeight.w700,
                                            fontSize: 20),
                                      ),
                                      SizedBox(
                                        height: mq.size.height * 0.024,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 25),
                                        child: Text(
                                          "Sorry, but we can't find anything that matches yours search.Plese try again ",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.w400,
                                              color: themeState.getDarkTheme
                                                  ? Colors.white54
                                                  : Colors.black54),
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              : ListView.builder(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount: foundlist.length,
                                  itemBuilder: (context, index) {
                                    return Padding(
                                      padding:
                                          const EdgeInsets.only(bottom: 12),
                                      child: InkWell(
                                        onTap: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    PlaceDetails(
                                                  id: foundlist[index].id,
                                                  package: Package(
                                                      latitude: foundlist[index]
                                                          .latitude,
                                                      longitude: foundlist[index]
                                                          .longitude,
                                                      id: foundlist[index].id,
                                                      ActivityList: foundlist[index]
                                                          .ActivityList,
                                                      startingForm: foundlist[index]
                                                          .startingForm,
                                                      traveligTo: foundlist[index]
                                                          .traveligTo,
                                                      startDate: foundlist[index]
                                                          .startDate,
                                                      endDate: foundlist[index]
                                                          .endDate,
                                                      imgUrl: foundlist[index]
                                                          .imgUrl,
                                                      decs:
                                                          foundlist[index].decs,
                                                      price: foundlist[index]
                                                          .price,
                                                      img1:
                                                          foundlist[index].img1,
                                                      img2:
                                                          foundlist[index].img2,
                                                      img3:
                                                          foundlist[index].img3,
                                                      img4:
                                                          foundlist[index].img4,
                                                      flightDate: foundlist[index]
                                                          .flightDate,
                                                      reachDate: foundlist[index]
                                                          .reachDate,
                                                      flightTime: foundlist[index]
                                                          .flightTime,
                                                      reachTime: foundlist[index].reachTime,
                                                      hotelName: foundlist[index].hotelName,
                                                      hotelImg: foundlist[index].hotelImg,
                                                      hotelAdd: foundlist[index].hotelAdd,
                                                      hotelPhone: foundlist[index].hotelPhone,
                                                      hotelRate: foundlist[index].hotelRate,
                                                      retunfligthdate: foundlist[index].retunfligthdate,
                                                      retunreachfligthdate: foundlist[index].retunreachfligthdate,
                                                      retunfligthtime: foundlist[index].retunfligthtime,
                                                      retunreachfligthtime: foundlist[index].retunreachfligthtime),
                                                ),
                                              ));
                                        },
                                        child: Container(
                                          color: themeState.getDarkTheme
                                              ? const Color(0xff212121)
                                              : const Color(0xffffffff),
                                          // elevation: 3,
                                          child: Padding(
                                            padding: EdgeInsets.all(
                                                mq.size.width * 0.023),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Padding(
                                                  padding: EdgeInsets.only(
                                                      bottom:
                                                          mq.size.width * 0.03,
                                                      top:
                                                          mq.size.width * 0.03 -
                                                              mq.size.width *
                                                                  0.023),
                                                  child: Row(
                                                    children: [
                                                      Titletext(
                                                          title:
                                                              foundlist[index]
                                                                  .traveligTo!),
                                                      const Spacer(),
                                                      StreamBuilder(
                                                          stream: FirebaseFirestore
                                                              .instance
                                                              .collection(
                                                                  "favorite")
                                                              .doc(FirebaseAuth
                                                                  .instance
                                                                  .currentUser!
                                                                  .uid)
                                                              .collection(
                                                                  "items")
                                                              .where("pid",
                                                                  isEqualTo:
                                                                      allPackage[
                                                                              index]
                                                                          .id)
                                                              .snapshots(),
                                                          builder: (context,
                                                              AsyncSnapshot<
                                                                      QuerySnapshot>
                                                                  snapshot) {
                                                            if (snapshot.data ==
                                                                null) {
                                                              return const Text(
                                                                  "");
                                                            }
                                                            return InkWell(
                                                                onTap: () {
                                                                  snapshot.data!.docs
                                                                              .length ==
                                                                          0
                                                                      ? addToFavorite(
                                                                          foundlist[index]
                                                                              .id!)
                                                                      : removFavorite(
                                                                          foundlist[index]
                                                                              .id!);
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
                                                                      : Colors
                                                                          .red,
                                                                ));
                                                          })
                                                    ],
                                                  ),
                                                ),
                                                SizedBox(
                                                    height:
                                                        mq.size.width * 0.45,
                                                    width: double.infinity,
                                                    child: FancyShimmerImage(
                                                      imageUrl: foundlist[index]
                                                          .imgUrl!,
                                                    )),
                                                Padding(
                                                  padding: EdgeInsets.symmetric(
                                                      vertical: mq.size.width *
                                                          0.023),
                                                  child: Row(
                                                    children: [
                                                      Icon(
                                                        Icons
                                                            .location_on_outlined,
                                                        color: themeState
                                                                .getDarkTheme
                                                            ? Colors.white
                                                            : Colors.black,
                                                        size: 16,
                                                      ),
                                                      Text.rich(
                                                        TextSpan(
                                                            text:
                                                                " Starting from : ",
                                                            style: TextStyle(
                                                              color: themeState
                                                                      .getDarkTheme
                                                                  ? Colors.white
                                                                  : Colors
                                                                      .black,
                                                            ),
                                                            children: [
                                                              TextSpan(
                                                                  text: foundlist[
                                                                          index]
                                                                      .startingForm,
                                                                  style: TextStyle(
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w500,
                                                                      color: themeState
                                                                              .getDarkTheme
                                                                          ? Colors.white.withOpacity(
                                                                              0.6)
                                                                          : Colors
                                                                              .black
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
                                                        color: themeState
                                                                .getDarkTheme
                                                            ? Colors.white
                                                            : Colors.black,
                                                      ),
                                                      children: [
                                                        TextSpan(
                                                            text:
                                                                foundlist[index]
                                                                    .startDate,
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
                                                Padding(
                                                  padding: EdgeInsets.symmetric(
                                                      vertical: mq.size.width *
                                                          0.023),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Column(
                                                        children: [
                                                          RotatedBox(
                                                              quarterTurns: 1,
                                                              child: Icon(
                                                                Icons.flight,
                                                                color: themeState
                                                                        .getDarkTheme
                                                                    ? Colors
                                                                        .white
                                                                    : Colors
                                                                        .black,
                                                              )),
                                                          Padding(
                                                            padding: EdgeInsets
                                                                .all(mq.size
                                                                        .width *
                                                                    0.0115),
                                                            child: Text(
                                                              "2 Flight",
                                                              style: TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .normal,
                                                                  color: themeState
                                                                          .getDarkTheme
                                                                      ? Colors
                                                                          .white
                                                                          .withOpacity(
                                                                              0.7)
                                                                      : Colors
                                                                          .black
                                                                          .withOpacity(
                                                                              0.7)),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      Column(
                                                        children: [
                                                          Icon(
                                                            Icons
                                                                .business_outlined,
                                                            color: themeState
                                                                    .getDarkTheme
                                                                ? Colors.white
                                                                : Colors.black,
                                                          ),
                                                          Padding(
                                                            padding: EdgeInsets
                                                                .all(mq.size
                                                                        .width *
                                                                    0.0115),
                                                            child: Text(
                                                              "1 Hotel",
                                                              style: TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .normal,
                                                                  color: themeState
                                                                          .getDarkTheme
                                                                      ? Colors
                                                                          .white
                                                                          .withOpacity(
                                                                              0.7)
                                                                      : Colors
                                                                          .black
                                                                          .withOpacity(
                                                                              0.7)),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      Column(
                                                        children: [
                                                          Icon(
                                                            Icons.hiking_sharp,
                                                            color: themeState
                                                                    .getDarkTheme
                                                                ? Colors.white
                                                                : Colors.black,
                                                          ),
                                                          Padding(
                                                            padding: EdgeInsets
                                                                .all(mq.size
                                                                        .width *
                                                                    0.0115),
                                                            child: Text(
                                                              "${foundlist[index].ActivityList!.length} Activities",
                                                              style: TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .normal,
                                                                  color: themeState
                                                                          .getDarkTheme
                                                                      ? Colors
                                                                          .white
                                                                          .withOpacity(
                                                                              0.7)
                                                                      : Colors
                                                                          .black
                                                                          .withOpacity(
                                                                              0.7)),
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
                                                          bottom: mq.size
                                                                      .width *
                                                                  0.03 -
                                                              mq.size.width *
                                                                  0.023),
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .center,
                                                        children: [
                                                          Text(
                                                            "₹${foundlist[index].price!}",
                                                            style: TextStyle(
                                                                color: themeState
                                                                        .getDarkTheme
                                                                    ? Colors
                                                                        .white
                                                                    : Colors
                                                                        .black,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
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
                                                                          .black54,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w400))
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
                                ),
                          SizedBox(
                            height: mq.size.height * 0.025,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
  }
}
