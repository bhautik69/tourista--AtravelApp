import 'package:demo/provider/dark_theme_provider.dart';
import 'package:demo/widget/button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:provider/provider.dart';

class Fligthtab extends StatefulWidget {
  const Fligthtab({super.key});

  @override
  State<Fligthtab> createState() => _FligthtabState();
}

class _FligthtabState extends State<Fligthtab> {
  
  
  String flightClass = "";
 
  
  TextEditingController flightfrom = TextEditingController();
  TextEditingController flightTo = TextEditingController();
  TextEditingController date = TextEditingController();
  GlobalKey<FormState> flightkey = GlobalKey();
  
  bool _dateFieldTouched = false;
  
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
    return   SingleChildScrollView(
              child: Form(
                key: flightkey,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                  child: Column(
                    children: [
                      TypeAheadFormField(
                        textFieldConfiguration: TextFieldConfiguration(
                          controller: flightfrom,
                          decoration: InputDecoration(
                              labelText: "Where From?",
                              labelStyle: TextStyle(
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
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20),
                                  borderSide: BorderSide(
                                      width: 2,
                                      color: themeState.getDarkTheme
                                          ? Colors.white
                                          : Colors.black)),
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20),
                                  borderSide: BorderSide(
                                      width: 2,
                                      color: themeState.getDarkTheme
                                          ? Colors.white
                                          : Colors.black38)),
                              errorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20),
                                  borderSide: const BorderSide(
                                      width: 2, color: Colors.red))),
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
                        textFieldConfiguration: TextFieldConfiguration(
                          controller: flightTo,
                          decoration: InputDecoration(
                              labelText: "Where To?",
                              labelStyle: TextStyle(
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
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20),
                                  borderSide: BorderSide(
                                      width: 2,
                                      color: themeState.getDarkTheme
                                          ? Colors.white
                                          : Colors.black)),
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20),
                                  borderSide: BorderSide(
                                      width: 2,
                                      color: themeState.getDarkTheme
                                          ? Colors.white
                                          : Colors.black38)),
                              errorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20),
                                  borderSide: const BorderSide(
                                      width: 2, color: Colors.red))),
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
                          flightfrom.text = item;
                        },
                      ),
                      SizedBox(
                        height: mq.size.height * 0.03,
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
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 15, horizontal: 15),
                            prefixIcon:
                                const Icon(Icons.calendar_month_outlined),
                            prefixIconColor: Colors.grey,
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
                            //   const TextStyle(color: Color(0xffB00020)),
                            errorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
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
                                hint: const Text("Class"),
                                decoration: InputDecoration(
                                  contentPadding: const EdgeInsets.symmetric(
                                      vertical: 16.5, horizontal: 15),

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
                                  //   const TextStyle(color: Color(0xffB00020)),
                                  errorBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20),
                                    borderSide: const BorderSide(
                                        width: 1.5, color: Colors.red),
                                  ),
                                  labelStyle: TextStyle(
                                      color: themeState.getDarkTheme
                                          ? Colors.white54
                                          : Colors.black54,
                                      fontWeight: FontWeight.w500),
                                ),
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
                                decoration: InputDecoration(
                                    hintText: "1 Traveller",
                                    hintStyle: TextStyle(
                                      color: themeState.getDarkTheme
                                          ? Colors.white54
                                          : Colors.black54,
                                    ),
                                    contentPadding: const EdgeInsets.symmetric(
                                        vertical: 15, horizontal: 15),
                                    prefixIcon: const Icon(Icons.person),
                                    prefixIconColor: Colors.grey,
                                    border: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                            width: 1.5, color: Colors.black12),
                                        borderRadius:
                                            BorderRadius.circular(20)),
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
                                    //   const TextStyle(color: Color(0xffB00020)),
                                    errorBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(20),
                                      borderSide: const BorderSide(
                                          width: 1.5, color: Colors.red),
                                    )),
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
                          callback: () {},
                        ),
                      )
                    ],
                  ),
                ),
              ),
            )
  ;
  }
}