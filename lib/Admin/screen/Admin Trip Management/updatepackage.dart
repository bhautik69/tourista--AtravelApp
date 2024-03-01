import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demo/Admin/screen/Admin%20Trip%20Management/update_complate_screen.dart';

import 'package:demo/models/packagemodel.dart';
import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';

class UpdatePackage extends StatefulWidget {
  const UpdatePackage({super.key});
  static const String id = "updatepackage";

  @override
  State<UpdatePackage> createState() => _UpdatePackageState();
}

class _UpdatePackageState extends State<UpdatePackage> {
  var searchController = TextEditingController();

  Future<void> deletePackagesByStartDate(String startDate) async {
    CollectionReference packagesRef =
        FirebaseFirestore.instance.collection('package');
    QuerySnapshot packagesSnapshot =
        await packagesRef.where('startDate', isEqualTo: startDate).get();
    // ignore: avoid_function_literals_in_foreach_calls
    packagesSnapshot.docs.forEach((doc) async {
      await packagesRef.doc(doc.id).delete();
    });
  }

  @override
  void initState() {
    DateTime dateTime = DateTime.now();
    String datetime1 = "${dateTime.day}-${dateTime.month}-${dateTime.year}";
    deletePackagesByStartDate(datetime1);
    searchController.addListener(_onSearchChanged);
    setState(() {});
    super.initState();
  }

  void _onSearchChanged() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("UPDATE PACKAGE"),
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
                        .collection("package")
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
                        var startingForm = documentSnapshot['startingForm']
                            .toString()
                            .toLowerCase();
                        var traveligTo = documentSnapshot['traveligTo']
                            .toString()
                            .toLowerCase();
                        return startingForm.contains(searchQuery) ||
                            traveligTo.contains(searchQuery);
                      }).toList();
                           if(data.isEmpty)
                           {
                            return const Center(
                          child: Text(
                            "PACKAGE NOT FOUND!",
                            style: TextStyle(
                                fontWeight: FontWeight.w500, fontSize: 22),
                          ),
                        );
                      
                           }
                      return ListView.builder(
                        itemBuilder: (context, index) {
                          return Card(
                            elevation: 1,
                            color: Colors.white,
                            margin: const EdgeInsets.symmetric(vertical: 2),
                            child: ListTile(
                              leading: SizedBox(
                                  height: 60,
                                  width: 71,
                                  child: FancyShimmerImage(
                                    imageUrl: data[index]["imgUrl"],
                                    boxFit: BoxFit.cover,
                                  )),
                              title: Text(
                                data[index]["startingForm"] +
                                    ' To ' +
                                    data[index]["traveligTo"],
                                // style: TextStyle(
                                // color: Colors.white, fontWeight: FontWeight.w500
                                //   ),
                              ),
                              subtitle: Text(data[index]["startDate"]
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
                                                  UpdatePackageComplete(
                                                id: data[index].id,
                                                package: Package(
                                                  latitude:data[index]["latitude"],
                                                  longitude:data[index]["longitude"],
                                                    ActivityList: data[index]
                                                        ["activityList"],
                                                    startingForm: data[index]
                                                        ["startingForm"],
                                                    traveligTo: data[index]
                                                        ["traveligTo"],
                                                    startDate: data[index]
                                                        ["startDate"],
                                                    endDate: data[index]
                                                        ["endDate"],
                                                    imgUrl: data[index]
                                                        ["imgUrl"],
                                                    decs: data[index]["decs"],
                                                    price: data[index]["price"],
                                                    img1: data[index]["img1"],
                                                    img2: data[index]["img2"],
                                                    img3: data[index]["img3"],
                                                    img4: data[index]["img4"],
                                                    flightDate: data[index]
                                                        ["flightDate"],
                                                    reachDate: data[index]
                                                        ["reachDate"],
                                                    flightTime: data[index]
                                                        ["flightTime"],
                                                    reachTime: data[index]
                                                        ["reachTime"],
                                                    hotelName: data[index]
                                                        ["hotelName"],
                                                    hotelImg: data[index]
                                                        ["hotelImg"],
                                                    hotelAdd: data[index]
                                                        ["hotelAdd"],
                                                    hotelPhone: data[index]
                                                        ["hotelPhone"],
                                                    hotelRate: data[index]
                                                        ["hotelRate"],
                                                    retunfligthdate: data[index]
                                                        ["retunFligthDate"],
                                                    retunreachfligthdate: data[index][
                                                        "retunReachFligthDate"],
                                                    retunfligthtime: data[index]
                                                        ["retunFligthTime"],
                                                    retunreachfligthtime: data[index]
                                                        ["retunReachFligthTime"]),
                                              ),
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
                                                  "Delete Package ",
                                                  style:
                                                      TextStyle(fontSize: 18),
                                                ),
                                                content: const Text(
                                                    style:
                                                        TextStyle(fontSize: 15),
                                                    "Are you sure you want to delete this package ?"),
                                                actions: [
                                                  TextButton(
                                                      onPressed: () {
                                                        Navigator.pop(context);
                                                      },
                                                      child:
                                                          const Text("CANCEL")),
                                                  TextButton(
                                                      onPressed: () {
                                                        Package.deletePackage(
                                                                data[index].id)
                                                            .whenComplete(() {
                                                          Navigator.pop(
                                                              context);
                                                        });

                                                        setState(() {});
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
                                      icon: const Icon(Icons.delete_forever),
                                      // color: Colors.white,
                                    ),
                                  ],
                                ),
                              ),
                            ),
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
