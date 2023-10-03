import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:legal_ease/auth/advojudge.dart';
import 'package:legal_ease/auth/login_page.dart';
import 'package:legal_ease/components/roundbutton.dart';
import 'package:legal_ease/auth/client.dart';



class signup_screen extends StatefulWidget {
  const signup_screen({super.key});

  @override
  State<signup_screen> createState() => _signup_screenState();
}

class _signup_screenState extends State<signup_screen> {


  bool loading=false;
  final _FormKey=GlobalKey<FormState>();
  final TextEditingController firstnamecontroller=TextEditingController();
  final TextEditingController lastnamecontroller=TextEditingController();
  final TextEditingController emailcontroller= TextEditingController();
  final TextEditingController passwordcontroller=TextEditingController();
  
  
  String dropdownvalue ='Select role';
  var items = [    
    'Select role',
    
    'Client',
    'Advocate',
    'Judge',
  ];


  
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: ()async{
        SystemNavigator.pop();
        return true;
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.black,
        body: SafeArea(
          child: Padding(
            padding:  EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // SizedBox(height: MediaQuery.of(context).size.height*0.01,),
                Flexible(child: Container(),flex: 1,),
                Column(children: [
                  Image(image: AssetImage('images/justice.png'),height: 200,width: 300,),
                
                            Form(
                key: _FormKey,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                
                  child: Column(children: [
                    SizedBox(height: 30,),
                    TextFormField(
                      controller: firstnamecontroller,
                      validator: (value){
                          if(value!.isEmpty){
                            return "Enter First Name";
                          }
                          
                          return null;
                        },
                      decoration: InputDecoration(hintText: "First Name",
                      prefixIcon: Icon(Icons.people),
                      fillColor: Colors.grey.withOpacity(0.1),
                      filled: true,
                       border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                       
                       ),
                      
                      ),
                      SizedBox(height: 25,),
                      TextFormField(
                      controller: lastnamecontroller,
                      validator: (value){
                          if(value!.isEmpty){
                            return "Enter Last Name";
                          }
                          
                          return null;
                        },
                      decoration: InputDecoration(hintText: "Last Name",
                      prefixIcon: Icon(Icons.people_rounded),
                      fillColor: Colors.grey.withOpacity(0.1),
                      filled: true,
                       border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                       
                       ),
                      
                      ),
                      SizedBox(height: 25,),
                
                
                      
                
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
                              Icon(Icons.emoji_people),
                              SizedBox(width: 10,),
                              Expanded(
                                child: DropdownButton(
                              
                                underline: SizedBox(),              
                                isExpanded: true,
                                hint: Text('Select role',style: TextStyle(color: Colors.grey),),
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
                   
                      SizedBox(height: 50,),
                      Roundbutton(Title: "Next",
                      loading: loading,
                      onTap: (){
                        if(_FormKey.currentState!.validate()){
                          dropdownvalue=='Client'? Navigator.push(context, MaterialPageRoute(builder: (context)=> client(firstname: firstnamecontroller.text.toString(), lastname: lastnamecontroller.text.toString(), role: dropdownvalue)))
                          : Navigator.push(context, MaterialPageRoute(builder: (context)=> advojudge(firstname: firstnamecontroller.text.toString(), lastname: lastnamecontroller.text.toString(), role: dropdownvalue)));
                          
                        }
                      },),
                      SizedBox(height: 20,),
                      Text("OR",style: TextStyle(fontSize: 18),),
                      // SizedBox(height: 20,),
                      
                        SizedBox(height: 10,),
                        Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                        Text("Already have an account? ",style: TextStyle(fontSize: 16),),
                        InkWell(
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context)=> login_screen()));
                          },
                          child: Text("Log in",style: TextStyle(color: Color.fromARGB(237, 255, 136, 0),decoration: TextDecoration.underline,fontSize: 16),))
                      ],),
                
                
                
                      
                    
                  ]),
                ),
                            ),
                ]),
              Flexible(child: Container(),flex: 1,)
            ]),
          ),
        ),
      ),
    );
  }
}
  
