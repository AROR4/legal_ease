import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:legal_ease/advocate/getstartedadv.dart';
import 'package:legal_ease/auth/login_page.dart';
import 'package:legal_ease/components/roundbutton.dart';

import 'package:icons_plus/icons_plus.dart';
import 'package:http/http.dart'as http;
import 'dart:convert';

import 'package:legal_ease/resources/auth_methods.dart';
import 'package:legal_ease/client/getstartedclient.dart';

class advojudge extends StatefulWidget {

  final String firstname;
  final String lastname;
  final String role;

  const advojudge({super.key, required this.firstname, required this.lastname , required this.role});

  


  @override
  State<advojudge> createState() => _advojudgeState();
}

class _advojudgeState extends State<advojudge> {
  bool loading=false;
  final _FormKey=GlobalKey<FormState>();
  final TextEditingController empid=TextEditingController();
  final TextEditingController mobilecontroller=TextEditingController();
   final TextEditingController adharnocontroller=TextEditingController();
  final TextEditingController emailcontroller= TextEditingController();
  final TextEditingController passwordcontroller=TextEditingController();
  



Future<void> signup() async {
    setState(() {
      loading = true;
    });
    if (_FormKey.currentState!.validate()) {
      String res = await Authmethods().signUpUseradv(
          email: emailcontroller.text.toString(),
          password: passwordcontroller.text.toString(),
          );
    
      if (res == "success") {
        setState(() {
          loading = false;
        });
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => start_adv(firstname: widget.firstname,
          lastname: widget.lastname,
          email: emailcontroller.text.toString(),
          mobile: mobilecontroller.text.toString(),
          aadhar: adharnocontroller.text.toString(),
          role: widget.role, idnumber: empid.text.toString(),)));
      } else {
        setState(() {
          loading = false;
        });
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(res)));
      }
    }
  }






// Future<void> signup() async{
//       final response =await http.post(Uri.parse('http://ec2-54-91-24-12.compute-1.amazonaws.com/signup'),
//       headers: <String, String>{
//     'Content-Type': 'application/json; charset=UTF-8',
//   },
//       body: jsonEncode(<String, String>{
//       "firstname": widget.firstname,
//       "lastname": widget.lastname,
//       "role" : widget.role,
//       "empid": empid.text.toString(),
//       "mobile": mobilecontroller.text.toString(),
//       "adhar": adharnocontroller.text.toString(),
//       "email": emailcontroller.text.toString(),
//       "password" : passwordcontroller.text.toString(),
//       "special" : special.text.toString(), 

//     })
//       );
//       if(response.statusCode==200){
//         Navigator.push(context, MaterialPageRoute(builder: (context)=> login_screen()));
//       }
//       else if(response.statusCode==401){
//         ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: const Text('Email already taken'),
//             duration: const Duration(seconds: 2),));
//       }
//       else{
//          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content:  Text('Internl error occured '+ response.statusCode.toString()),
//             duration: const Duration(seconds: 2),));
//       }
//       }
      
  



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding:  EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: MediaQuery.of(context).size.height*0.01,),
                Image(image: AssetImage('images/justice.png'),height: 200,width: 300,),
                
              Form(
                key: _FormKey,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                
                  child: Column(children: [
                    SizedBox(height: 30,),
                      TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      validator: (value){
                          if(value!.isEmpty){
                            return "Enter E-mail";
                          }
                          if(!(value.contains("@") && (value.contains(".com") || value.contains(".in") || value.contains(".org")|| value.contains(".co.in")))){
                            return "Enter Valid E-mail id";
                          }
                          return null;
                        },
                      controller: emailcontroller,
                      decoration: InputDecoration(hintText: "Email",
                      prefixIcon: Icon(Icons.email_outlined),
                      fillColor: Colors.grey.withOpacity(0.1),
                      filled: true,
                       border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                       
                       ),
                      
                      ),
                      SizedBox(height: 25,),
                      TextFormField(
                      controller: passwordcontroller,
                      obscureText: true,
                      validator: (value){
                          if(value!.isEmpty){
                            return "Enter Password";
                          }
                          
                          return null;
                        },
                      decoration: InputDecoration(hintText: "Password",
                      prefixIcon: Icon(Icons.lock),
                      fillColor: Colors.grey.withOpacity(0.1),
                      filled: true,
                       border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                       
                       ),
                      
                      ),
                      SizedBox(height: 25,),
                      TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      validator: (value){
                          if(value!.isEmpty){
                            return "Enter Empid";
                          }
                          
                          return null;
                        },
                      controller: empid,
                      decoration: InputDecoration(hintText: "Enter your Emp id",
                      prefixIcon: Icon(IonIcons.id_card),
                      fillColor: Colors.grey.withOpacity(0.1),
                      filled: true,
                       border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                       
                       ),
                      
                      ),
                      SizedBox(height: 25,), 
                    TextFormField(
                      keyboardType: TextInputType.phone,
                      validator: (value){
                          if(value!.isEmpty){
                            return "Enter Mobile Number";
                          }
                          
                          return null;
                        },
                      controller: mobilecontroller,
                      decoration: InputDecoration(hintText: "Enter your mobile number",
                      prefixIcon: Icon(Icons.phone),
                      fillColor: Colors.grey.withOpacity(0.1),
                      filled: true,
                       border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                       
                       ),
                      
                      ),
                      SizedBox(height: 25,),

                      TextFormField(
                      controller: adharnocontroller,
                     
                      validator: (value){
                          if(value!.isEmpty){
                            return "Enter Adhaar No";
                          }
                          if(value.length!=12){
                            return "Enter Valid Adhaar No";
                          }
                          
                          return null;
                        },
                      decoration: InputDecoration(hintText: "Enter your Adhaar No",
                      prefixIcon: Icon(Icons.perm_identity_sharp),
                      fillColor: Colors.grey.withOpacity(0.1),
                      filled: true,
                       border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                       
                       ),
                      
                      ),
                    
                      SizedBox(height: 50,),
                      Roundbutton(Title: "Signup",
                      loading: loading,
                      onTap: (){
                        setState(() {
                          loading=true;
                        });
                        if(_FormKey.currentState!.validate()){
                          
                         signup();
                          
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
              )
            ]),
          ),
        ),
      ),
    );
  }
}
  


