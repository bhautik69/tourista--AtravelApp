import 'package:demo/provider/dark_theme_provider.dart';
import 'package:demo/widget/button.dart';
import 'package:demo/widget/textformfield.dart';
import 'package:demo/widget/textwidget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class user_contact extends StatefulWidget {
  const user_contact({super.key});

  @override
  State<user_contact> createState() => _user_contactState();
}

class _user_contactState extends State<user_contact> {
  final _formKey = GlobalKey<FormState>();
  var email = TextEditingController();
  var phone = TextEditingController();
  @override
  Widget build(BuildContext context) {
    var mq = MediaQuery.of(context);
    final themeState = Provider.of<DarkThemeProvider>(context);
    return Scaffold(
      appBar: AppBar(title: Text("data"), centerTitle: true),
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: mq.size.height * 0.02,
                      ),
                      Row(children: [
                        const Icon(
                          Icons.phone_android_rounded,
                          size: 30,
                        ),
                        SizedBox(
                          width: mq.size.width * 0.05,
                        ),
                        Text(
                          "Contact details",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20),
                        ),
                      ]),
                      SizedBox(
                        height: mq.size.height * 0.03,
                      ),
                      const Text(
                        "Contact email",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: mq.size.height * 0.01,
                      ),
                      commentextfield(
                        controllername: email,
                        hinttext: "Enter email",
                        validator: (value) {
                          return null;
                        },
                      ),
                      SizedBox(
                        height: mq.size.height * 0.03,
                      ),
                      const Text(
                        "Contact number",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: mq.size.height * 0.01,
                      ),
                      commentextfield(
                        
                        controllername: phone,
                        hinttext: "Enter Number",
                        validator: (value) {
                          return null;
                        },
                      ),
                      SizedBox(
                        height: mq.size.height * 0.03,
                      ),
                    ],
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
            )
          ],
        ),
      ),
    );
  }
}
