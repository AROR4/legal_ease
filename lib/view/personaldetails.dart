import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart'as http;
import 'dart:convert';


class personal extends StatefulWidget {
  const personal({super.key});

  @override
  State<personal> createState() => _personalState();
}

class _personalState extends State<personal> {

  bool isEditMode = false;
  late TextEditingController firstnameController ;
  late TextEditingController lastnameController ;
  late TextEditingController mobilecontroller;
  late TextEditingController emailController ;
  late TextEditingController adharnocontroller;




late String email;
late String password;

  Future<Map<String,dynamic> >getapi() async{
    SharedPreferences sp=await SharedPreferences.getInstance();
    final apiUrl = 'http://ec2-54-91-24-12.compute-1.amazonaws.com/login';
  email = sp.getString('email')!;
 password=sp.getString('password')!;

  final response = await http.post(Uri.parse(apiUrl), headers:  <String, String>{
    'Content-Type': 'application/json; charset=UTF-8',
  },
  body: jsonEncode(<String, String>{
      "email": email!.toString()  ,
      "password" : password!.toString(),

    }
  ));
     if (response.statusCode == 200) {
    try {
      var data = jsonDecode(response.body);
      print(data); // Print the decoded JSON for debugging
      return data;
    } catch (e) {
      throw Exception('Failed to parse JSON: $e');
    }
  } else {
    throw Exception('Failed to load data: ${response.statusCode}');
  }
    
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
            
            // backgroundColor: Color.fromARGB(255, 241, 243, 247),
           title: Text("Personal details",style: TextStyle(color: Colors.white,fontFamily: "PT Sans"),),
            elevation: 0,
            actions: [
               IconButton( icon: Icon(isEditMode ? Icons.check : Icons.edit),
              onPressed: () {
                setState(() {
                  isEditMode = !isEditMode;
              }); 
              }
               )
              
            ],
          ),
      // backgroundColor: Color.fromARGB(255, 241, 243, 247) ,
      body: SingleChildScrollView(
        child: SafeArea(
          child: FutureBuilder<Map<String,dynamic>>(
                 future: getapi(),
                 builder: (context,snapshot){
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    
                    print("Error: ${snapshot.error}");
                    return Text("");
          
                  } 
                  if(snapshot.hasData){
                        firstnameController =TextEditingController(text: snapshot.data!['firstname']);
                         lastnameController= TextEditingController(text: snapshot.data!['lastname'] );
                           mobilecontroller= TextEditingController(text: snapshot.data!['mobile']);
                          emailController =TextEditingController(text: snapshot.data!['email']);
                          adharnocontroller =TextEditingController(text: snapshot.data!['adhar']);
            
                    return Padding(
                padding: const EdgeInsets.symmetric(vertical: 8,horizontal: 8),
                child: Column(children: [
                  SizedBox(height: 16,),
                  buildTextField('First Name', firstnameController),
                buildTextField('Last Name', lastnameController),
                buildTextField('Mobile', mobilecontroller),
                buildTextField('Email', emailController),
                buildTextField('Adhar No', adharnocontroller),
                
                  
                ]),
              
            );
                  }
                  else{
                    return Text("no data");
                  }
                  
                 })
                 ,
        ),
      ),
    );
  }



  Widget buildTextField(String labelText, TextEditingController controller) {
    if (isEditMode) {
      return Padding(
  padding: const EdgeInsets.all(20.0),
  child: Container(
    // height: 80,
    decoration: BoxDecoration(
      // color: Colors.white,
      borderRadius: BorderRadius.circular(16),
    ),
    child: Align(
      alignment: Alignment.centerLeft, // Center the TextFormField to the left
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          labelText: labelText,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
      ),
    ),
  ),
)

;
    } else {
      return ListTile(
        title: Text(labelText),
        subtitle: Text(controller.text,style: TextStyle(fontSize: 20),), // Display the current value
      );
    }
  }

}



