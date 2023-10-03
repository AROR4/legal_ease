import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:legal_ease/advocate/advocateprofile.dart';
import 'package:shimmer/shimmer.dart';

class searchlawyer1 extends StatefulWidget {
  String search;
  searchlawyer1({
    super.key,
    this.search = "",
  });

  @override
  State<searchlawyer1> createState() => _searchlawyer1State();
}

class _searchlawyer1State extends State<searchlawyer1> {
  var searchcontroller = TextEditingController();

  @override
  void initState() {
    super.initState();
    searchcontroller.text = widget.search;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black54,

      resizeToAvoidBottomInset: false,

      appBar: AppBar(
        toolbarHeight: 100,
        backgroundColor: Colors.black12,
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            InkWell(
                onTap: () => Navigator.pop(context),
                child: Icon(CupertinoIcons.arrow_left)),
            SizedBox(
              width: 10,
            ),
            Expanded(
              child: TextFormField(
                controller: searchcontroller,
                onChanged: (value) {
                  setState(() {});
                },
                decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(12),
                    hintText: 'Search Lawyer by name , type , services',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50.0),
                    )),
              ),
            ),
          ],
        ),
        // iconTheme: IconThemeData.fallback(),
        elevation: 0,
        // backgroundColor: Color.fromARGB(255, 241, 243, 247),
      ),
      // backgroundColor: Color.fromARGB(255, 241, 243, 247),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
                child: FutureBuilder(
                    future: FirebaseFirestore.instance
                        .collection('users')
                        .where('role', isEqualTo: "Advocate")
                        .get(),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return Shimmer.fromColors(
                            baseColor: Colors.grey.shade700,
                            highlightColor: Colors.grey.shade100,
                            child: ListView.builder(
                                itemCount: 4,
                                itemBuilder: (context, index) {
                                  return Column(
                                    children: [
                                      ListTile(
                                        title: Container(
                                          height: 10,
                                          width: 80,
                                          color: Colors.white,
                                        ),
                                        subtitle: Container(
                                          height: 10,
                                          width: 80,
                                          color: Colors.white,
                                        ),
                                        leading: Container(
                                          height: 50,
                                          width: 50,
                                          color: Colors.white,
                                        ),
                                      )
                                    ],
                                  );
                                }));
                      } else {
                        final snap = (snapshot.data! as dynamic).docs;
                        return ListView.builder(
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          itemCount: snap.length,
                          itemBuilder: (context, index) {
                            var name =
                                "${snap[index]['firstname']} ${snap[index]['lastname']}";
                            // var special=snap[index]['specialisation'];
                            var special = snap[index]['specialisation'];
                            List<String> servicesList = [];
                            List<dynamic> myArray = snap[index]?['services'];

                            for (var item in myArray) {
                              servicesList.add(item);
                            }

                            if (searchcontroller.text.isEmpty) {
                              return Column(
                                children: [
                                  InkWell(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  advocatedash(
                                                    email: snap[index]['email'],
                                                    name:
                                                        "${snap[index]['firstname']} ${snap[index]['lastname']}",
                                                    wins: snap[index]
                                                        ['wonCases'],
                                                    cases: snap[index]
                                                        ['totalCases'],
                                                    photourl: snap[index]
                                                        ['photourl'],
                                                    services: servicesList,
                                                    uid: snap[index]['uid'],
                                                  )));
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 12, vertical: 6),
                                      child: Container(
                                        decoration: BoxDecoration(
                                            // color: Colors.white30,
                                            border:
                                                Border.all(color: Colors.white),
                                            borderRadius:
                                                BorderRadius.circular(14)),
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Row(
                                            children: [
                                              CircleAvatar(
                                                  radius: 60,
                                                  backgroundImage: NetworkImage(
                                                      snap[index]['photourl'])),
                                              SizedBox(
                                                width: 10,
                                              ),
                                              Expanded(
                                                child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    children: [
                                                      Text(
                                                        "${snap[index]['firstname']} ${snap[index]['lastname']}",
                                                        style:
                                                            GoogleFonts.poppins(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                                fontSize: 20,
                                                                color: Colors
                                                                    .white),
                                                      ),
                                                      SizedBox(
                                                        height: 5,
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .symmetric(
                                                                horizontal: 5,
                                                                vertical: 2),
                                                        child: Container(
                                                            child: Column(
                                                          children: [
                                                            Text(
                                                              special,
                                                              style: GoogleFonts
                                                                  .poppins(
                                                                      color: Colors
                                                                          .white),
                                                            ),
                                                            Text(
                                                                "Total Cases: ${snap[index]['totalCases']}",
                                                                style:
                                                                    GoogleFonts
                                                                        .poppins(
                                                                  color: Colors
                                                                      .white,
                                                                )),
                                                            Text(
                                                                "Wins: ${snap[index]['wonCases']}",
                                                                style:
                                                                    GoogleFonts
                                                                        .poppins(
                                                                  color: Colors
                                                                      .white,
                                                                )),
                                                          ],
                                                        )),
                                                      )
                                                    ]),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              );
                            } else if (name.toLowerCase().contains(
                                    searchcontroller.text.toLowerCase()) ||
                                special.toLowerCase().contains(
                                    searchcontroller.text.toLowerCase()) ||
                                servicesList.contains(
                                    searchcontroller.text.toString())) {
                              return Column(
                                children: [
                                  InkWell(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  advocatedash(
                                                    email: snap[index]['email'],
                                                    name:
                                                        "${snap[index]['firstname']} ${snap[index]['lastname']}",
                                                    wins: snap[index]
                                                        ['wonCases'],
                                                    cases: snap[index]
                                                        ['totalCases'],
                                                    photourl: snap[index]
                                                        ['photourl'],
                                                    services: servicesList,
                                                    uid: snap[index]['uid'],
                                                  )));
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 12, vertical: 6),
                                      child: Container(
                                        decoration: BoxDecoration(
                                            // color: Colors.white30,
                                            border:
                                                Border.all(color: Colors.white),
                                            borderRadius:
                                                BorderRadius.circular(14)),
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Row(
                                            children: [
                                              CircleAvatar(
                                                  radius: 60,
                                                  backgroundImage: NetworkImage(
                                                      snap[index]['photourl'])),
                                              SizedBox(
                                                width: 10,
                                              ),
                                              Expanded(
                                                child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    children: [
                                                      Text(
                                                        "${snap[index]['firstname']} ${snap[index]['lastname']}",
                                                        style:
                                                            GoogleFonts.poppins(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                                fontSize: 20,
                                                                color: Colors
                                                                    .white),
                                                      ),
                                                      SizedBox(
                                                        height: 5,
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .symmetric(
                                                                horizontal: 5,
                                                                vertical: 2),
                                                        child: Container(
                                                            child: Column(
                                                          children: [
                                                            Text(
                                                              special,
                                                              style: GoogleFonts
                                                                  .poppins(
                                                                      color: Colors
                                                                          .white),
                                                            ),
                                                            Text(
                                                                "Total Cases: ${snap[index]['totalCases']}",
                                                                style:
                                                                    GoogleFonts
                                                                        .poppins(
                                                                  color: Colors
                                                                      .white,
                                                                )),
                                                            Text(
                                                                "Wins: ${snap[index]['wonCases']}",
                                                                style:
                                                                    GoogleFonts
                                                                        .poppins(
                                                                  color: Colors
                                                                      .white,
                                                                )),
                                                          ],
                                                        )),
                                                      )
                                                    ]),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              );
                            } else {
                              return Container();
                            }
                          },
                        );
                      }
                    }))
          ],
        ),
      ),
    );
  }
}
