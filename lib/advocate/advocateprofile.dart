import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:legal_ease/chat/chatpage.dart';
import 'package:legal_ease/components/bluebutton.dart';
import 'package:legal_ease/components/profilecontainer.dart';
import 'package:legal_ease/resources/follow.dart';

import 'package:percent_indicator/circular_percent_indicator.dart';

class advocatedash extends StatefulWidget {
  final String photourl;
  final String email;
  final String name;
  final String cases;
  final String wins;
  final List<String> services;
  final String uid;
  advocatedash({
    super.key,
    required this.email,
    required this.name,
    required this.cases,
    required this.wins,
    required this.photourl,
    required this.services,
    required this.uid,
  });

  @override
  State<advocatedash> createState() => _advocatedashState();
}

class _advocatedashState extends State<advocatedash> {
  late String email;
  late String password;

  @override
  Widget build(BuildContext context) {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    final FirebaseFirestore _firestore = FirebaseFirestore.instance;
    double num = int.parse(widget.wins) / int.parse(widget.cases);
    return Scaffold(
      backgroundColor: Colors.black12,
      appBar: AppBar(
        toolbarHeight: 40,
        // iconTheme: IconThemeData.fallback(),
        backgroundColor: Colors.black,
        title: Text(
          widget.email,
          style: TextStyle(color: Colors.white),
        ),
        elevation: 4,
        actions: [
          IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.menu,
                color: Colors.black,
              ))
        ],
      ),
      // backgroundColor: Color.fromARGB(255, 241, 243, 247),
      body: SingleChildScrollView(
        child: SafeArea(
            child: Column(
          children: [
            Divider(
              color: Colors.white,
              thickness: 1,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.03,
                        ),
                        CircleAvatar(
                          backgroundImage: NetworkImage(widget.photourl),
                          backgroundColor: Colors.white,
                          radius: 40,
                        ),
                        Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.05,
                              ),
                              StreamBuilder(
                                  stream: _firestore
                                      .collection('users')
                                      .doc(widget.uid)
                                      .snapshots(),
                                  builder: (context, snapshot) {
                                    if (!snapshot.hasData ||
                                        snapshot.data == null) {
                                      return profilecon(
                                          data: 100.toString(),
                                          datadesc: "Followers");
                                    } else {
                                      var followers = snapshot.data!
                                          .get('followers') as List<dynamic>;

                                      return profilecon(
                                          data: followers.length.toString(),
                                          datadesc: "Followers");
                                    }
                                  }),
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.05,
                              ),
                              profilecon(data: widget.cases, datadesc: "Cases"),
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.05,
                              ),
                              profilecon(
                                  data: widget.wins, datadesc: "Won Cases"),
                            ],
                          ),
                        )
                      ],
                    ),
                    SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.only(left: 5),
                      child: Text(
                        widget.name,
                        style: GoogleFonts.poppins(
                            fontSize: 15, fontWeight: FontWeight.w300),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Row(
                      
                        children: [
                          Expanded(
                            child: StreamBuilder(
                                stream: _firestore
                                    .collection('users')
                                    .doc(widget.uid)
                                    .snapshots(),
                                builder: (context, snapshot) {
                                  if (!snapshot.hasData ||
                                      snapshot.data == null) {
                                    return InkWell(
                                        onTap: () async {},
                                        child: bluebutton(
                                            label: "Follow", width: 150));
                                  } else {
                                    var followers = snapshot.data!
                                        .get('followers') as List<dynamic>;
                                    return InkWell(
                                        onTap: () async {
                                          firestore_methods().followuser(
                                              _auth.currentUser!.uid, widget.uid);
                                        },
                                        child: bluebutton(
                                          label: followers.contains(
                                                  _auth.currentUser!.uid)
                                              ? "Following"
                                              : "Follow",
                                          width: 150,
                                          color: followers.contains(
                                                  _auth.currentUser!.uid)
                                              ? Color.fromARGB(255, 86, 84, 84)
                                              : Color.fromARGB(255, 52, 103, 255),
                                        ));
                                  }
                                }),
                          ),
                          SizedBox(width: MediaQuery.of(context).size.width*0.1,),
                              Expanded(
                                child: StreamBuilder(
                                stream: _firestore
                                    .collection('users')
                                    .doc(widget.uid)
                                    .snapshots(),
                                builder: (context, snapshot) {
                                  if (!snapshot.hasData ||
                                      snapshot.data == null) {
                                    return InkWell(
                                        onTap: () async {},
                                        child: bluebutton(
                                            label: "Connect+", width: 150));
                                  } else {
                                    var connect = snapshot.data!
                                        .get('connect') as List<dynamic>;
                                    return InkWell(
                                        onTap: () async {
                                          firestore_methods().connectuser(
                                              _auth.currentUser!.uid, widget.uid);
                                        },
                                        child: InkWell(
                                          onTap: (){
                                            if(connect.contains(_auth.currentUser!.uid)){
                                              Navigator.push(context, MaterialPageRoute(builder: (context)=>chatscreen(userid: snapshot.data!.get('uid'), username: "${snapshot.data!.get('firstname')} ${snapshot.data!.get('lastname')}")));
                                            }
                                          },
                                          child: bluebutton(
                                            label: connect.contains(
                                                    _auth.currentUser!.uid)
                                                ? "Message"
                                                : "Connect",
                                            width: 150,
                                            color: connect.contains(
                                                    _auth.currentUser!.uid)
                                                ? Color.fromARGB(255, 86, 84, 84)
                                                : Color.fromARGB(255, 52, 103, 255),
                                          ),
                                        ));
                                  }
                                }),
                              ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.white),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Center(
                            child: Column(
                          children: [
                            SizedBox(
                              height: 20,
                            ),
                            CircularPercentIndicator(
                                radius: 75,
                                lineWidth: 15.0,
                                percent: num,
                                center: Text(
                                    "${(num * 100).toStringAsFixed(2)} %",
                                    style: GoogleFonts.poppins(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w400)),
                                linearGradient: const LinearGradient(
                                    begin: Alignment.topRight,
                                    end: Alignment.bottomLeft,
                                    colors: <Color>[
                                      Color.fromARGB(188, 115, 1, 255),
                                      Color.fromARGB(136, 179, 80, 241)
                                    ]),
                                rotateLinearGradient: true,
                                circularStrokeCap: CircularStrokeCap.round),
                            SizedBox(
                              height: 10,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 10),
                              child: Text(
                                "Win Percentage",
                                style: GoogleFonts.poppins(
                                    fontSize: 20, fontWeight: FontWeight.w500),
                              ),
                            )
                          ],
                        )),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Container(
                        height: 220,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.white),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Center(
                            child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 20,
                            ),
                            Center(
                              child: Text(
                                "Top Services",
                                style: GoogleFonts.poppins(fontSize: 20),
                              ),
                            ),
                            Expanded(
                              child: ListView.builder(
                                itemCount: widget.services.length,
                                itemBuilder: (context, index) {
                                  final service = widget.services[index];
                                  return Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 12),
                                    child: Container(
                                      margin: EdgeInsets.symmetric(
                                          vertical:
                                              8.0), // Optional: Add vertical margin between containers
                                      child: Text(
                                        "${index + 1}. $service",
                                        style: GoogleFonts.poppins(
                                            fontSize:
                                                15), // Customize text style
                                      ),
                                    ),
                                  );
                                },
                              ),
                            )
                          ],
                        )),
                      ),
                    ),
                  ]),
            ),
          ],
        )),
      ),
    );
  }
}
