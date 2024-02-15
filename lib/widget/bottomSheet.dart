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

  @override
  Widget build(BuildContext context) {
    var mq = MediaQuery.of(context);
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: const Align(
                    alignment: Alignment.topRight,
                    child: Text(
                      "Cancel",
                      style: TextStyle(
                          fontSize: 15,
                          color: Colors.blue,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                SizedBox(
                  height: mq.size.height * 0.02,
                ),
                const Text(
                  "Who's flying?",
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: mq.size.height * 0.01,
                ),
                const Divider(),
                SizedBox(
                  height: mq.size.height * 0.01,
                ),
                const Text(
                  "Travelers",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: mq.size.height * 0.02,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Adults",
                      style: TextStyle(
                          fontSize: 15,
                          color: Color.fromARGB(255, 0, 0, 0),
                          fontWeight: FontWeight.w500),
                    ),
                    Container(
                        height: mq.size.height * 0.07,
                        width: mq.size.width * 0.35,
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.black),
                            borderRadius: BorderRadius.circular(20)),
                        child: Row(
                          children: [
                            IncrementAndDecrement(
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
                              style: const TextStyle(fontSize: 18),
                            ),
                            IncrementAndDecrement(
                                onPressed: () {
                                  setState(() {
                                    quantity++;
                                  });
                                },
                                icon: Icons.add),
                          ],
                        ))
                  ],
                ),
                SizedBox(
                  height: mq.size.height * 0.03,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Children",
                      style: TextStyle(
                          fontSize: 15,
                          color: Color.fromARGB(255, 0, 0, 0),
                          fontWeight: FontWeight.w500),
                    ),
                    Container(
                        height: mq.size.height * 0.07,
                        width: mq.size.width * 0.35,
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.black),
                            borderRadius: BorderRadius.circular(20)),
                        child: Row(
                          children: [
                            IncrementAndDecrement(
                                onPressed: () {
                                  if (quantity1 > 0) {
                                    setState(() {
                                      quantity1--;
                                    });
                                  }
                                },
                                icon: Icons.remove),
                            Text(
                              quantity1.toString(),
                              style: const TextStyle(fontSize: 18),
                            ),
                            IncrementAndDecrement(
                              onPressed: () {
                                setState(() {
                                  quantity1++;
                                });
                              },
                              icon: Icons.add,
                            ),
                          ],
                        ))
                  ],
                ),
                SizedBox(
                  height: mq.size.height * 0.02,
                ),
                ListView.builder(
                  itemCount: quantity1,
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: mq.size.height * 0.02,
                        ),
                        Text(
                          quantity1 > 1
                              ? "${index + 1} child's age"
                              : "Child's age",
                          style: const TextStyle(
                              fontSize: 15, fontWeight: FontWeight.w500),
                        ),
                        SizedBox(
                          height: mq.size.height * 0.01,
                        ),
                        TextFormField(
                          readOnly: true,
                          decoration: InputDecoration(
                              // hintText: "${Global.ages}",
                              hintText: "Select age at the time of the flight",
                              hintStyle: const TextStyle(
                                  fontWeight: FontWeight.normal, fontSize: 14),
                              suffixIcon: const Icon(
                                  Icons.keyboard_arrow_down_rounded,
                                  size: 30),
                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: 12, horizontal: 12),
                              border: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      width: 1.5, color: Colors.black),
                                  borderRadius: BorderRadius.circular(20)),
                              focusedBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      width: 1.5, color: Colors.black38),
                                  borderRadius: BorderRadius.circular(20))),
                          onTap: () {
                            showBottomSheet(
                              context: context,
                              shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(20),
                                      topRight: Radius.circular(20))),
                              builder: (context) {
                                return const ChildAgaSheet();
                                // return ChildAgaSheet(ages);
                              },
                            );
                          },
                        ),
                      ],
                    );
                  },
                ),
                SizedBox(
                  height: mq.size.height * 0.01,
                ),
                const Divider(),
                SizedBox(
                  height: mq.size.height * 0.01,
                ),
                Align(
                  alignment: Alignment.center,
                  child: commenButton(
                    title: "Done",
                    callback: () {
                      setState(() {
                        qunt = quantity + quantity1;
                      });
                      widget.myQuantity(qunt);
                      Navigator.pop(context);
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

class IncrementAndDecrement extends StatelessWidget {
  final Function()? onPressed;
  final IconData? icon;
  const IncrementAndDecrement(
      {super.key, required this.onPressed, required this.icon});

  @override
  Widget build(BuildContext context) {
    final themeState = Provider.of<DarkThemeProvider>(context);
    return MaterialButton(
      minWidth: 40,
      height: 30,
      elevation: 2,
      // color: Colors.grey[300],
      onPressed: onPressed,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Icon(icon,
          color: themeState.getDarkTheme ? Colors.black : Colors.black),
    );
  }
}
