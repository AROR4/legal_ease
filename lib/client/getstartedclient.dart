import 'package:flutter/material.dart';
import 'package:legal_ease/components/roundbutton.dart';
import 'package:legal_ease/navbar/navbar.dart';

class start_client extends StatefulWidget {
  const start_client({super.key});

  @override
  State<start_client> createState() => _start_clientState();
}

class _start_clientState extends State<start_client> {


  String dropdownvalue ='Select Your Language';
  var items = [    
    'Select Your Language',
    
    'English',
    'Hindi',
    'Marathi',
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(

        child: Padding(
          padding: const EdgeInsets.all(23.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
            Flexible(child: Container(),flex: 1,),
            Image.asset('images/languages.png',height: 300,width: 300,),
            SizedBox(height: 10,),
            Text("Get Started!!",style: TextStyle(fontSize: 40,fontWeight: FontWeight.bold),),
            SizedBox(height: 15,),
            Container(
                          height: 62,
                          decoration: BoxDecoration( borderRadius: BorderRadius.circular(12),
                          color: Colors.grey.withOpacity(0.1),
                          border: Border.all(color: Colors.white54),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(right: 12,top: 10,bottom: 10,left: 6),
                            child: Row(
                              children: [
                                Icon(Icons.language),
                                SizedBox(width: 10,),
                                Expanded(
                                  child: DropdownButton(
                                
                                  underline: SizedBox(),              
                                  isExpanded: true,
                                  hint: Text('Select Your Language',style: TextStyle(color: Colors.grey),),
                                  borderRadius: BorderRadius.circular(12),
                                  
                                  value: dropdownvalue,
                                  focusColor: Colors.grey.withOpacity(0.1),
                                  
                                  icon: const Icon(Icons.keyboard_arrow_down),    
                                    
                                  items: items.map((String items) {
                                    return DropdownMenuItem(
                                      value: items,
                                      child: Text(items),
                                    );
                                  }).toList(),
                                  
                                  onChanged: (String? newValue) { 
                                    setState(() {

                                      dropdownvalue = newValue!;
                                    });
                                  },
                                                            ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 25,),
                        Roundbutton(Title: "Continue",
                        loading: false,
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>navbar()));
                            
                          }
                        ,),
                   Flexible(child: Container(),flex: 1,),     
                 

              
          ],),
        ),
      ),
    );
  }
}