import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class addservice extends StatefulWidget {
  const addservice({super.key});

  @override
  State<addservice> createState() => _addserviceState();
}

class _addserviceState extends State<addservice> {
  TextEditingController service=TextEditingController();
  List<String> lawyerServices = [
    'All',
  'Legal Advisory',
  'Case Filing',
  'Bail',
  'Notary Services',
  'Document Writing',
  'License Consultation',
  'Vehicle Registration',
];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      appBar: AppBar(
        // backgroundColor: Color.fromARGB(255, 52, 103, 255),
        automaticallyImplyLeading: false,
        toolbarHeight: 140,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 50,),
            IconButton(
              onPressed: (){
                Navigator.pop(context);
              },
              icon: Icon(CupertinoIcons.arrow_left)),
            SizedBox(height: 10,),
            Padding(
              padding: const EdgeInsets.only(bottom: 40,left: 10),
              child: Text("Pick your service",style: TextStyle(fontFamily: "PT Sans",fontSize: 30),),
            ),
          ],
        ),
      ),
      // backgroundColor: Color.fromARGB(255, 241, 243, 247),
      body: Column(children: [
        SizedBox(height: 20,),
         Container(
            padding: EdgeInsets.all(16.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search Service',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(30)),

              ),
              // onChanged: filterData,
            ),
          ),
        
          
                Padding(
                  padding: const EdgeInsets.only(left: 10.0),
                  child: Container(
                  height: 60, // Set the height of the container
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: lawyerServices.length,
                    itemBuilder: (context, count) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          width: 80,
                          decoration: BoxDecoration(
                            
                            color: count==0? Color.fromARGB(255, 52, 103, 255): Colors.grey.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Center(
                              child: Text(
                                lawyerServices[count],
                                style: TextStyle(
                                  fontFamily: "Roboto Mono ",
                                  // color: count==0? Colors.white: Colors.black,
                                  color: Colors.white,
                                  fontSize: 15,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                maxLines: 1,
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                ),
                
        
      ],),
      
    );
  }
}