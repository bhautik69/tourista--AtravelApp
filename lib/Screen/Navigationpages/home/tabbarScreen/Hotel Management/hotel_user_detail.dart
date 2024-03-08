import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:ionicons/ionicons.dart';
import 'package:provider/provider.dart';

import '../../../../../provider/dark_theme_provider.dart';
import '../../../../../widget/button.dart';

// ignore: camel_case_types
typedef dataStore = Function(String gender, String Dob, String firstName, String lastName);

// ignore: must_be_immutable
class HotelUserDetail extends StatefulWidget {
  String traveller;
  String travellerNo;
  String age;
  bool visible;
  dataStore store;
  HotelUserDetail({super.key,required this.store,
      required this.traveller,
      required this.visible,
      required this.age,
      required this.travellerNo});

  @override
  State<HotelUserDetail> createState() => _HotelUserDetailState();
}

class _HotelUserDetailState extends State<HotelUserDetail> {
  static const List<String> list = <String>[
    'Male',
    'Female',
  ];

  final _formKey = GlobalKey<FormState>();
  var f_name = TextEditingController();
  var l_name = TextEditingController();
  var date = TextEditingController();
  var childyear;
  String gender = "";
  //bool _nameFieldTouched = false;
  RegExp name = RegExp(r'[!@#<>?":_`~;[\]\\|=+)(*&^%0-9-]');
  bool validateStructurename(String nam) {
    String nm = nam.trim();
    if (name.hasMatch(nm)) {
      return true;
    } else {
      return false;
    }
  }
  @override
  Widget build(BuildContext context) {
     var mq = MediaQuery.of(context);
    final themeState = Provider.of<DarkThemeProvider>(context);
   return Scaffold(
      appBar: AppBar(
          title: const Text("Traveller details"),
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(IconlyLight.arrow_left_2,
                  color: Colors.white))), // centerTitle: true,

      body: Form(
        autovalidateMode: AutovalidateMode.always,
        key: _formKey,
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: mq.size.height * 0.028,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: mq.size.height * 0.012,
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        // mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            "assets/img/user1.png",
                            scale: 22.5,
                            color: themeState.getDarkTheme
                                ? Colors.white
                                : Colors.black,
                          ),
                          SizedBox(
                            width: mq.size.width * 0.05,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                widget.travellerNo,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 17),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 5),
                                child: Text(widget.traveller),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: mq.size.height * 0.038,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: mq.size.height * 0.012,
                      ),
                      child: const Text(
                        "First name",
                        style: TextStyle(
                            fontWeight: FontWeight.w500, fontSize: 15),
                      ),
                    ),
                    SizedBox(
                      height: mq.size.height * 0.01,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: mq.size.height * 0.012,
                      ),
                      child: TextFormField(
                        controller: f_name,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Add first name for this traveller to continue';
                          } else {
                            if (validateStructurename(value)) {
                              return "Enter your name without any special characters";
                            } else {
                              return null;
                            }
                          }
                        },
                        decoration: InputDecoration(
                            prefixIcon: const Icon(Icons.person),
                            hintText: "Enter First name",
                            hintStyle: TextStyle(
                              color: themeState.getDarkTheme
                                  ? Colors.white54
                                  : Colors.black54,
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 17, horizontal: 15),
                            //  prefixIconColor: Colors.grey,
                            border: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    width: 1.5, color: Colors.black12),
                                borderRadius: BorderRadius.circular(2)),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(2),
                                borderSide: BorderSide(
                                    width: 1.5,
                                    color: themeState.getDarkTheme
                                        ? Colors.white54
                                        : Colors.black54)),
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(2),
                                borderSide: BorderSide(
                                    width: 1.5,
                                    color: themeState.getDarkTheme
                                        ? Colors.white54
                                        : Colors.black54)),
                            // errorStyle:
                            //   const TextStyle(color: Color(0xffB00020)),
                            errorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(2),
                              borderSide: const BorderSide(
                                  width: 1.5, color: Colors.red),
                            )),
                        onTap: () async {},
                      ),
                    ),
                    SizedBox(
                      height: mq.size.height * 0.025,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: mq.size.height * 0.012,
                      ),
                      child: const Text(
                        "Last name",
                        style: TextStyle(
                            fontWeight: FontWeight.w500, fontSize: 15),
                      ),
                    ),
                    SizedBox(
                      height: mq.size.height * 0.01,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: mq.size.height * 0.012,
                      ),
                      child: TextFormField(
                        controller: l_name,
                        decoration: InputDecoration(
                            hintText: "Enter last name",
                            hintStyle: TextStyle(
                              color: themeState.getDarkTheme
                                  ? Colors.white54
                                  : Colors.black54,
                            ),
                            prefixIcon: const Icon(Icons.person),
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 17, horizontal: 15),
                            //  prefixIconColor: Colors.grey,
                            border: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    width: 1.5, color: Colors.black12),
                                borderRadius: BorderRadius.circular(2)),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(2),
                                borderSide: BorderSide(
                                    width: 1.5,
                                    color: themeState.getDarkTheme
                                        ? Colors.white54
                                        : Colors.black54)),
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(2),
                                borderSide: BorderSide(
                                    width: 1.5,
                                    color: themeState.getDarkTheme
                                        ? Colors.white54
                                        : Colors.black54)),
                            // errorStyle:
                            //   const TextStyle(color: Color(0xffB00020)),
                            errorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(2),
                              borderSide: const BorderSide(
                                  width: 1.5, color: Colors.red),
                            )),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Add last name for this traveller to continue';
                          } else {
                            if (validateStructurename(value)) {
                              return "Enter your name without any special characters";
                            } else {
                              return null;
                            }
                          }
                        },
                        onTap: () async {},
                      ),
                    ),
                    SizedBox(
                      height: mq.size.height * 0.025,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: mq.size.height * 0.012,
                      ),
                      child: const Text(
                        "Gender specified on your passport/ID",
                        style: TextStyle(
                            fontWeight: FontWeight.w500, fontSize: 15),
                      ),
                    ),
                    SizedBox(
                      height: mq.size.height * 0.01,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: mq.size.height * 0.012,
                      ),
                      child: DropdownButtonFormField(
                        dropdownColor: themeState.getDarkTheme
                            ? const Color(0xff212121)
                            : Colors.white,

                        decoration: InputDecoration(
                            //hintText: "Enter last name",
                            hintStyle: TextStyle(
                              color: themeState.getDarkTheme
                                  ? Colors.white54
                                  : Colors.black54,
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 14.5, horizontal: 15),
                            prefixIcon: const Icon(Ionicons.male_female),
                            //  prefixIconColor: Colors.grey,0
                            border: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    width: 1.5, color: Colors.black12),
                                borderRadius: BorderRadius.circular(2)),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(2),
                                borderSide: BorderSide(
                                    width: 1.5,
                                    color: themeState.getDarkTheme
                                        ? Colors.white54
                                        : Colors.black54)),
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(2),
                                borderSide: BorderSide(
                                    width: 1.5,
                                    color: themeState.getDarkTheme
                                        ? Colors.white54
                                        : Colors.black54)),
                            // errorStyle:
                            //   const TextStyle(color: Color(0xffB00020)),
                            errorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(2),
                              borderSide: const BorderSide(
                                  width: 1.5, color: Colors.red),
                            )),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Add gender for this traveller to continue';
                          }
                          return null;
                        },
                        hint: const Text("Gender"),
                        items: list
                            .map((e) => DropdownMenuItem<String>(
                                value: e, child: Text(e)))
                            .toList(),
                        // value: list.first,
                        onChanged: (value) {
                          setState(() {
                            gender = value.toString();
                            setState(() {});
                          });
                        },
                      ),
                    ),
                    SizedBox(
                      height: mq.size.height * 0.025,
                    ),
                    Visibility(
                      visible: widget.visible,
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: mq.size.height * 0.012,
                        ),
                        child: const Text(
                          "Date of Birth",
                          style: TextStyle(
                              fontWeight: FontWeight.w500, fontSize: 15),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: mq.size.height * 0.01,
                    ),
                    Visibility(
                      visible: widget.visible,
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: mq.size.height * 0.012,
                        ),
                        child: TextFormField(
                          controller: date,
                          readOnly: true,
                          decoration: InputDecoration(
                              hintText: "Enter DOB",
                              hintStyle: TextStyle(
                                color: themeState.getDarkTheme
                                    ? Colors.white54
                                    : Colors.black54,
                              ),
                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: 17, horizontal: 15),
                              prefixIcon: const Icon(Icons.calendar_month_outlined),
                              //  prefixIconColor: Colors.grey,
                              border: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      width: 1.5, color: Colors.black12),
                                  borderRadius: BorderRadius.circular(2)),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(2),
                                  borderSide: BorderSide(
                                      width: 1.5,
                                      color: themeState.getDarkTheme
                                          ? Colors.white54
                                          : Colors.black54)),
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(2),
                                  borderSide: BorderSide(
                                      width: 1.5,
                                      color: themeState.getDarkTheme
                                          ? Colors.white54
                                          : Colors.black54)),
                              // errorStyle:
                              //   const TextStyle(color: Color(0xffB00020)),
                              errorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(2),
                                borderSide: const BorderSide(
                                    width: 1.5, color: Colors.red),
                              )),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Enter this passenger's date of birth";
                            } else {
                              if (DateTime.now().year - int.parse(widget.age) !=
                                  childyear) {
                                return "For the flight, adjust the child's birthdate; they'll be ${widget.age} years.";
                              }
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
                                firstDate: DateTime(DateTime.now().year -
                                    int.parse(widget.age)),
                                lastDate: DateTime.now());
                            childyear = dateTime?.year;
                            date.text =
                                "${dateTime?.day}-${dateTime?.month}-${dateTime!.year}";
                            setState(() {});
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                  color: themeState.getDarkTheme
                      ? const Color(0xff212121)
                      : const Color(0xffffffff),
                  boxShadow: [
                    BoxShadow(
                        offset: const Offset(5, 5),
                        color: themeState.getDarkTheme
                            ? Colors.white12
                            : Colors.black12)
                  ]),
              height: mq.size.height * 0.1,
              child: Column(children: [
                Container(
                    width: mq.size.width,
                    height: 3,
                    color: themeState.getDarkTheme
                        ? Colors.white12
                        : Colors.black12),
                SizedBox(
                  height: mq.size.height * 0.016,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: SizedBox(
                    height: mq.size.height * 0.067,
                    width: mq.size.width,
                    child: commenButton(
                      title: "Done",
                      callback: () {
                        if (_formKey.currentState!.validate()) {
                          widget.store(gender, date.text,f_name.text,l_name.text);
                          setState(() {});
                          Navigator.pop(context);
                        }
                      },
                    ),
                  ),
                )
              ]),
            )
          ],
        ),
      ),
    );
  
  }
}