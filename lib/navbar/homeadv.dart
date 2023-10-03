import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:legal_ease/Model/users.dart';
import 'package:legal_ease/auth/login_page.dart';
import 'package:legal_ease/providers/user_provider.dart';
import 'package:provider/provider.dart';

class homeadv extends StatefulWidget {
  const homeadv({super.key});

  @override
  State<homeadv> createState() => _homeadvState();
}

class _homeadvState extends State<homeadv> {
  final FirebaseAuth _auth =FirebaseAuth.instance;
  
  @override
  Widget build(BuildContext context) {
    bool c1=false;
    bool c2=false;
    bool c3=false;
    bool c4=false;

    Advocate advocate=Provider.of<UserProvider>(context).getAdvocate;
    return WillPopScope(
      onWillPop: () async{
        SystemNavigator.pop();
        return true;
      },
      child: Scaffold(
        // backgroundColor: Colors.black,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          actions: [IconButton(onPressed: (){
    _auth.signOut();
    Navigator.push(context, MaterialPageRoute(builder: ((context) => login_screen())));
        }, icon: Icon(Icons.back_hand) )]),
        body: Center(child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  margin: EdgeInsetsDirectional.all(MediaQuery.of(context).size.width*0.03),
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: Colors.white)
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(35.0),
                    child: Column(
                      children: [
                        // Flexible(child: Container()),
                        SvgPicture.asset('images/lawhouse2.svg',height: 50,width: 50,),
                        SizedBox(height: 10,),
                        Text("Find a Lawyer",style: GoogleFonts.poppins(color: Colors.white),),
                        // Flexible(child: Container())
                      ],
                    ),
                  )),
                  GestureDetector(
                    
                    onTap: (){
                     setState(() {
                       c2=true;
                       print("Container tapped, c2 is now true: $c2");
                     });
                    },
                    child: Container(
                      margin: EdgeInsetsDirectional.all(MediaQuery.of(context).size.width*0.03),
                    decoration: BoxDecoration(
                      color: c2 == true ? Color.fromRGBO(230, 197, 10, 0.88) : Colors.black,

                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: Colors.white)
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(35.0),
                      child: Column(
                        children: [
                          // Flexible(child: Container()),
                          SvgPicture.asset('images/lawhouse2.svg',height: 50,width: 50,),
                          SizedBox(height: 10,),
                          Text("Find a Lawyer",style: GoogleFonts.poppins(color: Colors.white),),
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
                Container(
                  margin: EdgeInsetsDirectional.all(MediaQuery.of(context).size.width*0.03),
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: Colors.white)
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(35.0),
                    child: Column(
                      children: [
                        // Flexible(child: Container()),
                        SvgPicture.asset('images/lawhouse2.svg',height: 50,width: 50,),
                        SizedBox(height: 10,),
                        Text("Find a Lawyer",style: GoogleFonts.poppins(color: Colors.white),),
                        // Flexible(child: Container())
                      ],
                    ),
                  )),
                  Container(
                    margin: EdgeInsetsDirectional.all(MediaQuery.of(context).size.width*0.03),
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: Colors.white)
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(35.0),
                    child: Column(
                      children: [
                        SvgPicture.asset('images/lawhouse2.svg',height: 50,width: 50,),
                        SizedBox(height: 10,),
                        Text("Find a Lawyer",style: GoogleFonts.poppins(color: Colors.white),),
                      ],
                    ),
                  )),
              ],
            ),
          ],
        )),
      ),
    );
  }
}