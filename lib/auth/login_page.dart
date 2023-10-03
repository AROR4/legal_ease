import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:legal_ease/resources/auth_methods.dart';
import 'package:legal_ease/splashscreen.dart';
import 'package:legal_ease/auth/signup_page.dart';
import 'package:legal_ease/components/roundbutton.dart';


class login_screen extends StatefulWidget {
  const login_screen({super.key});

  @override
  State<login_screen> createState() => _login_screenState();
}

class _login_screenState extends State<login_screen> {
  FirebaseAuth _auth= FirebaseAuth.instance;
  bool text = true;
  Color c = Colors.black;
  bool loading = false;
  final _FormKey = GlobalKey<FormState>();
  final TextEditingController emailcontroller = TextEditingController();
  final TextEditingController passwordcontroller = TextEditingController();

  Future<void> login() async {
    if (_FormKey.currentState!.validate()) {
      setState(() {
        loading = true;
      });
      
      
      String res = await Authmethods().loginUser(
          email: emailcontroller.text.toString(),
          password: passwordcontroller.text.toString());
      if (res == "success") {
        setState(() {
          loading=false;
        });
       
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => splashscreen()));
      } else {
        setState(() {
          loading = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(res)));
      }
    }
  }
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
          SystemNavigator.pop();
          return true;
        },
        child: Scaffold(
            backgroundColor: Colors.black,
            body: SafeArea(
                child: SingleChildScrollView(
                    child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 100,
                ),
                Image(
                  image: AssetImage('images/justice.png'),
                  height: 200,
                  width: 300,
                ),
                // Text("Welcome!!",style: TextStyle(fontSize: 45,color: Colors.white),),
                // SizedBox(height: 0,),
                Form(
                  key: _FormKey,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 30),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // SizedBox(height: 50,),

                          TextFormField(
                            keyboardType: TextInputType.emailAddress,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Enter E-mail";
                              }
                              if (!(value.contains("@") &&
                                  (value.contains(".com") ||
                                      value.contains(".in") ||
                                      value.contains(".org") ||
                                      value.contains(".co.in")))) {
                                return "Enter Valid E-mail id";
                              }
                              return null;
                            },
                            controller: emailcontroller,
                            decoration: InputDecoration(
                              hintText: "Email",
                              prefixIcon: Icon(Icons.email_outlined),
                              fillColor: Colors.grey.withOpacity(0.1),
                              filled: true,

                              // focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: c),borderRadius: BorderRadius.circular(12)),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12)),
                            ),
                            onTap: () {
                              setState(() {
                                c = Color.fromARGB(237, 255, 136, 0);
                              });
                            },
                          ),
                          SizedBox(
                            height: 25,
                          ),
                          TextFormField(
                            controller: passwordcontroller,
                            obscureText: text,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Enter Password";
                              }

                              return null;
                            },
                            decoration: InputDecoration(
                              hintText: "Password",
                              prefixIcon: Icon(Icons.lock),
                              suffixIcon: text
                                  ? IconButton(
                                      onPressed: () {
                                        setState(() {
                                          text = false;
                                        });
                                      },
                                      icon: Icon(Icons.visibility))
                                  : IconButton(
                                      onPressed: () {
                                        setState(() {
                                          text = true;
                                        });
                                      },
                                      icon: Icon(Icons.visibility_off)),
                              fillColor: Colors.grey.withOpacity(0.1),
                              filled: true,
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12)),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            "Forget password?",
                            textAlign: TextAlign.left,
                          ),
                          SizedBox(
                            height: 50,
                          ),
                          Roundbutton(
                              Title: "Login", loading: loading, onTap: login),
                          SizedBox(
                            height: 20,
                          ),
                          Center(
                              child: Text(
                            "OR",
                            style: TextStyle(fontSize: 18),
                          )),
                          SizedBox(
                            height: 20,
                          ),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                "Don't have an account? ",
                                style: TextStyle(fontSize: 16),
                              ),
                              InkWell(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                signup_screen()));
                                  },
                                  child: Text(
                                    "Sign Up",
                                    style: TextStyle(
                                        color: Color.fromARGB(237, 255, 136, 0),
                                        decoration: TextDecoration.underline,
                                        fontSize: 16),
                                  ))
                            ],
                          ),
                        ]),
                  ),
                ),
              ]),
        )))));
  }
}
