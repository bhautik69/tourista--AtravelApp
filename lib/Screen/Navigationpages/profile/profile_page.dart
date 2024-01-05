import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demo/Screen/Auth/signin.dart';
import 'package:demo/Screen/Navigationpages/profile/manageacc.dart';

import 'package:demo/consts/forgetpass.dart';
import 'package:demo/provider/dark_theme_provider.dart';
import 'package:demo/widget/listtile.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:ionicons/ionicons.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';

import '../../../Exeptiopn/signout_fail.dart';
import '../../../widget/errortoast.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final FirebaseAuth auth = FirebaseAuth.instance;

  bool isDark = false;
  User? user = FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    setState(() {});
    var mq = MediaQuery.of(context);
    final themeState = Provider.of<DarkThemeProvider>(context);
    return Scaffold(
        backgroundColor: themeState.getDarkTheme
            ? const Color(0xff121212)
            : const Color(0xFFffffff),
        appBar: appBar(themeState),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                width: mq.size.width,
                height: mq.size.height * 0.28,
                color: themeState.getDarkTheme
                    ? const Color(0xff212121)
                    : const Color(0xff0078aa),
                child: StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection('users')
                        .doc(user== null ? "kUtCYEM5aghTxhbHmji55sAsp3R2": FirebaseAuth.instance.currentUser!.uid)
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.hasError) {
                        return const Center(
                          child: Text(""),
                        );
                      } else if (snapshot.hasData) {
                        final data =
                            snapshot.data!.data() as Map<String, dynamic>;
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(
                              height: mq.size.height * 0.02,
                            ),
                            data["profilePic"].isEmpty ||
                                    data["profilePic"] == null ||
                                    data["profilePic"] == ""
                                ? CircleAvatar(
                                    backgroundColor: Colors.grey,
                                    radius: 55,
                                    child: Image.asset(
                                      "assets/img/profile.png",
                                      scale: 16,
                                    ),
                                  )
                                : CircleAvatar(
                                    backgroundColor: Colors.grey,
                                    radius: 55,
                                    backgroundImage:
                                        NetworkImage(data["profilePic"])),
                            Padding(
                              padding: const EdgeInsets.only(top: 12, bottom: 5),
                              child: data["name"].isEmpty ||
                                      data["name"] == null ||
                                      data["name"] == ""
                                  ? const Text(" ")
                                  : Text(
                                      data["name"],
                                      style: const TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 23),
                                    ),
                            ),
                            data["email"].isEmpty ||
                                    data["email"] == null ||
                                    data["email"] == ""
                                ? const Text(" ")
                                : Text(
                                    data["email"],
                                    style: const TextStyle(
                                        color: Colors.white, fontSize: 15),
                                  )
                          ],
                        );
                      }
                      return const Center(
                        child: Center(
                            child: CircularProgressIndicator(
                          color: Colors.white,
                        )),
                      );
                    }),
              ),
              const SizedBox(
                height: 15,
              ),
              listTiles(
                  context: context,
                  isdark: themeState.getDarkTheme,
                  title: "Manage Your account",
                  icon: Ionicons.person_outline,
                  callback: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const MngAcc(),
                        ));
                  }),
              listTiles(
                  context: context,
                  isdark: themeState.getDarkTheme,
                  title: "Share our app",
                  icon: Icons.share,
                  callback: () {
                    Share.share('com.example.demo');
                  }),
              listTiles(
                  context: context,
                  isdark: themeState.getDarkTheme,
                  title: "Forget password",
                  icon: Icons.lock_open,
                  callback: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ForgetPassword(),
                        ));
                  }),
              listTiles(
                  context: context,
                  isdark: themeState.getDarkTheme,
                  title: "Sign out",
                  icon: IconlyLight.logout,
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
                                      themeState.setDarkTheme = false;
                                    });
                                    logout();
                                  },
                                  child: const Text("PROCEED")),
                            ],
                            contentPadding: const EdgeInsets.only(
                                top: 20, left: 25, right: 25));
                      },
                    );
                  }),
            ],
          ),
        ));
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

  AppBar appBar(DarkThemeProvider themeState) {
    return AppBar(
        backgroundColor: themeState.getDarkTheme
            ? const Color(0xff212121)
            : const Color(0xff0078aa),
        title: const Text("Profile"),
        elevation: 0,
        actions: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: InkWell(
                onTap: () {
                  setState(() {
                    isDark
                        ? themeState.setDarkTheme = false
                        : themeState.setDarkTheme = true;
                    isDark = !isDark;
                  });
                },
                child: Icon(
                  themeState.getDarkTheme
                      ? Icons.dark_mode_outlined
                      : Icons.light_mode_outlined,
                  color: Colors.white,
                )),
          )
        ]);
  }
}
