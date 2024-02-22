import 'package:demo/provider/dark_theme_provider.dart';
import 'package:demo/widget/button.dart';
import 'package:demo/widget/textformfield.dart';
import 'package:demo/widget/textwidget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class user_detail extends StatefulWidget {
  const user_detail({super.key});

  @override
  State<user_detail> createState() => _user_detailState();
}

class _user_detailState extends State<user_detail> {
  static const List<String> list = <String>[
    'Male',
    'Female',
  ];
  final _formKey = GlobalKey<FormState>();
  var f_name = TextEditingController();
  var l_name = TextEditingController();
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
        title: const Text("data"),
        centerTitle: true,
      ),
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
                      Row(children: [
                        const Icon(
                          Icons.account_circle_outlined,
                          size: 30,
                        ),
                        SizedBox(
                          width: mq.size.width * 0.05,
                        ),
                        const Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Traveller 1",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 20),
                            ),
                            Text(
                              "Child aged 7",
                            ),
                          ],
                        ),
                      ]),
                      SizedBox(
                        height: mq.size.height * 0.05,
                      ),
                      const Text(
                        "First name",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: mq.size.height * 0.01,
                      ),
                      commentextfield(
                        controllername: f_name,
                        hinttext: "Enter Name",
                        validator: (value) {
                          return null;
                        },
                      ),
                      SizedBox(
                        height: mq.size.height * 0.03,
                      ),
                      const Text(
                        "Last name",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: mq.size.height * 0.01,
                      ),
                      commentextfield(
                        controllername: l_name,
                        hinttext: "Enter Name",
                        validator: (value) {
                          return null;
                        },
                      ),
                      SizedBox(
                        height: mq.size.height * 0.03,
                      ),
                      const Text(
                        "Gender specified on your passport/ID",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: mq.size.height * 0.01,
                      ),
                      DropdownButtonFormField(
                        // hint: const Text("Gender"),
                        decoration: InputDecoration(
                            hintStyle: const TextStyle(
                              color: Colors.black54,
                            ),
                            labelStyle: const TextStyle(
                                color: Colors.black54,
                                fontWeight: FontWeight.w500),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: const BorderSide(
                                    width: 1.5, color: Color(0xff0078AA))),
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: const BorderSide(
                                    width: 1.5, color: Colors.black54)),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: const BorderSide(
                                    width: 1.5, color: Colors.black54)),
                            errorStyle:
                                const TextStyle(color: Color(0xffB00020)),
                            errorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(
                                  width: 1.5, color: Color(0xffB00020)),
                            )),
                        items: list
                            .map((e) => DropdownMenuItem<String>(
                                value: e, child: Text(e)))
                            .toList(),
                        onChanged: (value) {
                          setState(() {
                            gender = value.toString();
                          });
                        },
                      ),
                      SizedBox(
                        height: mq.size.height * 0.01,
                      ),
                      Text(
                        "We're currently required by airlines and providers to ask for this information",
                        style: TextStyle(
                          color: themeState.getDarkTheme
                              ? Colors.white54
                              : Colors.black54,
                        ),
                      ),
                      SizedBox(
                        height: mq.size.height * 0.03,
                      ),
                      const Text(
                        "Date of Birth",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: mq.size.height * 0.01,
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
