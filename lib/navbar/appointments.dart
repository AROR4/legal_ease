import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:legal_ease/view/addservice.dart';

class appointpage extends StatefulWidget {
  const appointpage({super.key});

  @override
  State<appointpage> createState() => _appointpageState();
}

class _appointpageState extends State<appointpage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        // centerTitle: true,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.black38,
        // backgroundColor: Color.fromARGB(255, 241, 243, 247),
       title: Row(
         children: [
          SizedBox(width: 10,),
           Text("Service History",style: GoogleFonts.raleway(
            fontWeight: FontWeight.w600,
            fontSize: 25,
           )
            ,),
         ],
       ),
        elevation: 0,
        
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(12.0),
        child: FloatingActionButton(onPressed: (){
           Navigator.push(context, MaterialPageRoute(builder: ((context) => addservice())));
        },
        // backgroundColor: Color.fromARGB(255, 52, 103, 255),
        backgroundColor: Colors.black,
      
        tooltip: 'Add',
        hoverElevation: 23,
        child: Icon(Icons.calendar_month,color: Colors.white,),
        ),
      ),
      // backgroundColor: Color.fromARGB(255, 241, 243, 247),
        body: Divider(color: Colors.white,thickness: 1,),
      
    );
  }
}