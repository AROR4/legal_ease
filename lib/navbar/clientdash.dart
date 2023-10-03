import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:legal_ease/Model/users.dart';
import 'package:legal_ease/navbar/clientprofile.dart';
import 'package:legal_ease/providers/user_provider.dart';
import 'package:legal_ease/view/searchuser.dart';
import 'package:provider/provider.dart';

class clientdash extends StatefulWidget {
  const clientdash({super.key});

  @override
  State<clientdash> createState() => _clientdashState();
}

class _clientdashState extends State<clientdash> {
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
      return 'Good Morning,';
    } else if (now.hour < 17) {
      return 'Good Afternoon,';
    } else {
      return 'Good Evening,';
    }
  }

  @override
  Widget build(BuildContext context) {
    final FirebaseFirestore _firestore = FirebaseFirestore.instance;
    Clientuser clientuser = Provider.of<UserProvider>(context).getClientUser;
    return Scaffold(
        backgroundColor: Colors.black,
        body: SafeArea(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 12, bottom: 12, left: 12),
                  child: Row(children: [
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            
                          },
                          child: CircleAvatar(
                            backgroundColor: Color.fromARGB(255, 39, 110, 241),
                            radius: 30,
                            child: Text(
                              clientuser.firstname[0].toUpperCase(),
                              style:
                                  TextStyle(fontSize: 30, color: Colors.white),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 15,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              _getGreeting().toUpperCase(),
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
                  ]),
                ),
                SizedBox(
                  height: 20,
                ),
                Center(
                    child: Text(
                  "Legal Ease",
                  style: GoogleFonts.raleway(
                      color: Colors.white,
                      fontSize: 30,
                      fontWeight: FontWeight.bold),
                )),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                        margin: EdgeInsetsDirectional.all(
                            MediaQuery.of(context).size.width * 0.03),
                        decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(color: Colors.white)),
                        child: Padding(
                          padding: const EdgeInsets.all(32.0),
                          child: Column(
                            children: [
                              // Flexible(child: Container()),
                              Image.asset(
                                'images/court-house.png',
                                height: 50,
                                width: 50,
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                "Find a Lawyer",
                                style: GoogleFonts.poppins(
                                    color: Colors.white,
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold),
                              ),
                              // Flexible(child: Container())
                            ],
                          ),
                        )),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => searchlawyer1()));
                      },
                      child: Container(
                          margin: EdgeInsetsDirectional.all(
                              MediaQuery.of(context).size.width * 0.03),
                          decoration: BoxDecoration(
                              color: Colors.black,
                              borderRadius: BorderRadius.circular(16),
                              border: Border.all(color: Colors.white)),
                          child: Padding(
                            padding: const EdgeInsets.all(32.0),
                            child: Column(
                              children: [
                                // Flexible(child: Container()),
                                SvgPicture.asset(
                                  'images/lawhouse2.svg',
                                  height: 50,
                                  width: 50,
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  "Find a Lawyer",
                                  style: GoogleFonts.poppins(
                                      color: Colors.white,
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold),
                                ),
                                // Flexible(child: Container())
                              ],
                            ),
                          )),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>clientprofile()));
                        },
                        child: Container(
                          height: 170,
                            margin: EdgeInsetsDirectional.all(
                                MediaQuery.of(context).size.width * 0.03),
                            decoration: BoxDecoration(
                                color: Colors.black,
                                borderRadius: BorderRadius.circular(16),
                                border: Border.all(color: Colors.white)),
                            child: Padding(
                              padding: const EdgeInsets.all(32.0),
                              child: Column(
                                children: [
                                  Flexible(child: Container()),
                                  Image.asset(
                                    'images/avatar.png',
                                    height: 50,
                                    width: 50,
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    "My Account",
                                    style: GoogleFonts.poppins(
                                        color: Colors.white,
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Flexible(child: Container())
                                ],
                              ),
                            )),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        height: 170,
                        
                          margin: EdgeInsetsDirectional.all(
                              MediaQuery.of(context).size.width * 0.03),
                          decoration: BoxDecoration(
                              color: Colors.black,
                              borderRadius: BorderRadius.circular(16),
                              border: Border.all(color: Colors.white)),
                          child: Padding(
                            padding: const EdgeInsets.all(32.0),
                            child: Column(
                              children: [
                                Flexible(child: Container()),
                                Image.asset(
                                  'images/lawyer.png',
                                  height: 50,
                                  width: 50,
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  "My Lawyers",
                                  style: GoogleFonts.poppins(
                                      color: Colors.white,
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold),
                                ),
                                Flexible(child: Container()),
                              ],
                            ),
                          )),
                    ),
                  ],
                ),
              ]),
        ));
  }
}
