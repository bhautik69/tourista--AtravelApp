// ignore_for_file: must_be_immutable, prefer_typing_uninitialized_variables

import 'package:demo/provider/dark_theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Description extends StatelessWidget {
  String description;
  Description({Key? key, required this.description}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeState = Provider.of<DarkThemeProvider>(context);
    var mq = MediaQuery.of(context);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Resort description',
          style: TextStyle(
              color: themeState.getDarkTheme ? Colors.white : Colors.black,
              fontSize: 20),
        ),
        elevation: 0,
        backgroundColor: themeState.getDarkTheme
            ? const Color(0xff121212)
            : const Color(0xFFffffff),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.close_outlined),
          color: themeState.getDarkTheme ? Colors.white : Colors.black,
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Divider(
            thickness: 1.5,
          ),
          SizedBox(
            height: mq.size.height * 0.02,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Text(description, style: const TextStyle(fontSize: 16)),
          )
        ],
      ),
    );
  }
}

class Great extends StatelessWidget {
  const Great({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeState = Provider.of<DarkThemeProvider>(context);
    var mq = MediaQuery.of(context);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Great for activities',
          style: TextStyle(
              color: themeState.getDarkTheme ? Colors.white : Colors.black,
              fontSize: 20),
        ),
        elevation: 0,
        backgroundColor: themeState.getDarkTheme
            ? const Color(0xff121212)
            : const Color(0xFFffffff),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.close_outlined),
          color: themeState.getDarkTheme ? Colors.white : Colors.black,
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Divider(
            thickness: 1.5,
          ),
          SizedBox(
            height: mq.size.height * 0.02,
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 12),
            child: Text(
                "Thing to do : Tours, Water sports (motorized), Swimming pool [outdoor] and more.",
                style: TextStyle(fontSize: 16)),
          )
        ],
      ),
    );
  }
}

class Hygiene extends StatelessWidget {
  const Hygiene({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeState = Provider.of<DarkThemeProvider>(context);
    var mq = MediaQuery.of(context);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Hygiene Plus',
          style: TextStyle(
              color: themeState.getDarkTheme ? Colors.white : Colors.black,
              fontSize: 20),
        ),
        elevation: 0,
        backgroundColor: themeState.getDarkTheme
            ? const Color(0xff121212)
            : const Color(0xFFffffff),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.close_outlined),
          color: themeState.getDarkTheme ? Colors.white : Colors.black,
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Divider(
            thickness: 1.5,
          ),
          SizedBox(
            height: mq.size.height * 0.02,
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 12),
            child: Text(
                "To help our travelers make informed and safe travel decisions, Hygiene Plus has been initiated. Our partners listed under this campaingn are committed to providing a clean environment to guests.",
                style: TextStyle(fontSize: 16)),
          )
        ],
      ),
    );
  }
}

class Checkin extends StatelessWidget {
  String checkinfrom;
  String checkinuntil;
  String checkout;
  Checkin(
      {Key? key,
      required this.checkinfrom,
      required this.checkinuntil,
      required this.checkout})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeState = Provider.of<DarkThemeProvider>(context);
    var mq = MediaQuery.of(context);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Check-in / Check-out',
          style: TextStyle(
              color: themeState.getDarkTheme ? Colors.white : Colors.black,
              fontSize: 20),
        ),
        elevation: 0,
        backgroundColor: themeState.getDarkTheme
            ? const Color(0xff121212)
            : const Color(0xFFffffff),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.close_outlined),
          color: themeState.getDarkTheme ? Colors.white : Colors.black,
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Divider(
            thickness: 1.5,
          ),
          SizedBox(
            height: mq.size.height * 0.02,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Text("Check-in from : ",
                        style: TextStyle(fontSize: 16)),
                    Text(
                      checkinfrom,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 16),
                    )
                  ],
                ),
                SizedBox(
                  height: mq.size.height * 0.009,
                ),
                Row(
                  children: [
                    const Text("Check-in until : ",
                        style: TextStyle(fontSize: 16)),
                    Text(
                      checkinuntil,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 16),
                    )
                  ],
                ),
                SizedBox(
                  height: mq.size.height * 0.009,
                ),
                Row(
                  children: [
                    const Text("Check-out until : ",
                        style: TextStyle(fontSize: 16)),
                    Text(
                      checkout,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 16),
                    )
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class Airport extends StatelessWidget {
  var fee;
  var distance;
  var time;
  Airport(
      {Key? key, required this.fee, required this.distance, required this.time})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeState = Provider.of<DarkThemeProvider>(context);
    var mq = MediaQuery.of(context);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Airport transfer',
          style: TextStyle(
              color: themeState.getDarkTheme ? Colors.white : Colors.black,
              fontSize: 20),
        ),
        elevation: 0,
        backgroundColor: themeState.getDarkTheme
            ? const Color(0xff121212)
            : const Color(0xFFffffff),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.close_outlined),
          color: themeState.getDarkTheme ? Colors.white : Colors.black,
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Divider(
            thickness: 1.5,
          ),
          SizedBox(
            height: mq.size.height * 0.02,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Text("Airport transfer fee : ",
                        style: TextStyle(fontSize: 16)),
                    Text(
                      "$fee INR",
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 16),
                    )
                  ],
                ),
                SizedBox(
                  height: mq.size.height * 0.009,
                ),
                Row(
                  children: [
                    const Text("Distance from airport : ",
                        style: TextStyle(fontSize: 16)),
                    Text(
                      "$distance KM",
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 16),
                    )
                  ],
                ),
                SizedBox(
                  height: mq.size.height * 0.009,
                ),
                Row(
                  children: [
                    const Text("Travel time to airport : ",
                        style: TextStyle(fontSize: 16)),
                    Text(
                      "$time Min",
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 16),
                    )
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
