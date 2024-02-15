// ignore_for_file: use_build_context_synchronously, deprecated_member_use

import 'package:demo/provider/dark_theme_provider.dart';
import 'package:demo/widget/button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:provider/provider.dart';

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

  bool _formFieldTouched = false;
  bool _dateFieldTouched = false;

  final _formKey = GlobalKey<FormState>();
  var destination = TextEditingController();
  var adults = TextEditingController();
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

  @override
  Widget build(BuildContext context) {
    final themeState = Provider.of<DarkThemeProvider>(context);
    var mq = MediaQuery.of(context);
    return NotificationListener(
      onNotification: (OverscrollIndicatorNotification overscroll) {
        overscroll.disallowIndicator();
        return true;
      },
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            SizedBox(
              height: mq.size.height * 0.03,
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
              textFieldConfiguration: TextFieldConfiguration(
                controller: destination,
                onTap: () {
                  setState(() {
                    _formFieldTouched = false;
                    _formKey.currentState?.validate();
                  });
                },
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
                    prefixIconColor: Colors.grey,
                    border: OutlineInputBorder(
                        borderSide:
                            const BorderSide(width: 1.5, color: Colors.black12),
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
                      borderSide:
                          const BorderSide(width: 1.5, color: Colors.red),
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
              height: mq.size.height * 0.03,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: mq.size.width / 2.26,
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
                        prefixIcon: const Icon(Icons.calendar_month_outlined),
                        prefixIconColor: Colors.grey,
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
                          borderSide:
                              const BorderSide(width: 1.5, color: Colors.red),
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
                      var dateTime = themeState.getDarkTheme
                          ? await ligtModeDatepicker(themeState, context)
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
                  width: mq.size.width / 2.26,
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
                        prefixIcon: const Icon(Icons.calendar_month_outlined),
                        prefixIconColor: Colors.grey,
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
                          borderSide:
                              const BorderSide(width: 1.5, color: Colors.red),
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
                      var dateTime = themeState.getDarkTheme
                          ? await ligtModeDatepicker(themeState, context)
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
              height: mq.size.height * 0.03,
            ),
            TextFormField(
              controller: adults,
              readOnly: true,
              decoration: InputDecoration(
                  hintText: "ROOMS AND GUESTS",
                  hintStyle: TextStyle(
                    color: themeState.getDarkTheme
                        ? Colors.white54
                        : Colors.black54,
                  ),
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 17, horizontal: 15),
                  prefixIcon: const Icon(Icons.person),
                  prefixIconColor: Colors.grey,
                  border: OutlineInputBorder(
                      borderSide:
                          const BorderSide(width: 1.5, color: Colors.black12),
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
                    borderSide: const BorderSide(width: 1.5, color: Colors.red),
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

                
              },
            ),
            SizedBox(
              height: mq.size.height * 0.03,
            ),
            SizedBox(
              width: mq.size.width,
              height: 52,
              child: commenButton(
                title: "Search",
                callback: () {},
              ),
            )
          ],
        ),
      ),
    );
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
