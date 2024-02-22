import 'package:demo/Screen/Navigationpages/home/tabbarScreen/Flight%20Management/user_contact.dart';
import 'package:demo/Screen/Navigationpages/home/tabbarScreen/Flight%20Management/user_detail.dart';
import 'package:demo/widget/button.dart';
import 'package:demo/widget/textwidget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../provider/dark_theme_provider.dart';

class user_info extends StatefulWidget {
  const user_info({super.key});

  @override
  State<user_info> createState() => _user_infoState();
}

class _user_infoState extends State<user_info> {
  @override
  Widget build(BuildContext context) {
    var mq = MediaQuery.of(context);
    final themeState = Provider.of<DarkThemeProvider>(context);
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 236, 235, 235),
      appBar: AppBar(
        centerTitle: true,
        title: Text("data"),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: 13,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: EdgeInsets.only(bottom: 10.0),
                        child: Container(
                          height: mq.size.height * 0.12,
                          color: Colors.white,
                          child: Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                Stack(children: [
                                  const Icon(
                                    Icons.account_circle_outlined,
                                    size: 30,
                                  ),
                                  Positioned(
                                      top: 16,
                                      left: 16,
                                      child: CircleAvatar(
                                        backgroundColor:
                                            Color.fromARGB(255, 253, 202, 202),
                                        radius: 7,
                                        child: Image.asset(
                                          "assets/img/close.png",
                                        ),
                                      ))
                                ]),
                                SizedBox(
                                  width: mq.size.width * 0.05,
                                ),
                                const Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Traveller 1",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20),
                                    ),
                                    Text(
                                      "Child aged 7",
                                    ),
                                    Text(
                                      "Child aged 7",
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  width: mq.size.width * 0.45,
                                ),
                                InkWell(
                                    onTap: () {
                                      Navigator.of(context)
                                          .push(MaterialPageRoute(
                                        builder: (context) => user_detail(),
                                      ));
                                    },
                                    child: Icon(Icons.arrow_forward_ios)),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                  Container(
                    height: mq.size.height * 0.12,
                    color: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Stack(children: [
                            const Icon(
                              Icons.phone_android_rounded,
                              size: 30,
                            ),
                            Positioned(
                                top: 16,
                                left: 16,
                                child: CircleAvatar(
                                  backgroundColor:
                                      Color.fromARGB(255, 253, 202, 202),
                                  radius: 7,
                                  child: Image.asset(
                                    "assets/img/close.png",
                                  ),
                                ))
                          ]),
                          SizedBox(
                            width: mq.size.width * 0.05,
                          ),
                          const Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Contact details",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 20),
                              ),
                              Text(
                                "jasmeen@gmail.com",
                              ),
                              Text(
                                "Add contact details",
                              ),
                            ],
                          ),
                          SizedBox(
                            width: mq.size.width * 0.34,
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => user_contact(),
                              ));
                            },
                            child: Icon(Icons.arrow_forward_ios),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: mq.size.height * 0.01,
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
            child: Column(
              children: [
                Container(
                    width: mq.size.width,
                    height: 3,
                    color: themeState.getDarkTheme
                        ? Colors.white12
                        : Colors.black12),
                SizedBox(
                  height: mq.size.height * 0.019,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Row(children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Titletext(title: "₹ 15,135"),
                        SizedBox(
                          height: mq.size.height * 0.01,
                        ),
                        Text("Per person",
                            style: TextStyle(
                                fontSize: 13,
                                color: themeState.getDarkTheme
                                    ? Colors.white54
                                    : Colors.black54,
                                fontWeight: FontWeight.w400))
                      ],
                    ),
                    const Spacer(),
                    SizedBox(
                        height: mq.size.height * 0.06,
                        width: mq.size.width * 0.44,
                        child: commenButton(title: "SELECT", callback: () {}))
                  ]),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
