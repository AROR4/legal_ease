import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:legal_ease/Model/users.dart';
import 'package:legal_ease/auth/login_page.dart';
import 'package:legal_ease/providers/user_provider.dart';
import 'package:legal_ease/view/searchuser.dart';
import 'package:provider/provider.dart';

class homepage extends StatefulWidget {
  const homepage({super.key});

  @override
  State<homepage> createState() => _homepageState();
}

class _homepageState extends State<homepage> {
  
  late String email;
  late String password;
  List<String> pics = [
    'images/crime.png',
    'images/certificate.png',
    'images/file.png',
    'images/consultation.png',
    'images/prison.png'
  ];

  List<String> services = [
    'Case Filing',
    'Notary',
    'Document Write',
    'Legal Advice',
    'Bail '
  ];

  String _getGreeting() {
    final now = DateTime.now();
    if (now.hour < 12) {
      return 'Good Morning';
    } else if (now.hour < 17) {
      return 'Good Afternoon';
    } else {
      return 'Good Evening';
    }
  }

  @override
  Widget build(BuildContext context) {
    
    final FirebaseFirestore _firestore = FirebaseFirestore.instance;
    Clientuser clientuser = Provider.of<UserProvider>(context).getClientUser;
    String role = Provider.of<UserProvider>(context).getrole;
    Map<String, double>? ratings =
        Provider.of<UserProvider>(context).getratings;
    final list = ratings.entries.toList();
    list.sort((a, b) => b.value.compareTo(a.value));
    Map<String, double> sortedratings = Map.fromEntries(list);

    return WillPopScope(
      onWillPop: () async {
        SystemNavigator.pop();
        return true;
      },
      child: Scaffold(
          backgroundColor: Colors.black,
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 12, bottom: 12, left: 12),
                      child: Row(
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      print(sortedratings);
                                    },
                                    child: CircleAvatar(
                                      backgroundColor:
                                          Color.fromARGB(255, 39, 110, 241),
                                      radius: 30,
                                      child: Text(
                                        clientuser.firstname[0].toUpperCase(),
                                        style: TextStyle(
                                            fontSize: 30, color: Colors.white),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 15,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        _getGreeting(),
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 15,
                                            fontFamily: "PT Sans"),
                                      ),
                                      // SizedBox(height: 5,),
                                      Text(
                                          "${clientuser.firstname} ${clientuser.lastname}"
                                              .toUpperCase(),
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 20,
                                              fontFamily: "PT Sans",
                                              fontWeight: FontWeight.bold)),
                                    ],
                                  )
                                ],
                              ),
                            ],
                          ),
                          Expanded(
                            // Wraps the icon in an Expanded widget
                            child: Align(
                              alignment: Alignment.centerRight,
                              child: Column(
                                children: [
                                  IconButton(
                                      onPressed: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    searchlawyer1()));
                                        //  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(sp.getString('empid')!)));
                                      },
                                      icon: Icon(
                                        CupertinoIcons.search,
                                        size: 30,
                                      )),
                                ],
                              ),
                            ),
                          )

                          // CircleAvatar(child: Icon(Icons.perm_identity,color: Colors.black,),radius: 25,backgroundColor: Colors.grey),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 12.0),
                      child: Row(
                        children: [
                          Text(
                            "Services ",
                            style: TextStyle(
                                fontFamily: 'PT Sans',
                                fontWeight: FontWeight.w300,
                                fontSize: 18),
                          ),
                          Expanded(
                              child: Align(
                                  alignment: Alignment.centerRight,
                                  child: Container(
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(18),
                                        border:
                                            Border.all(color: Colors.white)),
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          top: 2.0,
                                          right: 2,
                                          bottom: 3,
                                          left: 5),
                                      child: Text(
                                        role,
                                        style: TextStyle(
                                            fontFamily: 'PT Sans',
                                            fontWeight: FontWeight.w300,
                                            fontSize: 18),
                                      ),
                                    ),
                                  ))),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10.0),
                      child: Container(
                        height: 120, // Set the height of the container
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: pics.length,
                          itemBuilder: (context, count) {
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: InkWell(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => searchlawyer1(
                                                search: services[count],
                                              )));
                                },
                                child: Container(
                                  decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                      // borderRadius: BorderRadius.circular(15),
                                      // color: Color.fromARGB(186, 204, 200, 200),
                                      gradient: LinearGradient(colors: [
                                        Color.fromARGB(185, 244, 238, 238),
                                        Colors.white12
                                      ])),
                                  child: Padding(
                                    padding: const EdgeInsets.all(16.0),
                                    child: Image(
                                      image: AssetImage(pics[count]),
                                      fit: BoxFit.fitHeight,
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 12.0),
                      child: Row(
                        children: [
                          Text(
                            "Top Lawyers",
                            style: TextStyle(
                                fontFamily: 'PT Sans',
                                fontWeight: FontWeight.w300,
                                fontSize: 18),
                          ),
                          Expanded(
                              child: Align(
                                  alignment: Alignment.centerRight,
                                  child: Text(
                                    "See All ",
                                    style: TextStyle(
                                        fontFamily: 'PT Sans',
                                        fontWeight: FontWeight.w300,
                                        fontSize: 18),
                                  ))),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10.0),
                      child: Container(
                        height: 240,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: 3,
                          itemBuilder: (context, count) {
                            List<String> keysList = sortedratings.keys.toList();
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: GestureDetector(
                                onTap: () {
                                  // Navigator.push(context,MaterialPageRoute(builder: (context)=> advocatedash(
                                  //                 email: snapshot.data![count]['email'], name: "${snapshot.data![count]['firstname']} ${snapshot.data![count]['lastname']}", wins: snapshot.data![count]['wins'],
                                  //                 cases: snapshot.data![count]['total'],
                                  //           )));
                                },
                                child: Container(
                                  width: 270,
                                  decoration: BoxDecoration(
                                    // backgroundBlendMode: BlendMode.overlay,
                                    color: Colors.white,
                                    gradient: LinearGradient(colors: [
                                        Color.fromARGB(185, 244, 238, 238),
                                        Colors.white12
                                      ]),
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  
                                  child: Padding(
                                    padding: const EdgeInsets.all(20.0),
                                    child: Center(
                                      child: FutureBuilder(
                                        future: _firestore
                                            .collection('users')
                                            .doc(keysList[count])
                                            .get(),
                                        builder: (context, snapshot) {
                                          if (!snapshot.hasData) {
                                            return Center(
                                              child:
                                                  CircularProgressIndicator(),
                                            );
                                          } else {
                                             
                                            return Row(
                                              children: [
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      "${snapshot.data!['firstname']} ${snapshot.data!['lastname']}",
                                                      style: TextStyle(
                                                        fontFamily:
                                                            "Roboto Mono ",
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 15,
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: 5,
                                                    ),
                                                    Text(
                                                      snapshot.data!
                                                          ['specialisation'],
                                                      style: TextStyle(
                                                        fontFamily: "PT Sans ",
                                                        fontSize: 15,
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: 15,
                                                    ),
                                                    Row(
                                                      children: [
                                                        Icon(
                                                          CupertinoIcons
                                                              .star_fill,
                                                          color: Colors.yellow,
                                                          size: 15,
                                                        ),
                                                        SizedBox(
                                                          width: 5,
                                                        ),
                                                        Text(sortedratings[keysList[count]]!.toStringAsFixed(2),style: TextStyle(
                                                        fontFamily: "PT Sans ",
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 15,
                                                      ),)
                                                       
                                                      ],
                                                    ),
                                                    SizedBox(
                                                      height: 10,
                                                    ),
                                                    Text(
                                                      "Experience ",
                                                      style: TextStyle(
                                                        fontFamily: "PT Sans ",
                                                        fontSize: 15,
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: 5,
                                                    ),
                                                    Text(
                                                      "8 Years ",
                                                      style: TextStyle(
                                                        fontFamily: "PT Sans ",
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 15,
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: 10,
                                                    ),
                                                    Text(
                                                      "Cases",
                                                      style: TextStyle(
                                                        fontFamily: "PT Sans ",
                                                        fontSize: 15,
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: 5,
                                                    ),
                                                    Text(
                                                      snapshot.data!
                                                          ['totalCases'],
                                                      style: TextStyle(
                                                        fontFamily: "PT Sans ",
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 15,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(width: 10,),
                                              Expanded(
                                                child: CircleAvatar(
                                                backgroundImage: NetworkImage(snapshot.data!['photourl']),
                                                radius: 80,
                                              ),
                                              ) 
                                              

                                              ],
                                            );
                                          }
                                        },
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ]),
            ),
          )),
    );
  }
}
