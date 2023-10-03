import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:legal_ease/auth/login_page.dart';
import 'package:legal_ease/components/roundbutton.dart';
import 'package:legal_ease/resources/lawyerinfo.dart';
import 'package:legal_ease/utils/pickimage.dart';

class start_adv extends StatefulWidget {
  final String firstname;
  final String lastname;
  final String email;
  final String mobile;
  final String aadhar;
  final String role;
  final String idnumber;

  const start_adv({super.key,
    required this.firstname,
    required this.lastname,
    required this.email,
    required this.mobile,
    required this.aadhar,
    required this.role,
    required this.idnumber,
  });

  @override
  State<start_adv> createState() => _start_advState();
}

class _start_advState extends State<start_adv> {
  bool loading = false;
  final _FormKey = GlobalKey<FormState>();
  TextEditingController specialisation = TextEditingController();
  TextEditingController total = TextEditingController();
  TextEditingController won = TextEditingController();
  TextEditingController pending = TextEditingController();
  Uint8List? _image;

  void selectedImage() async {
    Uint8List im = await pickImage(ImageSource.gallery, context);
    setState(() {
      _image = im;
    });
  }

  Future<List<String>> showADialog(List<String> items) async {
    final selectedItems = <String>[];
    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                "Add Your Services",
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                width: 500,
                height: 250,
                child: StatefulBuilder(
                  builder: (context, setState) {
                    return ListView.builder(
                      itemCount: items.length,
                      itemBuilder: (context, index) {
                        final item = items[index];

                        return CheckboxListTile(
                          title: Text(
                            item,
                          ),
                          value: selectedItems.contains(item),
                          onChanged: (value) {
                            if (value == null) return;
                            setState(() {
                              if (value) {
                                selectedItems.add(item);
                              } else {
                                selectedItems.remove(item);
                              }
                            });
                          },
                        );
                      },
                    );
                  },
                ),
              ),
              Roundbutton(
                Title: "Add",
                onTap: () {
                  Navigator.of(context).pop(
                      selectedItems); // Return selected items when Continue is tapped
                },
              ),
            ],
          ),
        );
      },
    );

    return selectedItems; // Return selected items when the dialog is closed
  }


  Future<void> addinfo() async{
    setState(() {
    loading = true;
  });
  List<String> services = await showADialog([
    "Notary",
    "Legal Advice",
    "Bail",
    "Document Write",
    "Case Filing"
  ]);
  if (_image != null) {
    addinfolawyer().addinfo(
        firstname: widget.firstname,
        lastname: widget.lastname,
        email: widget.email,
        mobile: widget.mobile,
        aadhar: widget.aadhar,
        role: widget.role, 
        idnumber: widget.idnumber,
        specialisation: specialisation.text.toString(),
        totalCases: total.text.toString(),
        wonCases: won.text.toString(),
        pendingCases: pending.text.toString(),
        services: services,
        profile: _image!
        );
      setState(() {
        loading=false;
        Navigator.push(context, MaterialPageRoute(builder: (context)=>login_screen()));
      });   
  } else {
    setState(() {
      loading=false;
    });
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Add Profile Image")));
  }
  }






  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Container(
          child: Padding(
            padding: const EdgeInsets.all(23.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 10,
                ),
                Text(
                  "Get Started!!",
                  style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 15,
                ),
                Stack(children: [
                  _image != null
                      ? CircleAvatar(
                          radius: 60, backgroundImage: MemoryImage(_image!))
                      : CircleAvatar(
                          radius: 60,
                          backgroundColor: Colors.white,
                          child: Image(
                            image: AssetImage('images/account.png'),
                            fit: BoxFit.fill,
                          ),
                        ),
                  Positioned(
                      bottom: -10,
                      left: 70,
                      child: IconButton(
                        icon: Icon(Icons.add_a_photo),
                        onPressed: selectedImage,
                      ))
                ]),
      
                SizedBox(
                  height: 25,
                ),
      
                Form(
                    key: _FormKey,
                    child: Column(children: [
                      TextFormField(
                        controller: specialisation,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Enter Your Specialisation";
                          }
      
                          return null;
                        },
                        decoration: InputDecoration(
                          hintText: "Tell Your Specialisation",
                          // prefixIcon: Icon(Icons.info),
                          fillColor: Colors.grey.withOpacity(0.1),
                          filled: true,
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12)),
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      TextFormField(
                        controller: total,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Enter Your Total Cases";
                          }
      
                          return null;
                        },
                        decoration: InputDecoration(
                          hintText: "Tell Your Total Cases..",
                          // prefixIcon: Icon(Icons.),
                          fillColor: Colors.grey.withOpacity(0.1),
                          filled: true,
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12)),
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      TextFormField(
                        controller: won,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Enter cases you won";
                          }
      
                          return null;
                        },
                        decoration: InputDecoration(
                          hintText: "Tell Your Number Of Won Cases",
                          // prefixIcon: Icon(Icons.info),
                          fillColor: Colors.grey.withOpacity(0.1),
                          filled: true,
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12)),
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      TextFormField(
                        controller: pending,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Enter Your Pending Cases";
                          }
      
                          return null;
                        },
                        decoration: InputDecoration(
                          hintText: "Tell Your Number Of Pending Cases..",
                          // prefixIcon: Icon(Icons.info),
                          fillColor: Colors.grey.withOpacity(0.1),
                          filled: true,
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12)),
                        ),
                      ),
                      SizedBox(
                        height: 25,
                      ),
                      Roundbutton(
                        Title: "Continue",
                        loading: loading,
                        onTap: () async {
                          if (_FormKey.currentState!.validate()) {
                            addinfo();
                          }
                          // Navigator.push(context,
                          //     MaterialPageRoute(builder: (context) => allchats()));
                        },
                      ),
                    ])),
      
                
              ],
            ),
          ),
        ),
      ),
    );
  }
}
