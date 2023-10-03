import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:legal_ease/auth/login_page.dart';
import 'package:legal_ease/navbar/navbar.dart';
import 'package:legal_ease/splashscreen.dart';


class splashscreen2 extends StatefulWidget {
  const splashscreen2({super.key});

  @override
  State<splashscreen2> createState() => _splashscreen2State();
}

class _splashscreen2State extends State<splashscreen2> {

@override
  void initState() {
    splashservices splashservice=splashservices();
    // TODO: implement initState
    super.initState();

    splashservice.isLogin(context);
  }

  @override
  Widget build(BuildContext context) {
   
    return Scaffold(
        body: Center(
          child: Image.asset('images/justice.png'),
        ),
      );
  }
}



class splashservices{
  void isLogin(BuildContext context){
    final auth=FirebaseAuth.instance;

    final user=auth.currentUser;
    if(user != null){

    
    Timer(Duration(seconds: 1),()=> Navigator.push(context,
     MaterialPageRoute(builder: ((context) => splashscreen() ))));}
     else{
      Timer(Duration(seconds: 1),()=> Navigator.push(context,
     MaterialPageRoute(builder: ((context) => login_screen() ))));
     }
  }
  
}