import 'package:demo/Admin/screen/addpackage.dart';
import 'package:demo/Admin/screen/allusers.dart';
import 'package:demo/Admin/screen/updatepackage.dart';
import 'package:demo/Admin/screen/viewbooking.dart';
import 'package:demo/Exeptiopn/signout_fail.dart';
import 'package:demo/Screen/Auth/signin.dart';
import 'package:demo/widget/button.dart';
import 'package:demo/widget/errortoast.dart';
import 'package:demo/widget/textwidget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class Adminmainpage extends StatefulWidget {
  const Adminmainpage({super.key});
  static const String id = "addpackage";

  @override
  State<Adminmainpage> createState() => _AdminmainpageState();
}

class _AdminmainpageState extends State<Adminmainpage> {
  final FirebaseAuth auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Tourista"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                height: 20,
              ),
              const Titletext(
                title: "WELCOME ADMIN",
                size: 27,
              ),
            const  SizedBox(
                height: 55,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    child: cardwidget(title: "ADD PACKAGE"),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const AddPackage(),
                          ));
                    },
                  ),
                  InkWell(
                      child: cardwidget(title: "UPDATE PACKAGE"),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const UpdatePackage(),
                            ));
                      })
                ],
              ),
              //
           const   SizedBox(
                height: 12,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const ViewBooking(),
                            ));
                      },
                      child: cardwidget(title: "VIEW BOOKINGS")),
                  InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const Allusers(),
                            ));
                      },
                      child: cardwidget(title: "ALL\nUSERS"))
                ],
              ),
            const  SizedBox(
                height: 60,
              ),

              SizedBox(
                  height: 55,
                  width: MediaQuery.of(context).size.width,
                  child: commenButton(
                    title: "LOG OUT",
                    callback: () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                              title: const Text(
                                "Are you sure you want to log out?",
                                style: TextStyle(fontSize: 18),
                              ),
                              content: const Text(
                                  style: TextStyle(fontSize: 15),
                                  "Logging out will temporarily hide all your personal data,including bookings.To see these again, simply log back in your account."),
                              actions: [
                                TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: const Text("CANCEL")),
                                TextButton(
                                    onPressed: () {
                                      setState(() {
                                        // themeState.setDarkTheme = false;
                                      });
                                      logout();
                                    },
                                    child: const Text("PROCEED")),
                              ],
                              contentPadding: const EdgeInsets.only(
                                  top: 20, left: 25, right: 25));
                        },
                      );
                    },
                  ))
            ],
          ),
        ),
      ),
    );
  }

  Widget cardwidget({required String title}) {
    return Card(
      elevation: 1,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Container(
        height: 18.h,
        width: 20.h,
        decoration: BoxDecoration(
            color: const Color(0xff0078aa), borderRadius: BorderRadius.circular(10)),
        child: Center(
            child: Text(
          title,
          textAlign: TextAlign.center,
          style: const TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 23),
        )),
      ),
    );
  }

  void logout() async {
    try {
      auth.signOut().then((value) {
        Navigator.pop(context);

        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const Signin(),
            ));
      });
    } on FirebaseAuthException catch (e) {
      final ex = Signoutfail.code(e.code);
      Errortoast().toastmsg(ex.msg);

      throw ex;
    } catch (_) {
      const ex = Signoutfail();
      Errortoast().toastmsg(ex.msg);
      throw ex;
    }
  }
}
