import 'package:flutter/material.dart';

class bluebutton extends StatelessWidget {
  final String label;
  final double width;
  Color color;
   bluebutton({super.key,required this.label,required this.width,this.color=const Color.fromARGB(255, 52, 103, 255)});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: 50,
      decoration: BoxDecoration(
      color:  color,
      borderRadius: BorderRadius.circular(15),
       
    ),
    child: Center(child: Text(label,style: TextStyle(fontSize: 20,color: Colors.white,fontFamily: 'Mooli' ,fontWeight: FontWeight.w500),)),);
  }
}