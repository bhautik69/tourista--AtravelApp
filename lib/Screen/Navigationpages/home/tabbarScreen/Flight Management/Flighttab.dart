import 'package:demo/Screen/Navigationpages/home/tabbarScreen/Flight%20Management/bottomSheet.dart';
import 'package:demo/Screen/Navigationpages/home/tabbarScreen/Flight%20Management/flight_search.dart';
import 'package:demo/provider/dark_theme_provider.dart';
import 'package:demo/provider/flight_traveller_datastore_.dart';

import 'package:demo/widget/button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

// ignore: must_be_immutable
class Fligthtab extends StatefulWidget {
  const Fligthtab({super.key});
  @override
  State<Fligthtab> createState() => _FligthtabState();
}

TextEditingController traveller = TextEditingController();

class _FligthtabState extends State<Fligthtab> {
  String? flightClass;
  int total = 0;
  int children = 0;
  int adult = 0;

  TextEditingController flightfrom = TextEditingController();
  TextEditingController flightTo = TextEditingController();
  TextEditingController date = TextEditingController();

  GlobalKey<FormState> flightkey = GlobalKey();

  List<String> classhint = <String>[
    "Economy",
    "Premium",
    "Business",
    "First Class"
  ];
  List airportlist = [
    "Agartala Airport, Agartala - IXA",
    "Ahmedabad Airport, Ahmedabad - AMD",
    "Biju Patnaik Airport, Bhubaneswar - BBI",
    "Calicut Airport, Kozhikode - CCJ",
    "Chandigarh Airport, Chandigarh - IXC",
    "Chennai Airport, Chennai - MAA",
    "Chhatrapati Shivaji Airport, Mumbai - BOM",
    "Cochin Airport, Kochi - COK",
    "Coimbatore Airport, Coimbatore - CJB",
    "Devi Ahilya Bai Holkar Airport, Indore - IDR",
    "Babasaheb Ambedkar Airport, Nagpur - NAG",
    "Goa Airport, Goa - GOI",
    "Imphal Airport, Imphal - IMF",
    "Indira Gandhi Airport, New Delhi - DEL",
    "Jaipur Airport, Jaipur - JAI",
    "Jodhpur Airport, Jodhpur - JDH",
    "Kempegowda Airport, Bengaluru - BLR",
    "Madurai Airport, Madurai - IXM",
    "Mangalore Airport, Mangalore - IXE",
    "Pune Airport, Pune - PNQ",
    "Rajiv Gandhi Airport, Hyderabad - HYD",
    "Rajkot Airport, Rajkot - RAJ",
    "Siliguri Bagdogra Airport, Bagdogra - IXB",
    "Surat Airport, Surat - STV",
    "Tiruchirappalli Airport, Tiruchirappalli - TRZ",
    "Trivandrum Airport, Thiruvananthapuram - TRV",
    "Vijayawada Airport, Vijayawada - VGA",
    "Visakhapatnam Airport, Visakhapatnam - VTZ"
  ];

  List<dynamic> getSuggestion(String query) =>
      List.of(airportlist).where((city) {
        final cityLower = city.toLowerCase();
        final queryLower = query.toLowerCase();
        return cityLower.startsWith(queryLower);
      }).toList();
  @override
  @override
  Widget build(BuildContext context) {
    final themeState = Provider.of<DarkThemeProvider>(context);
    var mq = MediaQuery.of(context);
    return Scaffold(
      body: SingleChildScrollView(
        child: Form(
          key: flightkey,
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: ChangeNotifierProvider<TravellerDataProvider>(
              create: (context) => TravellerDataProvider(),
              child: Consumer<TravellerDataProvider>(
                builder: (context, provider, child) {
                  return Column(
                    children: [
                      SizedBox(
                        height: mq.size.height * 0.02,
                      ),
                      TypeAheadFormField(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "*Required Field";
                          } else if (!RegExp(r"^[a-zA-Z._ ,+-]+$")
                              .hasMatch(value)) {
                            return "*Enter valid name";
                          } else {
                            return null;
                          }
                        },
                        textFieldConfiguration: TextFieldConfiguration(
                          controller: flightfrom,
                          decoration: InputDecoration(
                              hintText: "Where From?",
                              hintStyle: TextStyle(
                                color: themeState.getDarkTheme
                                    ? Colors.white54
                                    : Colors.black54,
                              ),
                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: 17, horizontal: 15),
                              prefixIcon:
                                  const Icon(Icons.flight_takeoff_outlined),
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
                        ),
                        suggestionsCallback: getSuggestion,
                        itemBuilder: (context, itemData) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 6, horizontal: 16),
                            child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
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
                            ),
                          );
                        },
                        onSuggestionSelected: (item) {
                          flightfrom.text = item;
                        },
                      ),
                      SizedBox(height: mq.size.height * 0.02),
                      TypeAheadFormField(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "*Required Field";
                          } else if (!RegExp(r"^[a-zA-Z._ ,+-]+$")
                              .hasMatch(value)) {
                            return "*Enter valid name";
                          } else if (flightfrom.text == flightTo.text) {
                            return "*Origin and destination can't be the same";
                          }
                          return null;
                        },
                        textFieldConfiguration: TextFieldConfiguration(
                          controller: flightTo,
                          decoration: InputDecoration(
                              hintText: "Where To?",
                              hintStyle: TextStyle(
                                color: themeState.getDarkTheme
                                    ? Colors.white54
                                    : Colors.black54,
                              ),
                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: 17, horizontal: 15),
                              prefixIcon:
                                  const Icon(Icons.flight_land_outlined),
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
                        ),
                        suggestionsCallback: getSuggestion,
                        itemBuilder: (context, itemData) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 6, horizontal: 16),
                            child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
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
                            ),
                          );
                        },
                        onSuggestionSelected: (item) {
                          flightTo.text = item;
                        },
                      ),
                      SizedBox(
                        height: mq.size.height * 0.02,
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
                                vertical: 17, horizontal: 15),
                            prefixIcon:
                                const Icon(Icons.calendar_month_outlined),
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
                          setState(() {});
                          var dateTime = await showDatePicker(
                              builder: (BuildContext context, Widget? child) {
                                return Theme(
                                  data: ThemeData().copyWith(
                                      colorScheme: const ColorScheme.light(
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
                              lastDate: DateTime(2025, 5));

                          date.text =
                              "${dateTime?.day}-${dateTime?.month}-${dateTime!.year}";
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
                                keyboardType: TextInputType.none,
                                showCursor: false,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return "Select Traveller";
                                  }
                                  return null;
                                },
                                controller: traveller,
                                readOnly: true,
                                decoration: InputDecoration(
                                    hintText: "Traveller",
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
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    PageRouteBuilder(
                                      pageBuilder: (context, animation,
                                              secondaryAnimation) =>
                                          bottomSheet(
                                        myQuantity: (t, c, a) {
                                          setState(() {
                                            total = t;

                                            adult = a;
                                            children = c;
                                            traveller.text = "$t Traveller";
                                          });
                                        },
                                      ),
                                      transitionsBuilder: (context, animation,
                                          secondaryAnimation, child) {
                                        const begin = Offset(0.0, 1.0);
                                        const end = Offset.zero;
                                        const curve = Curves.ease;
                                        var tween = Tween(
                                                begin: begin, end: end)
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

                                  // showBottomSheet(
                                  //   context: context,
                                  //   backgroundColor: Colors.white,
                                  //   shape: const RoundedRectangleBorder(
                                  //       borderRadius: BorderRadius.only(
                                  //           topLeft: Radius.circular(20),
                                  //           topRight: Radius.circular(20))),
                                  //   builder: (context) {
                                  //     return bottomSheet(
                                  //       myQuantity: (qua) {
                                  //         setState(() {
                                  //           count = qua;
                                  //         });
                                  //       },
                                  //     );
                                  // },
                                  // );
                                },
                              ),
                            ),
                            SizedBox(
                              width: mq.size.width / 2.2,
                              // height: 54,
                              child: DropdownButtonFormField(
                                value: flightClass,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return "*Required Field";
                                  }
                                  return null;
                                },
                                onTap: () {
                                  setState(() {});
                                },
                                dropdownColor: themeState.getDarkTheme
                                    ? const Color(0xff212121)
                                    : Colors.white,
                                decoration: InputDecoration(
                                    hintText: "Class",
                                    contentPadding: const EdgeInsets.symmetric(
                                        vertical: 14.5, horizontal: 15),
                                    //  prefixIcon: const Icon(Icons.star),
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
                                items: classhint
                                    .map((e) => DropdownMenuItem<String>(
                                        value: e, child: Text(e)))
                                    .toList(),
                                onChanged: (value) {
                                  setState(() {
                                    flightClass = value.toString();
                                    classType = flightClass.toString();
                                  });
                                },
                              ),
                            ),
                          ]),
                      SizedBox(
                        height: mq.size.height * 0.02,
                      ),
                      SizedBox(
                        width: mq.size.width,
                        height: 52,
                        child: commenButton(
                          title: "Search",
                          callback: () async {
                            setState(() {});
                            if (flightkey.currentState!.validate()) {
                              var prefs = await SharedPreferences.getInstance();
                              prefs.setInt("total", total);
                              prefs.setInt("children" ,children);
                              prefs.setInt("adult", adult);
                               indexFlightDate=date.text+flightfrom.text+flightTo.text+flightClass!;
                              // ignore: use_build_context_synchronously
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => FlightSearch(
                                    classname: flightClass,
                                    startingfrom: flightfrom.text,
                                    takeoffdate: date.text,
                                    travellingto: flightTo.text,
                                    traveller: traveller.text),
                              ));
                            }
                          },
                        ),
                      )
                    ],
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}

String classType = "";
Map<String, int> seatCount = {
  "Economy": 13 * 3,
  "Premium": 5 * 3,
  "Business": 3 * 3,
  "First Class": 10 * 3
};
