import 'package:flutter/material.dart';
import 'package:legal_ease/auth/login_page.dart';
import 'package:legal_ease/components/roundbutton.dart';
import 'package:legal_ease/resources/auth_methods.dart';
import 'package:legal_ease/splashscreen.dart';


class client extends StatefulWidget {
  final String firstname;
  final String lastname;
  final String role;

  const client(
      {super.key,
      required this.firstname,
      required this.lastname,
      required this.role});

  @override
  State<client> createState() => _clientState();
}

class _clientState extends State<client> {
  bool loading = false;
  final _FormKey = GlobalKey<FormState>();

  final TextEditingController mobilecontroller = TextEditingController();
  final TextEditingController adharnocontroller = TextEditingController();
  final TextEditingController emailcontroller = TextEditingController();
  final TextEditingController passwordcontroller = TextEditingController();

  Future<void> signup() async {
    
    if (_FormKey.currentState!.validate()) {
      setState(() {
      loading = true;
    });
      String res = await Authmethods().signUpUserclient(
          firstname: widget.firstname,
          lastname: widget.lastname,
          email: emailcontroller.text.toString(),
          password: passwordcontroller.text.toString(),
          mobile: mobilecontroller.text.toString(),
          aadhar: adharnocontroller.text.toString(),
          role: widget.role);
      if (res == "success") {
        setState(() {
          loading = false;
        });
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => splashscreen()));
      } else {
        setState(() {
          loading = false;
        });
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(res)));
      }
    }
  }

  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                    height: MediaQuery.of(context).size.height * 0.01,
                  ),
                  Image(
                    image: AssetImage('images/justice.png'),
                    height: 200,
                    width: 300,
                  ),
                  Form(
                    key: _FormKey,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10),
                      child: Column(children: [
                        SizedBox(
                          height: 30,
                        ),
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
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12)),
                          ),
                        ),
                        SizedBox(
                          height: 25,
                        ),
                        TextFormField(
                          controller: passwordcontroller,
                          obscureText: true,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Enter Password";
                            }

                            return null;
                          },
                          decoration: InputDecoration(
                            hintText: "Password",
                            prefixIcon: Icon(Icons.lock),
                            fillColor: Colors.grey.withOpacity(0.1),
                            filled: true,
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12)),
                          ),
                        ),
                        SizedBox(
                          height: 25,
                        ),
                        TextFormField(
                          keyboardType: TextInputType.emailAddress,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Enter Mobile Number";
                            }

                            return null;
                          },
                          controller: mobilecontroller,
                          decoration: InputDecoration(
                            hintText: "Enter your mobile number",
                            prefixIcon: Icon(Icons.phone),
                            fillColor: Colors.grey.withOpacity(0.1),
                            filled: true,
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12)),
                          ),
                        ),
                        SizedBox(
                          height: 25,
                        ),
                        TextFormField(
                          controller: adharnocontroller,
                          
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Enter Adhar No";
                            }
                            if (value.length != 12) {
                              return "Enter Valid Adhar No";
                            }

                            return null;
                          },
                          decoration: InputDecoration(
                            hintText: "Enter your Adhar No",
                            prefixIcon: Icon(Icons.perm_identity_sharp),
                            fillColor: Colors.grey.withOpacity(0.1),
                            filled: true,
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12)),
                          ),
                        ),

                        SizedBox(
                          height: 50,
                        ),
                        Roundbutton(
                            Title: "Signup", loading: loading, onTap: signup),

                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          "OR",
                          style: TextStyle(fontSize: 18),
                        ),
                        // SizedBox(height: 20,),

                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              "Already have an account? ",
                              style: TextStyle(fontSize: 16),
                            ),
                            InkWell(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              login_screen()));
                                },
                                child: Text(
                                  "Log in",
                                  style: TextStyle(
                                      color: Color.fromARGB(237, 255, 136, 0),
                                      decoration: TextDecoration.underline,
                                      fontSize: 16),
                                ))
                          ],
                        ),
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
