import 'dart:async';
import 'package:flutter/material.dart';
import 'package:legal_ease/navbar/navbar.dart';
import 'package:legal_ease/providers/user_provider.dart';
import 'package:provider/provider.dart';


class splashscreen extends StatefulWidget {
  const splashscreen({super.key});

  @override
  State<splashscreen> createState() => _splashscreenState();
}

class _splashscreenState extends State<splashscreen> {


@override
  void initState() {
    super.initState();
    addData();
    user();
     }

  void user(){
    Timer(Duration(seconds: 4),()=> Navigator.pushReplacement(context,
     MaterialPageRoute(builder: ((context) => navbar1() ))));
  }   
  

  addData() async{
    UserProvider _userProvider = Provider.of(context ,listen: false);
    await _userProvider.refreshUser();
  }


  @override
  Widget build(BuildContext context) {
  
    return Scaffold( 
      backgroundColor: Colors.black,
      body: Center(child: Image.asset('images/justice.png')),
  
    ) ;
  }
}






// class _splashscreenState extends State<splashscreen> {
//   bool _initialized = false; // Add a flag to track initialization

//   @override
//   void initState() {
//     super.initState();
//     // Don't access context or Provider here.
//     // Perform initialization tasks in didChangeDependencies or Future.microtask.
//   }

//   @override
//   void didChangeDependencies() {
//     super.didChangeDependencies();
//     if (!_initialized) {
//       addData();
//       user();
//       _initialized = true; // Mark initialization as complete
//     }
//   }

//   void user() {
//     String role = Provider.of<UserProvider>(context).getrole;

//     if (role != "Client") {
//       Timer(
//         Duration(seconds: 3),
//         () => Navigator.push(context, MaterialPageRoute(builder: ((context) => homeadv()))),
//       );
//     } else {
//       Timer(
//         Duration(seconds: 3),
//         () => Navigator.push(context, MaterialPageRoute(builder: ((context) => navbar()))),
//       );
//     }
//   }

//   addData() async {
//     UserProvider _userProvider = Provider.of(context, listen: false);
//     await _userProvider.refreshUser();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.black,
//       body: Center(child: Image.asset('images/justice.png')),
//     );
//   }
// }
