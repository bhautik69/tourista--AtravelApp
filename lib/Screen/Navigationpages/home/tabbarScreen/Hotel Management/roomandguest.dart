import 'package:demo/Screen/Navigationpages/home/tabbarScreen/Hotel%20Management/childAgeSheethotel.dart';
import 'package:demo/provider/dark_theme_provider.dart';
import 'package:demo/widget/button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

typedef TotalRAC = Function(int rooms, int adults, int children);

// ignore: camel_case_types, must_be_immutable
class roomGuest extends StatefulWidget {
  TotalRAC totalRAC;
  roomGuest({
    super.key,
    required this.totalRAC,
  });

  @override
  State<roomGuest> createState() => _roomGuestState();
}

// ignore: camel_case_types
class _roomGuestState extends State<roomGuest> {
  int adultsCount = 1;
  int roomCount = 1;
  int childCount = 0;
  int qunt = 1;

  // int ages = 1;
  Map<int, TextEditingController> _controllers = {};

  void initState() {
    super.initState();
    // Initialize controllers with initial itemCount
    _initializeControllers();
  }

  void _initializeControllers() {
    for (int i = 0; i < childCount; i++) {
      if (!_controllers.containsKey(i)) {
        _controllers[i] = TextEditingController();
      }
    }
  }

  @override
  void dispose() {
    // Dispose controllers to prevent memory leaks
    _controllers.values.forEach((controller) => controller.dispose());
    super.dispose();
  }

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final themeState = Provider.of<DarkThemeProvider>(context);
    Color color1 = themeState.getDarkTheme ? Colors.white54 : Colors.black54;
    var mq = MediaQuery.of(context);
    return SafeArea(
      child: Scaffold(
        backgroundColor: themeState.getDarkTheme
            ? Color(0xff121212)
            : const Color(0xFFffffff),
        body: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.only(top: 22),
            child: Column(
              children: [
                Expanded(
                  child: NotificationListener(
                    onNotification: (OverscrollIndicatorNotification
                        overscrollIndicatorNotification) {
                      overscrollIndicatorNotification.disallowIndicator();
                      return true;
                    },
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context).pop();
                          },
                          child: const Padding(
                            padding: EdgeInsets.only(right: 15),
                            child: Align(
                              alignment: Alignment.topRight,
                              child: Text(
                                "Cancel",
                                style: TextStyle(
                                    fontSize: 16.5,
                                    color: Colors.blue,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: mq.size.height * 0.04,
                        ),
                        const Padding(
                          padding: EdgeInsets.only(left: 15),
                          child: Text(
                            "Select rooms and guests",
                            style: TextStyle(
                                fontSize: 23, fontWeight: FontWeight.bold),
                          ),
                        ),
                        SizedBox(
                          height: mq.size.height * 0.015,
                        ),
                        const Divider(
                          thickness: 1.5,
                        ),
                        Expanded(
                          child: SingleChildScrollView(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: mq.size.height * 0.02,
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 15),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "Rooms",
                                        style: TextStyle(
                                            fontSize: 15,
                                            color: themeState.getDarkTheme
                                                ? Colors.white
                                                : Colors.black,
                                            fontWeight: FontWeight.w500),
                                      ),
                                      Container(
                                          height: mq.size.height * 0.07,
                                          width: mq.size.width * 0.375,
                                          decoration: BoxDecoration(
                                              border: Border.all(
                                                  color: themeState.getDarkTheme
                                                      ? Colors.white54
                                                      : Colors.black54),
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                          child: Row(
                                            children: [
                                              IncrementAndDecrement(
                                                  color: roomCount == 1
                                                      ? color1
                                                      : Color(0xff0078aa),
                                                  onPressed: () {
                                                    if (roomCount > 1) {
                                                      setState(() {
                                                        roomCount--;
                                                      });
                                                    }
                                                  },
                                                  icon: Icons.remove),
                                              Text(
                                                roomCount.toString(),
                                                style: const TextStyle(
                                                    fontSize: 18),
                                              ),
                                              IncrementAndDecrement(
                                                  color: roomCount == 10
                                                      ? color1
                                                      : Color(0xff0078aa),
                                                  onPressed: () {
                                                    setState(() {
                                                      if (roomCount < 10) {
                                                        roomCount++;
                                                      }
                                                      if (roomCount >
                                                          adultsCount) {
                                                        adultsCount = roomCount;
                                                      }
                                                    });
                                                  },
                                                  icon: Icons.add),
                                            ],
                                          ))
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: mq.size.height * 0.02,
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 15),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "Adults",
                                        style: TextStyle(
                                            fontSize: 15,
                                            color: themeState.getDarkTheme
                                                ? Colors.white
                                                : Colors.black,
                                            fontWeight: FontWeight.w500),
                                      ),
                                      Container(
                                          height: mq.size.height * 0.07,
                                          width: mq.size.width * 0.375,
                                          decoration: BoxDecoration(
                                              border: Border.all(
                                                  color: themeState.getDarkTheme
                                                      ? Colors.white54
                                                      : Colors.black54),
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                          child: Row(
                                            children: [
                                              IncrementAndDecrement(
                                                  color: adultsCount == 1
                                                      ? color1
                                                      : Color(0xff0078aa),
                                                  onPressed: () {
                                                    if (adultsCount > 1) {
                                                      setState(() {
                                                        adultsCount--;
                                                      });

                                                      if (roomCount >
                                                          adultsCount) {
                                                        roomCount = adultsCount;
                                                      }
                                                    }
                                                  },
                                                  icon: Icons.remove),
                                              Text(
                                                adultsCount.toString(),
                                                style: const TextStyle(
                                                    fontSize: 18),
                                              ),
                                              IncrementAndDecrement(
                                                  color: adultsCount == 10
                                                      ? color1
                                                      : Color(0xff0078aa),
                                                  onPressed: () {
                                                    setState(() {
                                                      if (adultsCount < 10) {
                                                        adultsCount++;
                                                      }

                                                      /*  if (childCount +
                                                                      adultsCount >
                                                                  8 &&
                                                              roomCount == 1 ||
                                                          childCount +
                                                                      adultsCount >
                                                                  16 &&
                                                              roomCount <= 2 ||
                                                          childCount +
                                                                      adultsCount >
                                                                  24 &&
                                                              roomCount <= 3 ||
                                                          childCount +
                                                                      adultsCount >
                                                                  32 &&
                                                              roomCount <= 4 ||
                                                          childCount +
                                                                      adultsCount >
                                                                  40 &&
                                                              roomCount <= 5 ||
                                                          childCount +
                                                                      adultsCount >
                                                                  48 &&
                                                              roomCount <= 6 ||
                                                          childCount +
                                                                      adultsCount >
                                                                  56 &&
                                                              roomCount <= 7) {
                                                        roomCount++;
                                                      }*/
                                                    });
                                                  },
                                                  icon: Icons.add),
                                            ],
                                          ))
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: mq.size.height * 0.025,
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 15),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "Children",
                                        style: TextStyle(
                                            fontSize: 15,
                                            color: themeState.getDarkTheme
                                                ? Colors.white
                                                : Colors.black,
                                            fontWeight: FontWeight.w500),
                                      ),
                                      Container(
                                          height: mq.size.height * 0.07,
                                          width: mq.size.width * 0.375,
                                          decoration: BoxDecoration(
                                              border: Border.all(
                                                color: themeState.getDarkTheme
                                                    ? Colors.white54
                                                    : Colors.black54,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                          child: Row(
                                            children: [
                                              IncrementAndDecrement(
                                                  color: childCount == 0
                                                      ? color1
                                                      : Color(0xff0078aa),
                                                  onPressed: () {
                                                    if (childCount > 0) {
                                                      setState(() {
                                                        _controllers.remove(
                                                            childCount - 1);
                                                        childCount--;

                                                        _initializeControllers();
                                                      });
                                                    }
                                                  },
                                                  icon: Icons.remove),
                                              Text(
                                                childCount.toString(),
                                                style: const TextStyle(
                                                    fontSize: 18),
                                              ),
                                              IncrementAndDecrement(
                                                color: childCount == 20
                                                    ? color1
                                                    : Color(0xff0078aa),
                                                onPressed: () {
                                                  setState(() {
                                                    if (childCount < 20) {
                                                      childCount++;
                                                      _initializeControllers();
                                                    }
                                                    /* if (childCount + adultsCount >
                                                                8 &&
                                                            roomCount == 1 ||
                                                        childCount + adultsCount >
                                                                16 &&
                                                            roomCount <= 2 ||
                                                        childCount + adultsCount >
                                                                24 &&
                                                            roomCount <= 3 ||
                                                        childCount + adultsCount >
                                                                32 &&
                                                            roomCount <= 4 ||
                                                        childCount + adultsCount >
                                                                40 &&
                                                            roomCount <= 5 ||
                                                        childCount + adultsCount >
                                                                48 &&
                                                            roomCount <= 6 ||
                                                        childCount + adultsCount >
                                                                56 &&
                                                            roomCount <= 7) {
                                                      roomCount++;
                                                    }*/
                                                  });
                                                },
                                                icon: Icons.add,
                                              ),
                                            ],
                                          ))
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: mq.size.height * 0.045,
                                ),
                                Visibility(
                                  visible: childCount == 0 ? false : true,
                                  child: const Padding(
                                    padding: EdgeInsets.only(left: 15),
                                    child: Text(
                                      "Age of children at check-out",
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: mq.size.height * 0.011,
                                ),
                                Visibility(
                                  visible: childCount == 0 ? false : true,
                                  child: const Padding(
                                    padding: EdgeInsets.only(left: 15),
                                    child: Text(
                                      "Child ages will be used to find you the best match in beds, room size and special prices.",
                                      style: TextStyle(
                                          // fontSize: 16,
                                          fontWeight: FontWeight.w400),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 5),
                                  child: ListView.builder(
                                    itemCount: childCount,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    itemBuilder: (context, index) {
                                      return Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 15),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            SizedBox(
                                              height: mq.size.height * 0.025,
                                            ),
                                            Text(
                                              childCount > 1
                                                  ? "${index + 1} child's age"
                                                  : "Child's age",
                                              style: const TextStyle(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                            SizedBox(
                                              height: mq.size.height * 0.01,
                                            ),
                                            TextFormField(
                                              validator: (value) {
                                                if (value == null ||
                                                    value.isEmpty) {
                                                  return "*Required Field";
                                                }
                                                return null;
                                              },
                                              controller: _controllers[index],
                                              readOnly: true,
                                              decoration: InputDecoration(
                                                  // hintText: "${Global.ages}",
                                                  hintText: "Select age",
                                                  hintStyle: TextStyle(
                                                    color:
                                                        themeState.getDarkTheme
                                                            ? Colors.white54
                                                            : Colors.black54,
                                                  ),
                                                  contentPadding:
                                                      const EdgeInsets.symmetric(
                                                          vertical: 17,
                                                          horizontal: 15),
                                                  suffixIcon: const Icon(Icons
                                                      .keyboard_arrow_down_rounded),
                                                  suffixIconColor: Colors.grey,
                                                  border: OutlineInputBorder(
                                                      borderSide: const BorderSide(
                                                          width: 1.5,
                                                          color:
                                                              Colors.black12),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10)),
                                                  focusedBorder: OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                      borderSide: BorderSide(
                                                          width: 1.5,
                                                          color: themeState.getDarkTheme
                                                              ? Colors.white54
                                                              : Colors
                                                                  .black54)),
                                                  enabledBorder: OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(10),
                                                      borderSide: BorderSide(width: 1.5, color: themeState.getDarkTheme ? Colors.white54 : Colors.black54)),
                                                  // errorStyle:
                                                  //   const TextStyle(color: Color(0xffB00020)),
                                                  errorBorder: OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                    borderSide:
                                                        const BorderSide(
                                                            width: 1.5,
                                                            color: Colors.red),
                                                  )),
                                              onTap: () {
                                                showBottomSheet(
                                                  context: context,
                                                  shape: const RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.only(
                                                              topLeft: Radius
                                                                  .circular(20),
                                                              topRight: Radius
                                                                  .circular(
                                                                      20))),
                                                  builder: (context) {
                                                    return ChildAgaSheetHotal(
                                                        myAge: (age) {
                                                      setState(() {
                                                        _controllers[index]!
                                                            .text = "$age";
                                                      });
                                                    });
                                                    // return ChildAgaSheet(ages);
                                                  },
                                                );
                                              },
                                            ),
                                          ],
                                        ),
                                      );
                                    },
                                  ),
                                ),
                                SizedBox(
                                  height: mq.size.height * 0.01,
                                ),
                              ],
                            ),
                          ),
                        )
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
                          title: "APPLY",
                          callback: () {
                            if (_formKey.currentState!.validate()) {
                              widget.totalRAC(
                                  roomCount, adultsCount, childCount);
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
        ),
      ),
    );
  }
}

class IncrementAndDecrement extends StatelessWidget {
  final Function()? onPressed;
  final IconData? icon;
  final Color? color;
  const IncrementAndDecrement(
      {super.key,
      required this.onPressed,
      required this.icon,
      required this.color});

  @override
  Widget build(BuildContext context) {
    // final themeState = Provider.of<DarkThemeProvider>(context);
    return MaterialButton(
      minWidth: 40,
      height: 30,
      elevation: 2,
      // color: Colors.grey[300],
      onPressed: onPressed,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Icon(icon, color: color),
    );
  }
}
