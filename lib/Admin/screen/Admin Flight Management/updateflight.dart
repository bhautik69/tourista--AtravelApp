import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demo/Admin/screen/Admin%20Flight%20Management/addNewflight.dart';
import 'package:demo/Admin/screen/Admin%20Flight%20Management/updatecompleteflight.dart';
import 'package:demo/models/Flight%20models/addFlight.dart';
import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:lottie/lottie.dart';

class UpdateFlight extends StatefulWidget {
  const UpdateFlight({super.key});

  @override
  State<UpdateFlight> createState() => _UpdateFlightState();
}

class _UpdateFlightState extends State<UpdateFlight> {
  var searchController = TextEditingController();
  @override
  void initState() {
    searchController.addListener(_onSearchChanged);
    setState(() {});

    super.initState();
  }

  Map<String, dynamic> ficonlist = {
    "Indigo": "assets/img/indigo.png",
    "Air India": "assets/img/airindia.jpg",
    "Vistara": "assets/img/vistara.png",
    "Go First": "assets/img/gofirst.png",
    "Star Air": "assets/img/starair.png",
    "Air India Express": "assets/img/AirIndiaExpress.png",
    "SpiceJet": "assets/img/spisjeck.png",
    "TruJet": "assets/img/trujet.png"
  };
  void _onSearchChanged() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Update/Delete Hotels"),
        centerTitle: true,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(IconlyLight.arrow_left_2)),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: TextField(
              controller: searchController,
              onChanged: (value) {
                setState(() {});
              },
              decoration: InputDecoration(
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 10.0, horizontal: 15),
                hintText: "Search",
                suffixIcon: const Icon(
                  Icons.search,
                  color: Colors.grey,
                ),
                // prefix: Icon(Icons.search),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20.0),
                  borderSide: const BorderSide(),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20.0),
                  borderSide: const BorderSide(),
                ),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(3.0),
              child: Expanded(
                child: StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection("FlightDetail")
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return const Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CircularProgressIndicator(
                                  color: Color(0xff0078aa), strokeWidth: 5),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                "Please wait!!",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 17),
                              )
                            ],
                          ),
                        );
                      }
                      if (snapshot.data!.docs.isEmpty) {
                        return const Center(
                          child: Text(
                            "NOT DATA FOUND!",
                            style: TextStyle(
                                fontWeight: FontWeight.w500, fontSize: 22),
                          ),
                        );
                      }
                      final data =
                          snapshot.data!.docs.where((documentSnapshot) {
                        var searchQuery = searchController.text.toLowerCase();
                        var hotelName = documentSnapshot['flightname']
                            .toString()
                            .toLowerCase();
                        var city = documentSnapshot['flightNumber']
                            .toString()
                            .toLowerCase();
                        return hotelName.contains(searchQuery) ||
                            city.contains(searchQuery);
                      }).toList();
                      if (data.isEmpty) {
                        return SingleChildScrollView(
                          child: Column(
                            children: [
                              Lottie.asset("assets/img/no_data_found.json"),
                              const Text(
                                "NO HOTEL FOUND!",
                                style: TextStyle(
                                    fontWeight: FontWeight.w500, fontSize: 22),
                              ),
                            ],
                          ),
                        );
                      }
                      return ListView.builder(
                        itemBuilder: (context, index) {
                          return Column(
                            children: [
                              Container(
                                color: Colors.white,
                                margin: const EdgeInsets.symmetric(vertical: 2),
                                child: ListTile(
                                  leading: SizedBox(
                                      height: 60,
                                      width: 71,
                                      child: Image.asset(ficonlist[data[index]
                                          ["flightname"]])),

                                  title: Text(data[index]["flightname"]

                                      // style: TextStyle(
                                      // color: Colors.white, fontWeight: FontWeight.w500
                                      //   ),
                                      ),
                                  subtitle: Text(data[index]["flightNumber"]),
                                  // ' To ' +
                                  // data[index]['endDate'],
                                  // style:
                                  //TextStyle(color: Colors.white.withOpacity(0.85)),
                                  // ),
                                  trailing: SizedBox(
                                    width: 97,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        IconButton(
                                          onPressed: () {
                                            Navigator.of(context)
                                                .push(MaterialPageRoute(
                                              builder: (context) => UpdateCompleteflight(
                                                  id: data[index].id,
                                                  addFlight: AddFlight(
                                                      startingFrom: data[index]
                                                          ["startingFrom"],
                                                      travelingTo: data[index]
                                                          ["travelingTo"],
                                                      flightNumber: data[index]
                                                          ["flightNumber"],
                                                      startDate: data[index]
                                                          ["startDate"],
                                                      endDate: data[index]
                                                          ["endDate"],
                                                      takeoffTime: data[index]
                                                          ["takeoffTime"],
                                                      landingTime: data[index]
                                                          ["landingTime"],
                                                      price: data[index]
                                                          ["price"],
                                                      flightname: data[index]
                                                          ["flightname"])),
                                            ));
                                          },
                                          icon: const Icon(Icons.edit),
                                          //  color: Colors.white,
                                        ),
                                        IconButton(
                                          onPressed: () {
                                            showDialog(
                                              context: context,
                                              builder: (context) {
                                                return AlertDialog(
                                                    title: const Text(
                                                      "Delete Hotel ",
                                                      style: TextStyle(
                                                          fontSize: 18),
                                                    ),
                                                    content: const Text(
                                                        style: TextStyle(
                                                            fontSize: 15),
                                                        "Are you sure you want to delete this hotel ?"),
                                                    actions: [
                                                      TextButton(
                                                          onPressed: () {
                                                            Navigator.pop(
                                                                context);
                                                          },
                                                          child: const Text(
                                                              "CANCEL")),
                                                      TextButton(
                                                          onPressed: () {
                                                            setState(() {
                                                              AddFlight.deleteFlight(
                                                                      data[index]
                                                                          .id)
                                                                  .whenComplete(
                                                                      () {
                                                                Navigator.of(
                                                                        context)
                                                                    .pop();
                                                              });
                                                            });
                                                          },
                                                          child: const Text(
                                                              "PROCEED")),
                                                    ],
                                                    contentPadding:
                                                        const EdgeInsets.only(
                                                            top: 20,
                                                            left: 25,
                                                            right: 25));
                                              },
                                            );
                                            setState(() {});
                                            setState(() {});
                                          },
                                          icon:
                                              const Icon(Icons.delete_forever),
                                          // color: Colors.white,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              const Divider(
                                thickness: 1.5,
                              )
                            ],
                          );
                        },
                        itemCount: data.length,
                      );
                    }),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }
}
