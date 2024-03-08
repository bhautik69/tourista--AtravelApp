import 'package:demo/models/Trip%20models/packagemodel.dart';
import 'package:demo/provider/dark_theme_provider.dart';
import 'package:demo/widget/button.dart';
import 'package:demo/widget/textwidget.dart';
import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

// ignore: must_be_immutable
class UpdatePackageComplete extends StatefulWidget {
  String? id;
  Package? package;
  UpdatePackageComplete({super.key, this.id, this.package});

  @override
  State<UpdatePackageComplete> createState() => _UpdatePackageCompleteState();
}

class _UpdatePackageCompleteState extends State<UpdatePackageComplete> {
  List activityList = [];
  var numvalue = 1;
  var longitude = TextEditingController();
  var latitude = TextEditingController();
  var startingForm = TextEditingController();
  var retunefligthtime = TextEditingController();
  var retunereachfligthtime = TextEditingController();
  var retunefligthdate = TextEditingController();
  var retunefligthreachdate = TextEditingController();
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
  @override
  void initState() {
    retunefligthtime.text = widget.package!.retunfligthtime!;
    retunereachfligthtime.text = widget.package!.retunreachfligthtime!;
    retunefligthdate.text = widget.package!.retunfligthdate!;
    retunefligthreachdate.text = widget.package!.retunreachfligthdate!;
    activityList = widget.package!.ActivityList!;
    startingForm.text = widget.package!.startingForm!;
    travelingTo.text = widget.package!.traveligTo!;
    startDate.text = widget.package!.startDate!;
    endDate.text = widget.package!.endDate!;
    imgurl.text = widget.package!.imgUrl!;
    decs.text = widget.package!.decs!;
    img1.text = widget.package!.img1!;
    img2.text = widget.package!.img2!;
    img3.text = widget.package!.img3!;
    img4.text = widget.package!.img4!;
    flightdate.text = widget.package!.flightDate!;
    reachdate.text = widget.package!.reachDate!;
    flightTime.text = widget.package!.flightTime!;
    reachTime.text = widget.package!.reachTime!;
    hotelName.text = widget.package!.hotelName!;
    hotelImg.text = widget.package!.hotelImg!;
    hotelRate.text = widget.package!.hotelRate!;
    hotelAdd.text = widget.package!.hotelAdd!;
    hotelPhone.text = widget.package!.hotelPhone!;
    latitude.text = widget.package!.latitude!;
    longitude.text = widget.package!.longitude!;

    price.text = widget.package!.price!;
    getnumlist();
    getactivitydata();
    setState(() {});
    super.initState();
  }

  getactivitydata() {
    for (int i = 0; i < activityList.length + 1; i++) {
      if (numvalue == i) {
        activityname.text = activityList[i - 1]["activityname"];
        activityimg.text = activityList[i - 1]["activityImg"];
        activitydesc.text = activityList[i - 1]["activityDesc"];
        setState(() {});
      }
    }
  }

  updateactivitydata() {
    for (int i = 0; i < activityList.length + 1; i++) {
      if (numvalue == i) {
        activityList[i - 1]['activityname'] = activityname.text;
        activityList[i - 1]['activityImg'] = activityimg.text;
        activityList[i - 1]['activityDesc'] = activitydesc.text;
        setState(() {});
      }
    }
  }

  List numList = [];
  getnumlist() {
    for (int i = 1; i < activityList.length + 1; i++) {
      numList.add(i);
    }
  }

  @override
  Widget build(BuildContext context) {
    var mq = MediaQuery.of(context);
    final themeState = Provider.of<DarkThemeProvider>(context);
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 236, 235, 235),
      appBar: AppBar(
        title: const Text("Update packagr"),
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
                            controller: retunefligthreachdate,
                            onTap: () async {
                              var dateTime = await showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime.now(),
                                  lastDate: DateTime(2030));

                              retunefligthreachdate.text =
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
                              }
                              return null;
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
                            Padding(
                              padding: const EdgeInsets.only(right: 10),
                              child: SizedBox(
                                width: 50,
                                child: DropdownButtonFormField(
                                    alignment: Alignment.center,
                                    decoration: InputDecoration(
                                        labelStyle: TextStyle(
                                            color: themeState.getDarkTheme
                                                ? Colors.white54
                                                : Colors.black54,
                                            fontWeight: FontWeight.w500),
                                        focusedBorder:
                                            const UnderlineInputBorder(
                                                borderSide: BorderSide(
                                                    width: 1.5,
                                                    color: Color(0xff0078aa))),
                                        enabledBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                                color: themeState.getDarkTheme
                                                    ? Colors.white
                                                    : Colors.black))),
                                    items: numList
                                        .map((e) => DropdownMenuItem(
                                            value: e.toString(),
                                            child: Text(e.toString())))
                                        .toList(),
                                    value: "1",
                                    onChanged: (value) {
                                      setState(() {
                                        numvalue = int.parse(value!);
                                        getactivitydata();
                                        updateactivitydata();
                                      });
                                    }),
                              ),
                            ),
                          ],
                        ),
                        TextFormField(
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "* required";
                            }
                            return null;
                          },
                          controller: activityname,
                          onChanged: (value) {
                            updateactivitydata();
                          },
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
                            if (value!.isEmpty) {
                              return "* required";
                            }
                            return null;
                          },
                          controller: activitydesc,
                          onChanged: (value) {
                            updateactivitydata();
                          },
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
                            if (value!.isEmpty) {
                              return "* required";
                            }
                            return null;
                          },
                          onChanged: (value) {
                            updateactivitydata();
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
                        title: "UPDATE",
                        loading: isloading,
                        callback: () {
                          if (_formKey.currentState!.validate()) {
                            update();
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

  update() async {
    setState(() {
      isloading = true;
    });
    await Package.updatePackage(
        widget.id!,
        Package(
          latitude: latitude.text,
          longitude: longitude.text,
          id: widget.id,
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
          retunfligthdate: retunefligthdate.text,
          retunreachfligthdate: retunefligthreachdate.text,
          retunfligthtime: retunefligthtime.text,
          retunreachfligthtime: retunereachfligthtime.text,
        )).whenComplete(() {
      setState(() {
        isloading = false;

        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text("UPDATE SUCCESSFULLY")));
      });
    });
  }

  }
