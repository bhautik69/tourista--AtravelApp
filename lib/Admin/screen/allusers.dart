import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demo/Admin/screen/singleuser.dart';
import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';

class Allusers extends StatefulWidget {
  const Allusers({super.key});

  @override
  State<Allusers> createState() => _AllusersState();
}

class _AllusersState extends State<Allusers> {
  var nameC = TextEditingController();
  List<Map<String, dynamic>> alluser = [];
  List<Map<String, dynamic>> founduser = [];

  getData() async {
    await FirebaseFirestore.instance
        .collection("users")
        .get()
        .then((QuerySnapshot? snapshot) {
      for (var element in snapshot!.docs) {
        if (element.exists) {
          alluser.add({
            "profilepic": element["profilePic"],
            "name": element["name"],
            "email": element["email"],
            "gender": element["gender"],
            "dob": element["dob"],
            "address": element["address"],
            "State": element["State"],
            "city": element["city"],
            "phone": element['phone'],
          });
          setState(() {});
        }
      }
    });
  }

  Color getRandomColor() {
    Random random = Random();
    int r = random
        .nextInt(256); // Random value between 0 and 255 for the red component
    int g = random
        .nextInt(256); // Random value between 0 and 255 for the green component
    int b = random
        .nextInt(256); // Random value between 0 and 255 for the blue component
    return Color.fromRGBO(
        r, g, b, 1.0); // Create a Color object with the random values
  }

  @override
  void initState() {
    getData();
    founduser = alluser;

    super.initState();
  }

  void _runFilter(String enteredKeyword) {
    List<Map<String, dynamic>> results = [];
    if (enteredKeyword.isEmpty) {
      // if the search field is empty or only contains white-space, we'll display all users
      results = alluser;
    } else {
      results = alluser
          .where((user) =>
              user["name"].toLowerCase().contains(enteredKeyword.toLowerCase()))
          .toList();
      // we use the toLowerCase() method to make it case-insensitive
    }

    // Refresh the UI
    setState(() {
      founduser = results;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("All Users"),
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(IconlyLight.arrow_left_2)),
        ),
        body: alluser.isEmpty
            ? const Center(
                child: CircularProgressIndicator(color: Color(0xff0078aa)),
              )
            : Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(13.0),
                    child: TextField(
                      controller: nameC,
                      onChanged: (value) => _runFilter(value),
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 15),
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
                    child: founduser.isEmpty
                        ? const Center(
                            child: Text(
                              "USER NOT FOUND",
                              style: TextStyle(
                                  fontWeight: FontWeight.w500, fontSize: 22),
                            ),
                          )
                        : ListView.builder(
                            itemCount: founduser.length,
                            itemBuilder: (context, index) {
                              return Card(
                                elevation: 1,
                                color: Colors.white,
                                margin: const EdgeInsets.symmetric(vertical: 2),
                                child: ListTile(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              UserDetailsAdmin(
                                            profileimg: founduser[index]
                                                ["profilepic"],
                                            name: founduser[index]["name"],
                                            email: founduser[index]["email"],
                                            gender: founduser[index]["gender"],
                                            dob: founduser[index]["dob"],
                                            add: founduser[index]["address"],
                                            sate: founduser[index]["State"],
                                            city: founduser[index]["city"],
                                            phone: founduser[index]["phone"],
                                          ),
                                        ));
                                  },
                                  leading: founduser[index]["profilepic"] == ""
                                      ? CircleAvatar(
                                          backgroundColor: getRandomColor(),
                                          radius: 21,
                                          child: SizedBox(
                                            height: 26,
                                            width: 26,
                                            child: Image.asset(
                                              "assets/img/profile.png",
                                            ),
                                          ),
                                        )
                                      : CircleAvatar(
                                          radius: 21,
                                          backgroundColor: getRandomColor(),
                                          backgroundImage: NetworkImage(
                                              founduser[index]['profilepic']),
                                        ),
                                  title: Text(
                                    founduser[index]["name"],
                                    style: const TextStyle(
                                        fontWeight: FontWeight.w500),
                                  ),
                                  subtitle: Text(founduser[index]["email"]),
                                  trailing: const Icon(
                                    IconlyLight.arrow_right_2,
                                  ),
                                ),
                              );
                            },
                          ),
                  ),
                ],
              ));
  }
}
