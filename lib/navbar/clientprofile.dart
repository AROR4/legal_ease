import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:legal_ease/Model/users.dart';
import 'package:legal_ease/auth/login_page.dart';
import 'package:legal_ease/providers/user_provider.dart';
import 'package:legal_ease/view/help.dart';
import 'package:legal_ease/view/personaldetails.dart';
import 'package:legal_ease/view/settings.dart';
import 'package:provider/provider.dart';


class clientprofile extends StatefulWidget {
  const clientprofile({super.key});




  @override
  State<clientprofile> createState() => _clientprofileState();
}

class _clientprofileState extends State<clientprofile> {

late String email;
late String password;

Future<void> logout() async {
  final FirebaseAuth _auth=FirebaseAuth.instance;
  _auth.signOut();
}


void logoutdialog(){
    showCupertinoDialog(context: context, 
    builder: (BuildContext context) {
      return Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
        ),
        child: AlertDialog(
          title: const Text('Confirm Logout'),
            content: const Text('Are you sure you want to logout!'),
            actions: [
              TextButton(
                onPressed: () {
                  
                   Navigator.of(context).pop();  
                },
                child: Center(child: const Text('Cancel ')),
              ),
              TextButton(
                onPressed: () {
                  logout();
                 
                  Navigator.push(context, MaterialPageRoute(builder: (context)=> login_screen()));
                },
                child: Container(
                  height: 35,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Color.fromARGB(255, 52, 103, 255),

                  ),
                  
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(child: const Text('Log out',style: TextStyle(color: Colors.white),)),
                  )),
              ),
            ],
        ),
      );
    });
    
  }



  @override
  Widget build(BuildContext context) {
    Clientuser clientuser= Provider.of<UserProvider>(context).getClientUser;
    return Scaffold(
      appBar: AppBar(),
        body: SingleChildScrollView(
          child: SafeArea(child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8,horizontal: 12),
            child:Column(
              children: [
                SizedBox(height: 30,),
                 Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Container(
                    
                    decoration: BoxDecoration(
                      // color: Colors.white,
                      borderRadius: BorderRadius.circular(20)
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(children: [
                        Center(
                      
                      child: CircleAvatar(
                        radius: 50,
                        // backgroundColor: Color.fromARGB(255, 52, 103, 255),
                        child: Text(clientuser.firstname[0].toUpperCase(),style: TextStyle(fontSize: 50,color: Colors.white),),
                      ),
                                    
                      
                      ),
                      SizedBox(height: 20,),
                      Text("${clientuser.firstname} ${clientuser.lastname}",style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold),),
                      SizedBox(height: 10,),
                      Text(clientuser.email,style: TextStyle(color: Colors.white),),
                      ]),
                    ),
                  ),
                )
                ,
        
                SizedBox(height: 20,),
                InkWell(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: ((context) => personal())));
                  },
                  child: ListTile(
                    leading: Icon(Icons.people),
                    title: Text("Personal details"),
                    // subtitle: Text(item['subtitle']),
                    trailing: Icon(Icons.arrow_right),
                  ),
                ),
                // SizedBox(height: 20,),
                ListTile(
                  leading: Icon(Icons.history),
                  title: Text("Service history"),
                  // subtitle: Text(item['subtitle']),
                  trailing: Icon(Icons.arrow_right),
                ),
                // SizedBox(height: 20,),
                InkWell(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: ((context) => HelpPage())));
                  },
                  child: ListTile(
                    leading: Icon(Icons.info),
                    title: Text("Help & Support"),
                    // subtitle: Text(item['subtitle']),
                    trailing: Icon(Icons.arrow_right),
                  ),
                ),
                // SizedBox(height: 20,),
                InkWell(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: ((context) => Settings(name: "${clientuser.firstname} ${clientuser.lastname}", isDarkMode: false, selectedLanguage: "English", enableFingerprint: false))));
                  },
                  child: ListTile(
                    leading: Icon(Icons.settings),
                    title: Text("Settings"),
                    // subtitle: Text(item['subtitle']),
                    trailing: Icon(Icons.arrow_right),
                  ),
                ),
                // SizedBox(height: 20,),
                InkWell(
                  onTap: (){
                    logoutdialog();
                  },
                  child: ListTile(
                    leading: Icon(Icons.logout),
                    title: Text("Log Out"),
                    // subtitle: Text(item['subtitle']),
                    trailing: Icon(Icons.arrow_right),
                  ),
                ),
















                // Padding(
                //   padding: const EdgeInsets.all(12.0),
                //   child: Container(
                    
                //     decoration: BoxDecoration(
                //       // color: Colors.white,
                //       borderRadius: BorderRadius.circular(20)
                //     ),
                //     child: Padding(
                //       padding: const EdgeInsets.all(12.0),
                //       child: Column(children: [
                //         Center(
                      
                //       child: CircleAvatar(
                //         radius: 50,
                //         // backgroundColor: Color.fromARGB(255, 52, 103, 255),
                //         child: Text(snapshot.data!['firstname'].toString()[0].toUpperCase(),style: TextStyle(fontSize: 50,color: Colors.white),),
                //       ),
                                    
                      
                //       ),
                //       SizedBox(height: 20,),
                //       Text("${snapshot.data!['firstname']} ${snapshot.data!['lastname']}",style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold),),
                //       SizedBox(height: 10,),
                //                       // Text(snapshot.data!['email'],style: TextStyle(color: Colors.black),),
                //       ]),
                //     ),
                //   ),
                // )
                // ,
        
                // SizedBox(height: 20,),
                // Padding(
                //   padding: const EdgeInsets.symmetric(horizontal:8.0,vertical: 2),
                //   child: Card(
                //         shape: RoundedRectangleBorder(
                //           borderRadius: BorderRadius.circular(20.0),
                //         ),
                        
                //         child: Padding(
                //           padding: const EdgeInsets.all(3.0),
                //           child: InkWell(
                //             onTap: (){
                //               Navigator.push(context, MaterialPageRoute(builder: ((context) => personal())));
                //             },
                //             child: ListTile(
                //               leading: Icon(Icons.people),
                //               title: Text("Personal details"),
                //               // subtitle: Text(item['subtitle']),
                //               trailing: Icon(Icons.arrow_right),
                //             ),
                //           ),
                //         ),
                //       ),
                // ),
                // // SizedBox(height: 20,),
                // Padding(
                //   padding: const EdgeInsets.symmetric(horizontal:8.0,vertical: 2),
                //   child: Card(
                //         shape: RoundedRectangleBorder(
                //           borderRadius: BorderRadius.circular(20.0),
                //         ),
                        
                //         child: Padding(
                //           padding: const EdgeInsets.all(3.0),
                //           child: ListTile(
                //             leading: Icon(Icons.history),
                //             title: Text("Service history"),
                //             // subtitle: Text(item['subtitle']),
                //             trailing: Icon(Icons.arrow_right),
                //           ),
                //         ),
                //       ),
                // ),
                // // SizedBox(height: 20,),
                // Padding(
                //   padding: const EdgeInsets.symmetric(horizontal:8.0,vertical: 2),
                //   child: Card(
                //         shape: RoundedRectangleBorder(
                //           borderRadius: BorderRadius.circular(20.0),
                //         ),
                        
                        
                //         child: Padding(
                //           padding: const EdgeInsets.all(3.0),
                //           child: InkWell(
                //             onTap: (){
                //               Navigator.push(context, MaterialPageRoute(builder: ((context) => HelpPage())));
                //             },
                //             child: ListTile(
                //               leading: Icon(Icons.info),
                //               title: Text("Help & Support"),
                //               // subtitle: Text(item['subtitle']),
                //               trailing: Icon(Icons.arrow_right),
                //             ),
                //           ),
                //         ),
                //       ),
                // ),
                // // SizedBox(height: 20,),
                // Padding(
                //   padding: const EdgeInsets.symmetric(horizontal:8.0,vertical: 2),
                //   child: Card(
                //         shape: RoundedRectangleBorder(
                //           borderRadius: BorderRadius.circular(20.0),
                //         ),
                        
                //         child: Padding(
                //           padding: const EdgeInsets.all(3.0),
                //           child: InkWell(
                //             onTap: (){
                //               Navigator.push(context, MaterialPageRoute(builder: ((context) => Settings(name: "${snapshot.data!['firstname']} ${snapshot.data!['lastname']}", isDarkMode: false, selectedLanguage: "English", enableFingerprint: false))));
                //             },
                //             child: ListTile(
                //               leading: Icon(Icons.settings),
                //               title: Text("Settings"),
                //               // subtitle: Text(item['subtitle']),
                //               trailing: Icon(Icons.arrow_right),
                //             ),
                //           ),
                //         ),
                //       ),
                // ),
                // // SizedBox(height: 20,),
                // Padding(
                //   padding: const EdgeInsets.symmetric(horizontal:8.0,vertical: 2),
                //   child: Card(
                //         shape: RoundedRectangleBorder(
                //           borderRadius: BorderRadius.circular(20.0),
                //         ),
                        
                //         child: Padding(
                //           padding: const EdgeInsets.all(3.0),
                //           child: InkWell(
                //             onTap: (){
                //               logoutdialog();
                //             },
                //             child: ListTile(
                //               leading: Icon(Icons.logout),
                //               title: Text("Log Out"),
                //               // subtitle: Text(item['subtitle']),
                //               trailing: Icon(Icons.arrow_right),
                //             ),
                //           ),
                //         ),
                //       ),
                // ),
              ],
        
              
        
            ),
          )),
        ),
      );
  }
}