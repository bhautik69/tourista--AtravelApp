// ignore_for_file: must_be_immutable

import 'package:demo/provider/dark_theme_provider.dart';
import 'package:demo/widget/button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

typedef MyAge = Function(String age);

class ChildAgaSheet extends StatefulWidget {
  MyAge myAge;
  ChildAgaSheet({super.key, required this.myAge});

  @override
  State<ChildAgaSheet> createState() => _ChildAgaSheetState();
}

class _ChildAgaSheetState extends State<ChildAgaSheet> {
  String ages = "0";
  @override
  Widget build(BuildContext context) {
    final themeState = Provider.of<DarkThemeProvider>(context);
    var mq = MediaQuery.of(context);
    return SizedBox(
      height: mq.size.height / 1.13,
      child: Column(
        children: [
          Divider(
            thickness: 3,
            endIndent: mq.size.width * 0.42,
            indent: mq.size.width * 0.42,
            color: themeState.getDarkTheme ? Colors.white38 : Colors.black38,
          ),
          Expanded(
            child: NotificationListener(
              onNotification: (OverscrollIndicatorNotification
                  overscrollIndicatorNotification) {
                overscrollIndicatorNotification.disallowIndicator();
                return true;
              },
              child: SingleChildScrollView(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                  child: ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: 17,
                    itemBuilder: (context, index) {
                      return RadioListTile(
                        controlAffinity: ListTileControlAffinity.trailing,
                        title: Text("${index + 1}"),
                        value: (index + 1).toString(),
                        groupValue: ages,
                        activeColor: const Color(0xff0078aa),
                        onChanged: (value) {
                          setState(() {
                            ages = value.toString();
                          });
                        },
                      );
                    },
                  ),
                ),
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
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
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
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      InkWell(
                        onTap: () {
                          setState(() {
                            ages = "0";
                          });
                        },
                        child: Container(
                          height: mq.size.height * 0.067,
                          width: mq.size.width * 0.44,
                          decoration: BoxDecoration(
                              border:
                                  Border.all(color: const Color(0xff0078aa)),
                              borderRadius: BorderRadius.circular(10)),
                          child: const Center(
                            child: Text(
                              "Remove",
                              style: TextStyle(
                                  color: Color(0xff0078aa),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18),
                            ),
                          ),
                        ),
                      ),
                      const Spacer(),
                      SizedBox(
                        height: mq.size.height * 0.067,
                        width: mq.size.width * 0.44,
                        child: commenButton(
                          title: "Done",
                          callback: () {
                            widget.myAge(ages);
                            Navigator.pop(context);
                            // Global.ages = widget.ages!;
                            // setState(() {
                            // print("${Global.ages}");
                            // });
                          },
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
