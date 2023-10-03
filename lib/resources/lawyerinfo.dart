import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:legal_ease/Model/users.dart';
import 'package:legal_ease/resources/storage_methods.dart';

class addinfolawyer {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<String> addinfo({
    required String firstname,
    required String lastname,
    required String email,
    required String mobile,
    required String aadhar,
    required String role,
    required String idnumber,
    required String specialisation,
    required String totalCases,
    required String wonCases,
    required String pendingCases,
    required List services,
    required Uint8List profile,
  }) async {
    String res = "Some error Occured";

    try {
      String photourl = await Storagemethods()
          .uploadImagetoStorage("profilepics", profile, false);
      Advocate adv = Advocate(
          uid: _auth.currentUser!.uid.toString(),
          firstname: firstname,
          lastname: lastname,
          email: email,
          mobile: mobile,
          aadhar: aadhar,
          role: role,
          id: idnumber,
          specialisation: specialisation,
          totalCases: totalCases,
          wonCases: wonCases,
          pendingCases: pendingCases,
          services: services,
          photourl: photourl,
          connect: [],
          followers: [],
          rating: []);

      _firestore
          .collection('users')
          .doc(_auth.currentUser!.uid)
          .set(adv.toJson(), SetOptions(merge: true));
      res = "success";
    } catch (err) {
      res = err.toString();
    }
    return res;
  }
}
