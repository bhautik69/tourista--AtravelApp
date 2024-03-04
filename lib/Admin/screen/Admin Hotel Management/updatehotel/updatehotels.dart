import 'package:demo/Admin/screen/Admin%20Hotel%20Management/updatehotel/update_hotel_complate_screen.dart';
import 'package:demo/models/Hotel%20models/hotelAdd.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';

import 'package:iconly/iconly.dart';

class UpdateHotels extends StatefulWidget {
  const UpdateHotels({super.key});

  @override
  State<UpdateHotels> createState() => _UpdateHotelsState();
}

class _UpdateHotelsState extends State<UpdateHotels> {
  var searchController = TextEditingController();
  @override
  void initState() {
    searchController.addListener(_onSearchChanged);
    setState(() {});

    super.initState();
  }

  void _onSearchChanged() {
    setState(() {});
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Update/Delete Hotels"),
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
                        .collection("Hotel")
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return Center(
                            child: Column(
                          children: [
                            SizedBox(
                              height:
                                  MediaQuery.of(context).size.height * 0.382,
                            ),
                            const CircularProgressIndicator(
                              color: Color(0xff0078aa),
                            ),
                          ],
                        ));
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
                        var hotelName =
                            documentSnapshot['name'].toString().toLowerCase();
                        var city = documentSnapshot['cityName']
                            .toString()
                            .toLowerCase();
                        return hotelName.contains(searchQuery) ||
                            city.contains(searchQuery);
                      }).toList();
                      if (data.isEmpty) {
                        return const Center(
                          child: Text(
                            "HOTEL NOT FOUND!",
                            style: TextStyle(
                                fontWeight: FontWeight.w500, fontSize: 22),
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
                                      child: FancyShimmerImage(
                                        imageUrl: data[index]["images"].first,
                                        boxFit: BoxFit.cover,
                                      )),
                                  title: Text(data[index]["name"]

                                      // style: TextStyle(
                                      // color: Colors.white, fontWeight: FontWeight.w500
                                      //   ),
                                      ),
                                  subtitle: Text(data[index]["cityName"]
                                      // ' To ' +
                                      // data[index]['endDate'],
                                      // style:
                                      //TextStyle(color: Colors.white.withOpacity(0.85)),
                                      ),
                                  trailing: SizedBox(
                                    width: 97,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        IconButton(
                                          onPressed: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      UpdateComplateHotel(
                                                          id: data[index].id,
                                                          hotel: Hotel(
                                                            facilities: data[index]["facilities"],
                                                              name: data[index]
                                                                  ["name"],
                                                              description:
                                                                  data[index]["description"],
                                                              images:
                                                                  data[index]["images"],
                                                              price:
                                                                  data[index]["price"],
                                                              cityName:
                                                                  data[index]["cityName"],
                                                              disttocenter:
                                                                  data[index]["disttocenter"],
                                                              address:
                                                                  data[index]["address"],
                                                              latitude:
                                                                  data[index]["latitude"],
                                                              longitude:
                                                                  data[index]["longitude"],
                                                              checkinfrom:
                                                                  data[index]["checkinfrom"],
                                                              checkinUntil:
                                                                  data[index]["checkinUntil"],
                                                              checkoutUntil:
                                                                  data[index]["checkoutUntil"],
                                                              transeferFee:
                                                                  data[index]["transeferFee"],
                                                              distFromAirport:
                                                                  data[index]["distFromAirport"],
                                                              traveltimetoairport:
                                                                  data[index]["traveltimetoairport"])),
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
                                                              Hotel.deletehotel(
                                                                      data[index]
                                                                          .id)
                                                                  .whenComplete(
                                                                      () {
                                                                Navigator.pop(
                                                                    context);
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
                              Divider(
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
