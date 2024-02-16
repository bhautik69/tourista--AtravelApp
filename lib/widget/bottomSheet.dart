import 'package:demo/Screen/Navigationpages/home/Flight/childAgeSheet.dart';
import 'package:demo/provider/dark_theme_provider.dart';
import 'package:demo/widget/button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

typedef MyQuantity = Function(int qua);

// ignore: camel_case_types, must_be_immutable
class bottomSheet extends StatefulWidget {
  MyQuantity myQuantity;
  bottomSheet({
    super.key,
    required this.myQuantity,
  });

  @override
  State<bottomSheet> createState() => _bottomSheetState();
}

// ignore: camel_case_types
class _bottomSheetState extends State<bottomSheet> {
  int quantity = 1;
  int quantity1 = 0;
  int qunt = 1;

  // int ages = 1;
  Map<int, TextEditingController> _controllers = {};

  void initState() {
    super.initState();
    // Initialize controllers with initial itemCount
    _initializeControllers();
  }

  void _initializeControllers() {
    for (int i = 0; i < quantity1; i++) {
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
        body: Padding(
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
                          "Who's flying?",
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
                                height: mq.size.height * 0.015,
                              ),
                              const Padding(
                                padding: EdgeInsets.only(left: 15),
                                child: Text(
                                  "Travelers",
                                  style: TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              SizedBox(
                                height: mq.size.height * 0.02,
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 15),
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
                                        width: mq.size.width * 0.35,
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
                                                color: quantity == 1
                                                    ? color1
                                                    : Color(0xff0078aa),
                                                onPressed: () {
                                                  if (quantity > 1) {
                                                    setState(() {
                                                      quantity--;
                                                    });
                                                  }
                                                },
                                                icon: Icons.remove),
                                            Text(
                                              quantity.toString(),
                                              style:
                                                  const TextStyle(fontSize: 18),
                                            ),
                                            IncrementAndDecrement(
                                                color: quantity1 + quantity == 9
                                                    ? color1
                                                    : Color(0xff0078aa),
                                                onPressed: () {
                                                  setState(() {
                                                    if (quantity1 + quantity <
                                                        9) {
                                                      quantity++;
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
                                height: mq.size.height * 0.025,
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 15),
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
                                        width: mq.size.width * 0.35,
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
                                                color: quantity1 == 0
                                                    ? color1
                                                    : Color(0xff0078aa),
                                                onPressed: () {
                                                  if (quantity1 > 0) {
                                                    setState(() {
                                                      _controllers.remove(
                                                          quantity1 - 1);
                                                      quantity1--;

                                                      _initializeControllers();
                                                    });
                                                  }
                                                },
                                                icon: Icons.remove),
                                            Text(
                                              quantity1.toString(),
                                              style:
                                                  const TextStyle(fontSize: 18),
                                            ),
                                            IncrementAndDecrement(
                                              color: quantity1 + quantity == 9
                                                  ? color1
                                                  : Color(0xff0078aa),
                                              onPressed: () {
                                                setState(() {
                                                  if (quantity1 + quantity <
                                                      9) {
                                                    quantity1++;
                                                    _initializeControllers();
                                                  }
                                                });
                                              },
                                              icon: Icons.add,
                                            ),
                                          ],
                                        ))
                                  ],
                                ),
                              ),
                              //SizedBox(
                              //  height: mq.size.height * 0.02,
                              // ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 20),
                                child: ListView.builder(
                                  itemCount: quantity1,
                                  physics: const NeverScrollableScrollPhysics(),
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
                                            quantity1 > 1
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
                                            controller: _controllers[index],
                                            readOnly: true,
                                            decoration: InputDecoration(
                                                // hintText: "${Global.ages}",
                                                hintText:
                                                    "Select age at time of flying",
                                                hintStyle: TextStyle(
                                                  color: themeState.getDarkTheme
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
                                                        color: Colors.black12),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10)),
                                                focusedBorder: OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                    borderSide: BorderSide(
                                                        width: 1.5,
                                                        color: themeState
                                                                .getDarkTheme
                                                            ? Colors.white54
                                                            : Colors.black54)),
                                                enabledBorder: OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(10),
                                                    borderSide: BorderSide(width: 1.5, color: themeState.getDarkTheme ? Colors.white54 : Colors.black54)),
                                                // errorStyle:
                                                //   const TextStyle(color: Color(0xffB00020)),
                                                errorBorder: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  borderSide: const BorderSide(
                                                      width: 1.5,
                                                      color: Colors.red),
                                                )),
                                            onTap: () {
                                              showBottomSheet(
                                                context: context,
                                                shape:
                                                    const RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius.only(
                                                                topLeft: Radius
                                                                    .circular(
                                                                        20),
                                                                topRight: Radius
                                                                    .circular(
                                                                        20))),
                                                builder: (context) {
                                                  return ChildAgaSheet(
                                                      myAge: (age) {
                                                    setState(() {
                                                      _controllers[index]!
                                                          .text = "${age}";
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
                height: mq.size.height * 0.125,
                child: Column(children: [
                  Container(
                      width: mq.size.width,
                      height: 1.8,
                      color: themeState.getDarkTheme
                          ? Colors.white12
                          : Colors.black12),
                  SizedBox(
                    height: mq.size.height * 0.0265,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Spacer(),
                        SizedBox(
                          height: mq.size.height * 0.067,
                          width: mq.size.width * 0.44,
                          child: commenButton(
                            title: "DONE",
                            callback: () {
                              setState(() {
                                qunt = quantity + quantity1;
                              });
                              widget.myQuantity(qunt);
                              Navigator.pop(context);
                            },
                          ),
                        ),
                      ],
                    ),
                  )
                ]),
              )
            ],
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
