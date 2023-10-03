import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class profilecon extends StatelessWidget {
  final String data;
  final String datadesc;

  const profilecon({super.key,required this.data,required this.datadesc});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(data,
                style: GoogleFonts.poppins(
                    fontSize: 20, fontWeight: FontWeight.w400)),
            SizedBox(
              height: 5,
            ),
            Text(
              datadesc,
              style: GoogleFonts.poppins(
                  fontSize: 15, fontWeight: FontWeight.w400),
            ),
          ]),
    );
  }
}
