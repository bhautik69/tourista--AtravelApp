import 'package:demo/models/Trip%20models/packagemodel.dart';
import 'package:demo/provider/dark_theme_provider.dart';
import 'package:demo/widget/button.dart';
import 'package:demo/widget/textwidget.dart';
import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

class AddPackage extends StatefulWidget {
  const AddPackage({super.key});

  @override
  State<AddPackage> createState() => _AddPackageState();
}

class _AddPackageState extends State<AddPackage> {
  var retunefligthtime = TextEditingController();
  var longitude = TextEditingController();
  var latitude = TextEditingController();
  var retunereachfligthtime = TextEditingController();
  var startingForm = TextEditingController();
  var retunefligthdate = TextEditingController();
  var retunereachfligthdate = TextEditingController();
  var travelingTo = TextEditingController();
  var startDate = TextEditingController();
  var endDate = TextEditingController();
  var imgurl = TextEditingController();
  var decs = TextEditingController();
  var img1 = TextEditingController();
  var img2 = TextEditingController();
  var img3 = TextEditingController();
  var img4 = TextEditingController();
  var flightdate = TextEditingController();
  var reachdate = TextEditingController();
  var flightTime = TextEditingController();
  var reachTime = TextEditingController();
  var hotelName = TextEditingController();
  var hotelImg = TextEditingController();
  var hotelRate = TextEditingController();
  var hotelAdd = TextEditingController();
  var hotelPhone = TextEditingController();
  var activityname = TextEditingController();
  var activityimg = TextEditingController();
  var activitydesc = TextEditingController();
  var price = TextEditingController();
  bool isloading = false;

  final _formKey = GlobalKey<FormState>();
  var uuid = const Uuid();
  List<Map<String, dynamic>> activityList = [];
  bool validateMobile(String value) {
    String pattern = r'(?:\+91|0)?[9678]\d{9}$';
    RegExp regExp = RegExp(pattern);
    return regExp.hasMatch(value);
  }

  @override
  Widget build(BuildContext context) {
    var mq = MediaQuery.of(context);
    final themeState = Provider.of<DarkThemeProvider>(context);
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 236, 235, 235),
      appBar: AppBar(
        title: const Text("Add New Trip"),
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
                      const Titletext(title: "Normal Details"),
                      TextFormField(
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "* required";
                          }
                          return null;
                        },
                        controller: startingForm,
                        textAlignVertical: TextAlignVertical.bottom,
                        decoration: InputDecoration(
                            label: const Text("STARTING FROM"),
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
                      TextFormField(
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "* required";
                          }
                          return null;
                        },
                        controller: travelingTo,
                        textAlignVertical: TextAlignVertical.bottom,
                        decoration: InputDecoration(
                            label: const Text("TRAVELLING TO"),
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
                              lastDate: DateTime(2030));

                          startDate.text =
                              "${dateTime?.day}-${dateTime?.month}-${dateTime!.year}";
                        },
                        textAlignVertical: TextAlignVertical.bottom,
                        decoration: InputDecoration(
                          label: const Text("STARTING DATE"),
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
                              lastDate: DateTime(2030));

                          endDate.text =
                              "${dateTime?.day}-${dateTime?.month}-${dateTime!.year}";
                        },
                        textAlignVertical: TextAlignVertical.bottom,
                        decoration: InputDecoration(
                          label: const Text("ENDING DATE"),
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
                        controller: imgurl,
                        textAlignVertical: TextAlignVertical.bottom,
                        decoration: InputDecoration(
                            label: const Text("IMG URL"),
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
                      TextFormField(
                        minLines: 1,
                        maxLines: 5,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "* required";
                          }
                          return null;
                        },
                        controller: decs,
                        textAlignVertical: TextAlignVertical.bottom,
                        decoration: InputDecoration(
                            label: const Text("DESCRIPTION"),
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
                            label: const Text("PRICE"),
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
                          const Titletext(title: "Slider Image "),
                          TextFormField(
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "* required";
                              }
                              return null;
                            },
                            controller: img1,
                            textAlignVertical: TextAlignVertical.bottom,
                            decoration: InputDecoration(
                                label: const Text("IMG1"),
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
                          TextFormField(
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "* required";
                              }
                              return null;
                            },
                            controller: img2,
                            textAlignVertical: TextAlignVertical.bottom,
                            decoration: InputDecoration(
                                label: const Text("IMG2"),
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
                          TextFormField(
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "* required";
                              }
                              return null;
                            },
                            controller: img3,
                            textAlignVertical: TextAlignVertical.bottom,
                            decoration: InputDecoration(
                                label: const Text("IMG3"),
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
                          TextFormField(
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "* required";
                              }
                              return null;
                            },
                            controller: img4,
                            textAlignVertical: TextAlignVertical.bottom,
                            decoration: InputDecoration(
                                label: const Text("IMG4"),
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
                      ))),
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
                          const Titletext(title: "Flight Details"),
                          TextFormField(
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "* required";
                              }
                              return null;
                            },
                            readOnly: true,
                            controller: flightdate,
                            onTap: () async {
                              var dateTime = await showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime.now(),
                                  lastDate: DateTime(2030));

                              flightdate.text =
                                  "${dateTime?.day}-${dateTime?.month}-${dateTime!.year}";
                            },
                            textAlignVertical: TextAlignVertical.bottom,
                            decoration: InputDecoration(
                              label: const Text("FLIGHT DATE"),
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
                            controller: reachdate,
                            onTap: () async {
                              var dateTime = await showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime.now(),
                                  lastDate: DateTime(2030));

                              reachdate.text =
                                  "${dateTime?.day}-${dateTime?.month}-${dateTime!.year}";
                            },
                            textAlignVertical: TextAlignVertical.bottom,
                            decoration: InputDecoration(
                              label: const Text("REACH DATE"),
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
                            controller: flightTime,
                            onTap: () async {
                              var pickedtime = await showTimePicker(
                                  context: context,
                                  initialTime: TimeOfDay.now(),
                                  initialEntryMode: TimePickerEntryMode.input);
                              flightTime.text =
                                  "${pickedtime!.hour}:${pickedtime.minute}";
                            },
                            textAlignVertical: TextAlignVertical.bottom,
                            decoration: InputDecoration(
                              label: const Text("FLIGHT TIME"),
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
                            controller: reachTime,
                            onTap: () async {
                              var pickedtime = await showTimePicker(
                                  context: context,
                                  initialTime: TimeOfDay.now(),
                                  initialEntryMode: TimePickerEntryMode.input);
                              reachTime.text =
                                  "${pickedtime!.hour}:${pickedtime.minute}";
                            },
                            textAlignVertical: TextAlignVertical.bottom,
                            decoration: InputDecoration(
                              label: const Text("REACH TIME"),
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
              Container(
                  color: Colors.white,
                  child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 16),
                      child: Column(
                        children: [
                          const Titletext(title: "Return Flight Details"),
                          TextFormField(
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "* required";
                              }
                              return null;
                            },
                            readOnly: true,
                            controller: retunefligthdate,
                            onTap: () async {
                              var dateTime = await showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime.now(),
                                  lastDate: DateTime(2030));

                              retunefligthdate.text =
                                  "${dateTime?.day}-${dateTime?.month}-${dateTime!.year}";
                            },
                            textAlignVertical: TextAlignVertical.bottom,
                            decoration: InputDecoration(
                              label: const Text("FLIGHT DATE"),
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
                            controller: retunereachfligthdate,
                            onTap: () async {
                              var dateTime = await showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime.now(),
                                  lastDate: DateTime(2030));

                              retunereachfligthdate.text =
                                  "${dateTime?.day}-${dateTime?.month}-${dateTime!.year}";
                            },
                            textAlignVertical: TextAlignVertical.bottom,
                            decoration: InputDecoration(
                              label: const Text("REACH DATE"),
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
                            controller: retunefligthtime,
                            onTap: () async {
                              var pickedtime = await showTimePicker(
                                  context: context,
                                  initialTime: TimeOfDay.now(),
                                  initialEntryMode: TimePickerEntryMode.input);
                              retunefligthtime.text =
                                  "${pickedtime!.hour}:${pickedtime.minute}";
                            },
                            textAlignVertical: TextAlignVertical.bottom,
                            decoration: InputDecoration(
                              label: const Text("FLIGHT TIME"),
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
                            controller: retunereachfligthtime,
                            onTap: () async {
                              var pickedtime = await showTimePicker(
                                  context: context,
                                  initialTime: TimeOfDay.now(),
                                  initialEntryMode: TimePickerEntryMode.input);
                              retunereachfligthtime.text =
                                  "${pickedtime!.hour}:${pickedtime.minute}";
                            },
                            textAlignVertical: TextAlignVertical.bottom,
                            decoration: InputDecoration(
                              label: const Text("REACH TIME"),
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
              Container(
                  color: Colors.white,
                  child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 16),
                      child: Column(
                        children: [
                          const Titletext(title: "Hotel Details"),
                          TextFormField(
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "* required";
                              }
                              return null;
                            },
                            controller: hotelName,
                            textAlignVertical: TextAlignVertical.bottom,
                            decoration: InputDecoration(
                                label: const Text("NAME"),
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
                          TextFormField(
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "* required";
                              }
                              return null;
                            },
                            controller: hotelImg,
                            textAlignVertical: TextAlignVertical.bottom,
                            decoration: InputDecoration(
                                label: const Text("IMG"),
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
                          TextFormField(
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "* required";
                              }
                              return null;
                            },
                            controller: hotelRate,
                            keyboardType: TextInputType.number,
                            textAlignVertical: TextAlignVertical.bottom,
                            decoration: InputDecoration(
                                label: const Text("RATEING"),
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
                          TextFormField(
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "* required";
                              }
                              return null;
                            },
                            controller: hotelAdd,
                            textAlignVertical: TextAlignVertical.bottom,
                            decoration: InputDecoration(
                                label: const Text("ADDRESS"),
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
                          TextFormField(
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "* required";
                              } else {
                                if (!validateMobile(value)) {
                                  return 'Invalid mobile number';
                                } else {
                                  return null;
                                }
                              }
                            },
                            controller: hotelPhone,
                            keyboardType: TextInputType.number,
                            textAlignVertical: TextAlignVertical.bottom,
                            decoration: InputDecoration(
                                label: const Text("PHONE"),
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
                          TextFormField(
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "* required";
                              }
                              return null;
                            },
                            controller: latitude,
                            keyboardType: TextInputType.number,
                            textAlignVertical: TextAlignVertical.bottom,
                            decoration: InputDecoration(
                                label: const Text("LATITUDE"),
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
                          TextFormField(
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "* required";
                              }
                              return null;
                            },
                            controller: longitude,
                            keyboardType: TextInputType.number,
                            textAlignVertical: TextAlignVertical.bottom,
                            decoration: InputDecoration(
                                label: const Text("LONGITUDE"),
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
                      ))),
              SizedBox(
                height: mq.size.height * 0.01,
              ),
              Container(
                  color: Colors.white,
                  child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 16),
                      child: Column(children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const SizedBox(
                              width: 100,
                            ),
                            const Titletext(title: "Add Activity"),
                            const Spacer(),
                            TextButton(
                                onPressed: () {
                                  addActivity();
                                },
                                child: const Text("+ ADD"))
                          ],
                        ),
                        TextFormField(
                          validator: (value) {
                            if (activityList.isEmpty) {
                              if (value!.isEmpty) {
                                return "* required";
                              }
                              return null;
                            }
                            return null;
                          },
                          controller: activityname,
                          textAlignVertical: TextAlignVertical.bottom,
                          decoration: InputDecoration(
                              label: const Text("ACTIVITY NAME"),
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
                        TextFormField(
                          validator: (value) {
                            if (activityList.isEmpty) {
                              if (value!.isEmpty) {
                                return "* required";
                              }
                              return null;
                            }
                            return null;
                          },
                          controller: activitydesc,
                          textAlignVertical: TextAlignVertical.bottom,
                          decoration: InputDecoration(
                              label: const Text("ACTIVITY DESCRIPTION"),
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
                        TextFormField(
                          validator: (value) {
                            if (activityList.isEmpty) {
                              if (value!.isEmpty) {
                                return "* required";
                              }
                              return null;
                            }
                            return null;
                          },
                          controller: activityimg,
                          textAlignVertical: TextAlignVertical.bottom,
                          decoration: InputDecoration(
                              label: const Text("ACTIVITY IMG"),
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
                        )
                      ]))),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: SizedBox(
                    height: 52,
                    width: MediaQuery.of(context).size.width,
                    child: commenButton(
                        title: "ADD",
                        loading: isloading,
                        callback: () {
                          if (_formKey.currentState!.validate()) {
                            addActivity();
                            save();
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

  addActivity() {
    if (activityname.text.isNotEmpty &&
        activityimg.text.isNotEmpty &&
        activitydesc.text.isNotEmpty) {
      activityList.add({
        "activityname": activityname.text,
        "activityImg": activityimg.text,
        "activityDesc": activitydesc.text
      });

      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("ACTIVITY ADDED SUCCESSFULLY")));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("ENTER THE ACTIVITY DETAILS")));
    }
    activityname.clear();
    activitydesc.clear();
    activityimg.clear();
  }

  save() async {
    setState(() {
      isloading = true;
    });
    if (activityname.text.isNotEmpty &&
        activityimg.text.isNotEmpty &&
        activitydesc.text.isNotEmpty) {
      activityList.add({
        "activityname": activityname.text,
        "activityImg": activityimg.text,
        "activityDesc": activitydesc.text
      });

      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("ACTIVITY ADDED SUCCESSFULLY")));
    }
    await Package.addPackage(Package(
      isFavorite: false,
      id: uuid.v4(),
      startingForm: startingForm.text,
      traveligTo: travelingTo.text,
      startDate: startDate.text,
      endDate: endDate.text,
      imgUrl: imgurl.text,
      decs: decs.text,
      price: price.text,
      img1: img1.text,
      img2: img2.text,
      img3: img3.text,
      img4: img4.text,
      flightDate: flightdate.text,
      reachDate: reachdate.text,
      flightTime: flightTime.text,
      reachTime: reachTime.text,
      hotelName: hotelName.text,
      hotelImg: hotelImg.text,
      hotelAdd: hotelAdd.text,
      hotelPhone: hotelPhone.text,
      hotelRate: hotelRate.text,
      ActivityList: activityList,
      retunreachfligthdate: retunereachfligthdate.text,
      retunfligthtime: retunefligthtime.text,
      retunreachfligthtime: retunereachfligthtime.text,
      retunfligthdate: retunefligthdate.text,
      latitude: latitude.text,
      longitude: longitude.text,
    )).whenComplete(() {
      setState(() {
        isloading = false;
        clearFields();
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text("ADDED SUCCESSFULLY")));
      });
    });
  }

  clearFields() {
    setState(() {
      activityname.clear();
      activitydesc.clear();
      activityimg.clear();

      retunefligthtime.clear();
      retunefligthdate.clear();
      retunereachfligthdate.clear();
      retunereachfligthtime.clear();
      activityList.clear();
      startingForm.clear();
      travelingTo.clear();
      startDate.clear();
      endDate.clear();
      imgurl.clear();
      decs.clear();
      img1.clear();
      img2.clear();
      img3.clear();
      img4.clear();
      flightdate.clear();
      reachdate.clear();
      flightTime.clear();
      reachTime.clear();
      hotelName.clear();
      hotelImg.clear();
      hotelRate.clear();
      hotelAdd.clear();
      hotelPhone.clear();
      activityname.clear();
      activityimg.clear();
      activitydesc.clear();
      price.clear();
    });
  }
}
