// ignore_for_file: prefer_is_empty

import 'package:buttons_tabbar/buttons_tabbar.dart';
import 'package:demo/Screen/Navigationpages/home/tabbarScreen/fligthtab.dart';
import 'package:demo/Screen/Navigationpages/home/tabbarScreen/hoteltab.dart';
import 'package:demo/Screen/Navigationpages/home/tabbarScreen/tripscreen.dart';

import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

// ignore: must_be_immutable
class Search extends StatefulWidget {
 Search({super.key , this.currentindex });
  int? currentindex=0;
   
  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
    @override
  
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        initialIndex: widget.currentindex!,
        length: 3,
        child: Builder(builder: (BuildContext context) {
          final TabController tabController = DefaultTabController.of(context);
          tabController.addListener(() {
            if (!tabController.indexIsChanging) {
              widget.currentindex = tabController.index;
              setState(() {
                
              });
            }
          });
          return Scaffold(
            appBar: AppBar(
                //toolbarHeight: 80,
                centerTitle: true,
                bottom: ButtonsTabBar(
                  radius: 100,
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                  borderColor: Colors.white,
                  borderWidth: 1,
                  labelSpacing: 10,
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 16.5, vertical: 7),
                  unselectedBorderColor: Colors.transparent,
                  unselectedBackgroundColor: Colors.transparent,
                  unselectedLabelStyle: const TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),

                  labelStyle: const TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                  tabs: const [
                    Tab(
                      icon: Icon(Icons.hiking_outlined),
                      text: "Trips",
                    ),
                    Tab(
                      icon: Icon(Ionicons.bed_outline),
                      text: "Hotels",
                    ),
                    Tab(
                      icon: Icon(Ionicons.airplane_outline),
                      text: "Flights",
                    ),
                  ],
                ),
                title: const Text("Tourista")),
            body: const TabBarView(
              children: [Triptab(), Hoteltab(), Fligthtab()],
            ),
          );
        }));
  }
}
