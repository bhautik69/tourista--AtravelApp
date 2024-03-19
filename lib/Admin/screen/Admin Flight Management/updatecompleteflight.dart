import 'package:demo/models/Flight%20models/addFlight.dart';
import 'package:demo/provider/dark_theme_provider.dart';
import 'package:demo/widget/button.dart';
import 'package:demo/widget/textwidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:iconly/iconly.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class UpdateCompleteflight extends StatefulWidget {
  String? id;
  AddFlight? addFlight;
  UpdateCompleteflight({super.key, this.id, this.addFlight});

  @override
  State<UpdateCompleteflight> createState() => _UpdateCompleteflightState();
}

class _UpdateCompleteflightState extends State<UpdateCompleteflight> {
  var startingFrom = TextEditingController();
  var travelingTo = TextEditingController();
  var flightNumber = TextEditingController();
  var startDate = TextEditingController();
  var endDate = TextEditingController();

  var takeoffTime = TextEditingController();
  var landingTime = TextEditingController();
  var price = TextEditingController();
  String? flightname;
  bool isLoading = false;

  final _formKey = GlobalKey<FormState>();
  bool validateMobile(String value) {
    String pattern = r'(?:\+91|0)?[9678]\d{9}$';
    RegExp regExp = RegExp(pattern);
    return regExp.hasMatch(value);
  }

  List<String> classhint = <String>[
    "Economy",
    "Premium",
    "Business",
    "First Class"
  ];

  List<String> flightName = <String>[
    "Indigo",
    "Air India",
    "Vistara",
    "Go First",
    "Air India Express",
    "Star Air",
    "SpiceJet",
    "TruJet"
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
  void initState() {
    startingFrom.text = widget.addFlight!.startingFrom!;
    travelingTo.text = widget.addFlight!.travelingTo!;
    flightNumber.text = widget.addFlight!.flightNumber!;
    startDate.text = widget.addFlight!.startDate!;
    endDate.text = widget.addFlight!.endDate!;

    takeoffTime.text = widget.addFlight!.takeoffTime!;
    landingTime.text = widget.addFlight!.landingTime!;
    price.text = widget.addFlight!.price!;
    flightname = widget.addFlight!.flightname!;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var mq = MediaQuery.of(context);
    final themeState = Provider.of<DarkThemeProvider>(context);
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 236, 235, 235),
      appBar: AppBar(
        title: const Text("Add New Flight"),
        centerTitle: true,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(IconlyLight.arrow_left_2)),
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                color: Colors.white,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                  child: Column(
                    children: [
                      const Titletext(title: "Flight Details"),
                      DropdownButtonFormField(
                        validator: (value) {
                          if (value == null) {
                            return "*Required Field";
                          }
                          return null;
                        },
                        dropdownColor: themeState.getDarkTheme
                            ? const Color(0xff212121)
                            : Colors.white,
                        decoration: InputDecoration(
                          label: const Text("Flight Name"),
                          focusedBorder: const UnderlineInputBorder(
                              borderSide: BorderSide(
                                  width: 1.5, color: Color(0xff0078aa))),
                          enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                  color: themeState.getDarkTheme
                                      ? Colors.white
                                      : Colors.black)),
                          labelStyle: TextStyle(
                              color: themeState.getDarkTheme
                                  ? Colors.white54
                                  : Colors.black54,
                              fontWeight: FontWeight.w500),
                        ),
                        items: flightName
                            .map((e) => DropdownMenuItem<String>(
                                value: e, child: Text(e)))
                            .toList(),
                        value: flightname!.isEmpty ? "" : flightname,
                        onChanged: (value) {
                          setState(() {
                            flightname = value.toString();
                          });
                        },
                      ),
                      TextFormField(
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "* required";
                          }
                          return null;
                        },
                        controller: flightNumber,
                        textAlignVertical: TextAlignVertical.bottom,
                        decoration: InputDecoration(
                            label: const Text("Flight Number"),
                            labelStyle: TextStyle(
                                color: themeState.getDarkTheme
                                    ? Colors.white54
                                    : Colors.black54,
                                fontWeight: FontWeight.w500),
                            focusedBorder: const UnderlineInputBorder(
                                borderSide: BorderSide(
                                    width: 1.5, color: Color(0xff0078aa))),
                            enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: themeState.getDarkTheme
                                        ? Colors.white
                                        : Colors.black))),
                      ),
                      TypeAheadFormField(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "*Required Field";
                          } else if (!RegExp(r"^[a-z,A-Z._ +-]+$")
                              .hasMatch(value)) {
                            return "*Enter valid name";
                          } else {
                            return null;
                          }
                        },
                        textFieldConfiguration: TextFieldConfiguration(
                          controller: startingFrom,
                          onTap: () {
                            setState(() {});
                          },
                          decoration: InputDecoration(
                              label: const Text("Starting from"),
                              labelStyle: TextStyle(
                                  color: themeState.getDarkTheme
                                      ? Colors.white54
                                      : Colors.black54,
                                  fontWeight: FontWeight.w500),
                              focusedBorder: const UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      width: 1.5, color: Color(0xff0078aa))),
                              enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color: themeState.getDarkTheme
                                          ? Colors.white
                                          : Colors.black))),
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
                          startingFrom.text = item;
                        },
                      ),
                      TypeAheadFormField(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "*Required Field";
                          } else if (!RegExp(r"^[a-z,A-Z._ +-]+$")
                              .hasMatch(value)) {
                            return "*Enter valid name";
                          } else if (startingFrom.text == travelingTo.text) {
                            return "*Origin and destination can't be the same";
                          } else {
                            return null;
                          }
                        },
                        textFieldConfiguration: TextFieldConfiguration(
                          controller: travelingTo,
                          onTap: () {
                            setState(() {});
                          },
                          decoration: InputDecoration(
                              label: const Text("Travelling To"),
                              labelStyle: TextStyle(
                                  color: themeState.getDarkTheme
                                      ? Colors.white54
                                      : Colors.black54,
                                  fontWeight: FontWeight.w500),
                              focusedBorder: const UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      width: 1.5, color: Color(0xff0078aa))),
                              enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color: themeState.getDarkTheme
                                          ? Colors.white
                                          : Colors.black))),
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
                          travelingTo.text = item;
                        },
                      ),
                      TextFormField(
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "* required";
                          }
                          return null;
                        },
                        controller: price,
                        keyboardType: TextInputType.number,
                        textAlignVertical: TextAlignVertical.bottom,
                        decoration: InputDecoration(
                            label: const Text("Price"),
                            labelStyle: TextStyle(
                                color: themeState.getDarkTheme
                                    ? Colors.white54
                                    : Colors.black54,
                                fontWeight: FontWeight.w500),
                            focusedBorder: const UnderlineInputBorder(
                                borderSide: BorderSide(
                                    width: 1.5, color: Color(0xff0078aa))),
                            enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: themeState.getDarkTheme
                                        ? Colors.white
                                        : Colors.black))),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: mq.size.height * 0.01,
              ),
              Container(
                  color: Colors.white,
                  child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 16),
                      child: Column(
                        children: [
                          const Titletext(title: "Flight Time Details"),
                          TextFormField(
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "* required";
                              }
                              return null;
                            },
                            readOnly: true,
                            controller: startDate,
                            onTap: () async {
                              var dateTime = await showDatePicker(
                                  builder:
                                      (BuildContext context, Widget? child) {
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
                                  lastDate: DateTime(2030));

                              startDate.text =
                                  "${dateTime?.day}-${dateTime?.month}-${dateTime!.year}";
                            },
                            textAlignVertical: TextAlignVertical.bottom,
                            decoration: InputDecoration(
                              label: const Text("Starting Date"),
                              focusedBorder: const UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      width: 1.5, color: Color(0xff0078aa))),
                              enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color: themeState.getDarkTheme
                                          ? Colors.white
                                          : Colors.black)),
                              labelStyle: TextStyle(
                                  color: themeState.getDarkTheme
                                      ? Colors.white54
                                      : Colors.black54,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                          TextFormField(
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "* required";
                              }
                              return null;
                            },
                            readOnly: true,
                            controller: endDate,
                            onTap: () async {
                              var dateTime = await showDatePicker(
                                  builder:
                                      (BuildContext context, Widget? child) {
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
                                  lastDate: DateTime(2030));

                              endDate.text =
                                  "${dateTime?.day}-${dateTime?.month}-${dateTime!.year}";
                            },
                            textAlignVertical: TextAlignVertical.bottom,
                            decoration: InputDecoration(
                              label: const Text("Ending Date"),
                              focusedBorder: const UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      width: 1.5, color: Color(0xff0078aa))),
                              enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color: themeState.getDarkTheme
                                          ? Colors.white
                                          : Colors.black)),
                              labelStyle: TextStyle(
                                  color: themeState.getDarkTheme
                                      ? Colors.white54
                                      : Colors.black54,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                          TextFormField(
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "* required";
                              }
                              return null;
                            },
                            readOnly: true,
                            controller: takeoffTime,
                            onTap: () async {
                              var pickedtime = await showTimePicker(
                                  context: context,
                                  initialTime: TimeOfDay.now(),
                                  initialEntryMode: TimePickerEntryMode.input);
                              if (pickedtime != null) {
                                String formattedTime =
                                    DateFormat('hh:mm a').format(
                                  DateTime(2024, 1, 1, pickedtime.hour,
                                      pickedtime.minute),
                                );
                                setState(() {
                                  takeoffTime.text = formattedTime;
                                });
                              }
                            },
                            textAlignVertical: TextAlignVertical.bottom,
                            decoration: InputDecoration(
                              label: const Text("Flight Takeoff Time"),
                              focusedBorder: const UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      width: 1.5, color: Color(0xff0078aa))),
                              enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color: themeState.getDarkTheme
                                          ? Colors.white
                                          : Colors.black)),
                              labelStyle: TextStyle(
                                  color: themeState.getDarkTheme
                                      ? Colors.white54
                                      : Colors.black54,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                          TextFormField(
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "* required";
                              }
                              return null;
                            },
                            readOnly: true,
                            controller: landingTime,
                            onTap: () async {
                              var pickedtime = await showTimePicker(
                                  context: context,
                                  initialTime: TimeOfDay.now(),
                                  initialEntryMode: TimePickerEntryMode.input);
                              if (pickedtime != null) {
                                String formattedTime =
                                    DateFormat('hh:mm a').format(
                                  DateTime(2024, 1, 1, pickedtime.hour,
                                      pickedtime.minute),
                                );
                                setState(() {
                                  landingTime.text = formattedTime;
                                });
                              }
                            },
                            textAlignVertical: TextAlignVertical.bottom,
                            decoration: InputDecoration(
                              label: const Text("Flight Landing Time"),
                              focusedBorder: const UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      width: 1.5, color: Color(0xff0078aa))),
                              enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color: themeState.getDarkTheme
                                          ? Colors.white
                                          : Colors.black)),
                              labelStyle: TextStyle(
                                  color: themeState.getDarkTheme
                                      ? Colors.white54
                                      : Colors.black54,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                        ],
                      ))),
              SizedBox(
                height: mq.size.height * 0.01,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: SizedBox(
                    height: 52,
                    width: MediaQuery.of(context).size.width,
                    child: commenButton(
                        title: "UPDATE",
                        loading: isLoading,
                        callback: () {
                          if (_formKey.currentState!.validate()) {
                            updateData();
                          }
                        })),
              ),
              const SizedBox(
                height: 25,
              )
            ],
          ),
        ),
      ),
    );
  }

  updateData() async {
    setState(() {
      isLoading = true;
    });

    await AddFlight.updateFlight(
            widget.id!,
            AddFlight(
                id: widget.id,
                startingFrom: startingFrom.text,
                travelingTo: travelingTo.text,
                flightNumber: flightNumber.text,
                startDate: startDate.text,
                endDate: endDate.text,
                takeoffTime: takeoffTime.text,
                landingTime: landingTime.text,
                price: price.text,
                flightname: flightname))
        .whenComplete(() {
      setState(() {
        isLoading = false;
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text("UPDATE SUCCESSFULLY")));
      });
    });
  }
}
