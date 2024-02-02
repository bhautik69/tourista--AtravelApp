import 'package:demo/Screen/Navigationpages/home/Flight/flight_search.dart';
import 'package:demo/provider/dark_theme_provider.dart';
import 'package:demo/widget/bottomSheet.dart';
import 'package:demo/widget/button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class Fligthtab extends StatefulWidget {
  const Fligthtab({super.key});
  @override
  State<Fligthtab> createState() => _FligthtabState();
}

class _FligthtabState extends State<Fligthtab> {
  String flightClass = "";
  int count = 0;
  TextEditingController flightfrom = TextEditingController();
  TextEditingController flightTo = TextEditingController();
  TextEditingController date = TextEditingController();
  TextEditingController traveller = TextEditingController();
  GlobalKey<FormState> flightkey = GlobalKey();

  bool _dateFieldTouched = false;
  bool _flightFromField = false;
  bool _flightToField = false;
  bool _dropdownField = false;
  bool _travellerField = false;

  List<String> classhint = <String>[
    "Economy",
    "Premium",
    "Business",
    "First Class"
  ];
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

  @override
  Widget build(BuildContext context) {
    final themeState = Provider.of<DarkThemeProvider>(context);
    var mq = MediaQuery.of(context);
    return Scaffold(
      body: SingleChildScrollView(
        child: Form(
          key: flightkey,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            child: Column(
              children: [
                TypeAheadFormField(
                  validator: (value) {
                    if (_flightFromField) {
                      if (value == null || value.isEmpty) {
                        return "*Required Field...";
                      } else if (!RegExp(r"^[a-zA-Z._ +]+$").hasMatch(value)) {
                        return "*Enter valid name...";
                      } else {
                        return null;
                      }
                    }
                    return null;
                  },
                  textFieldConfiguration: TextFieldConfiguration(
                    controller: flightfrom,
                    onTap: () {
                      setState(() {
                        _flightFromField = false;
                        flightkey.currentState!.validate();
                      });
                    },
                    decoration: InputDecoration(
                        hintText: "Where From?",
                        hintStyle: TextStyle(
                          color: themeState.getDarkTheme
                              ? Colors.white54
                              : Colors.black54,
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 15, horizontal: 15),
                        prefixIcon: Icon(Icons.flight_takeoff_rounded,
                            size: 25,
                            color: themeState.getDarkTheme
                                ? Colors.white
                                : Colors.black),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: const BorderSide(
                                width: 1.5, color: Colors.black)),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: BorderSide(
                                width: 1.5,
                                color: themeState.getDarkTheme
                                    ? Colors.white
                                    : Colors.black)),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: BorderSide(
                                width: 1.5,
                                color: themeState.getDarkTheme
                                    ? Colors.white
                                    : Colors.black38)),
                        errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: const BorderSide(
                                width: 1.5, color: Colors.red))),
                  ),
                  suggestionsCallback: getSuggestion,
                  itemBuilder: (context, itemData) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 6, horizontal: 16),
                      child: Row(
                        children: [
                          Icon(
                            Icons.flight_takeoff_rounded,
                            size: 25,
                            color: themeState.getDarkTheme
                                ? Colors.white
                                : Colors.black,
                          ),
                          const SizedBox(width: 10),
                          Text(
                            itemData,
                            style: TextStyle(
                              fontSize: 17,
                              color: themeState.getDarkTheme
                                  ? Colors.white
                                  : Colors.black54,
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                  onSuggestionSelected: (item) {
                    flightfrom.text = item;
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                TypeAheadFormField(
                  validator: (value) {
                    if (_flightToField) {
                      if (value == null || value.isEmpty) {
                        return "*Required Field...";
                      } else if (!RegExp(r"^[a-zA-Z._ +]+$").hasMatch(value)) {
                        return "*Enter valid name...";
                      } else if (flightfrom.text == flightTo.text) {
                        return "*Both places are same...";
                      }
                      return null;
                    }
                    return null;
                  },
                  textFieldConfiguration: TextFieldConfiguration(
                    controller: flightTo,
                    onTap: () {
                      setState(() {
                        _flightToField = false;
                        flightkey.currentState!.validate();
                      });
                    },
                    decoration: InputDecoration(
                        hintText: "Where To?",
                        hintStyle: TextStyle(
                          color: themeState.getDarkTheme
                              ? Colors.white54
                              : Colors.black54,
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 15, horizontal: 15),
                        prefixIcon: Icon(Icons.flight_land_rounded,
                            size: 25,
                            color: themeState.getDarkTheme
                                ? Colors.white
                                : Colors.black),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: const BorderSide(
                                width: 1.5, color: Colors.black)),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: BorderSide(
                                width: 1.5,
                                color: themeState.getDarkTheme
                                    ? Colors.white
                                    : Colors.black)),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: BorderSide(
                                width: 1.5,
                                color: themeState.getDarkTheme
                                    ? Colors.white
                                    : Colors.black38)),
                        errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: const BorderSide(
                                width: 1.5, color: Colors.red))),
                  ),
                  suggestionsCallback: getSuggestion,
                  itemBuilder: (context, itemData) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 6, horizontal: 16),
                      child: Row(
                        children: [
                          Icon(
                            Icons.flight_land_rounded,
                            size: 25,
                            color: themeState.getDarkTheme
                                ? Colors.white
                                : Colors.black,
                          ),
                          const SizedBox(width: 10),
                          Text(
                            itemData,
                            style: TextStyle(
                              fontSize: 17,
                              color: themeState.getDarkTheme
                                  ? Colors.white
                                  : Colors.black54,
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                  onSuggestionSelected: (item) {
                    flightTo.text = item;
                  },
                ),
                SizedBox(
                  height: mq.size.height * 0.03,
                ),
                TextFormField(
                  controller: date,
                  readOnly: true,
                  decoration: InputDecoration(
                      hintText: "Which Date?",
                      hintStyle: TextStyle(
                        color: themeState.getDarkTheme
                            ? Colors.white54
                            : Colors.black54,
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 15, horizontal: 15),
                      prefixIcon: Icon(Icons.calendar_month_outlined,
                          color: themeState.getDarkTheme
                              ? Colors.white
                              : Colors.black),
                      border: OutlineInputBorder(
                          borderSide:
                              const BorderSide(width: 1.5, color: Colors.black),
                          borderRadius: BorderRadius.circular(20)),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide(
                              width: 1.5,
                              color: themeState.getDarkTheme
                                  ? Colors.white
                                  : Colors.black38)),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide(
                              width: 1.5,
                              color: themeState.getDarkTheme
                                  ? Colors.white
                                  : Colors.black38)),
                      // errorStyle:
                      //   const TextStyle(color: Color(0xffB00020)),
                      errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide:
                            const BorderSide(width: 1.5, color: Colors.red),
                      )),
                  validator: (value) {
                    if (_dateFieldTouched) {
                      if (value == null || value.isEmpty) {
                        return "*Required Field...";
                      }
                      return null;
                    }
                    return null;
                  },
                  onTap: () async {
                    setState(() {
                      _dateFieldTouched = false;
                      flightkey.currentState?.validate();
                    });
                    var dateTime = await showDatePicker(

                        /* builder: (BuildContext context,Widget? child) {
                                          return Theme(data: ThemeData().copyWith(colorScheme: ColorScheme.light(
                                            primary: Color(0xff0078aa),
                                            onPrimary: Colors.white,
                
                                            onSurface: Colors.black,
                
                                          )), child:child,
                                          );
                                        },*/

                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime.now(),
                        lastDate: DateTime(2025, 5));

                    date.text =
                        "${dateTime?.day}-${dateTime?.month}-${dateTime!.year}";
                  },
                ),
                SizedBox(
                  height: mq.size.height * 0.03,
                ),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: mq.size.width / 2.3,
                        child: DropdownButtonFormField(
                          validator: (value) {
                            if (_dropdownField) {
                              if (value == null || value.isEmpty) {
                                return "*Required Field...";
                              }
                              return null;
                            }
                            return null;
                          },
                          onTap: () {
                            setState(() {
                              _dropdownField = false;
                              flightkey.currentState!.validate();
                            });
                          },
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 15, horizontal: 15),
                            hintText: "Class",
                            hintStyle: TextStyle(
                              color: themeState.getDarkTheme
                                  ? Colors.white54
                                  : Colors.black54,
                            ),
                            border: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    width: 1.5, color: Colors.black12),
                                borderRadius: BorderRadius.circular(20)),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide: BorderSide(
                                    width: 1.5,
                                    color: themeState.getDarkTheme
                                        ? Colors.white54
                                        : Colors.black54)),
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide: BorderSide(
                                    width: 1.5,
                                    color: themeState.getDarkTheme
                                        ? Colors.white54
                                        : Colors.black54)),
                            // errorStyle:
                            //     const TextStyle(color: Color(0xffB00020)),
                            errorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: const BorderSide(
                                  width: 1.5, color: Colors.red),
                            ),
                          ),
                          dropdownColor: Colors.white,
                          items: classhint
                              .map((e) => DropdownMenuItem<String>(
                                  value: e, child: Text(e)))
                              .toList(),
                          onChanged: (value) {
                            setState(() {
                              flightClass = value.toString();
                            });
                          },
                        ),
                      ),
                      SizedBox(
                        width: mq.size.width / 2.3,
                        child: TextFormField(
                          keyboardType: TextInputType.none,
                          showCursor: false,
                          validator: (value) {
                            if (_travellerField) {
                              if (count <= 0) {
                                return "Select Traveller...";
                              }
                              return null;
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                              hintText: "$count Traveller",
                              hintStyle: TextStyle(
                                color: themeState.getDarkTheme
                                    ? Colors.white54
                                    : Colors.black54,
                              ),
                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: 15, horizontal: 15),
                              prefixIcon: Icon(Icons.person,
                                  color: themeState.getDarkTheme
                                      ? Colors.white
                                      : Colors.black),
                              border: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      width: 1.5, color: Colors.black12),
                                  borderRadius: BorderRadius.circular(20)),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20),
                                  borderSide: BorderSide(
                                      width: 1.5,
                                      color: themeState.getDarkTheme
                                          ? Colors.white54
                                          : Colors.black54)),
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20),
                                  borderSide: BorderSide(
                                      width: 1.5,
                                      color: themeState.getDarkTheme
                                          ? Colors.white54
                                          : Colors.black54)),
                              // errorStyle:
                              //     const TextStyle(color: Color(0xffB00020)),
                              errorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide: const BorderSide(
                                    width: 1.5, color: Colors.red),
                              )),
                          onTap: () {
                            _travellerField = false;
                            flightkey.currentState!.validate();
                            showBottomSheet(
                              context: context,
                              backgroundColor: Colors.white,
                              shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(20),
                                      topRight: Radius.circular(20))),
                              builder: (context) {
                                return bottomSheet(
                                  myQuantity: (qua) {
                                    setState(() {
                                      count = qua;
                                    });
                                  },
                                );
                              },
                            );
                          },
                        ),
                      ),
                    ]),
                SizedBox(
                  height: mq.size.height * 0.03,
                ),
                SizedBox(
                  width: mq.size.width,
                  height: 52,
                  child: commenButton(
                    title: "Search",
                    callback: () {
                      setState(() {
                        _dateFieldTouched = true;
                        _flightFromField = true;
                        _flightToField = true;
                        _dropdownField = true;
                        _travellerField = true;
                      });
                      flightkey.currentState!.validate();
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const FlightSearch(),
                      ));
                    },
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
