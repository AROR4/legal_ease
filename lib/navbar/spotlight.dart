import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


class spotlight extends StatefulWidget {
  const spotlight({super.key});

  @override
  State<spotlight> createState() => _spotlightState();
}

class _spotlightState extends State<spotlight> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        toolbarHeight: 60,
        backgroundColor: Colors.black38,
        automaticallyImplyLeading: false,
        // centerTitle: true,
        title: Row(
          children: [
            SizedBox(width: 10,),
            Text(" Today's Spotlight",style: GoogleFonts.raleway(fontSize: 25,fontWeight: FontWeight.w600),),
          ],
        ),
      ),
      body: Column(
        children: [
          Divider(color: Colors.white,thickness: 1,),

          Expanded(
            child: ListView.builder(
              scrollDirection: Axis.vertical,
              itemCount: 3,
              itemBuilder: (context, count) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: 200,
                    decoration: BoxDecoration(
                      color: Color.fromARGB(255, 52, 103, 255),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: const Padding(
                      padding: const EdgeInsets.only(top: 25.0,left: 25,right: 25),
                      child: Center(
                        child: Column(
                          children: [
                            Text("Know Your Tenant Rights",style: TextStyle(fontFamily: "Roboto Mono",fontWeight: FontWeight.w600,fontSize: 20,
                            color: Colors.white
                            )),
                  
                            Column(
                              children: [
                                Text("Tenants have important rights, including a habitable living space, privacy, non-discrimination, and protection against unfair evictions. They can dispute deductions from security deposits and challenge rent increases while enjoying legal safeguards for peaceful living.",
                  
                                                              overflow: TextOverflow.ellipsis,
                                style: TextStyle(fontFamily: "Roboto Mono",fontWeight: FontWeight.w400,fontSize: 18,
                                color: Colors.white),
                                maxLines: 5,),
                                Text(
                                    "Read More",
                                    style: TextStyle(
                                        color: Color.fromARGB(235, 223, 123, 41),
                                        decoration: TextDecoration.underline,
                                        fontSize: 16),
                                  ),
                                
                              ],
                            ),
                  
                        ],
                        )
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}