import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:http/retry.dart';

class Clientuser {
  final String uid;
  final String firstname;
  final String lastname;
  final String email;
  final String mobile;
  final String aadhar;
  final String role;
  final List following;
  final List connect;

  const Clientuser(
      {required this.uid,
      required this.firstname,
      required this.lastname,
      required this.email,
      required this.mobile,
      required this.aadhar,
      required this.role,
      required this.following,
      required this.connect});

  Map<String, dynamic> toJson() => {
        "uid": uid,
        "firstname": firstname,
        "lastname": lastname,
        "email": email,
        "mobile": mobile,
        "aadhar": aadhar,
        "role": role,
        "following": following,
        "connect": connect
      };

  static Clientuser fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
    return Clientuser(
        uid: snapshot['uid'],
        firstname: snapshot['firstname'],
        lastname: snapshot['lastname'],
        email: snapshot['email'],
        mobile: snapshot['mobile'],
        aadhar: snapshot['aadhar'],
        role: snapshot['role'],
        following: snapshot['following'],
        connect: snapshot['connect']);
  }
}

class Advocate {
  final String uid;
  final String firstname;
  final String lastname;
  final String email;
  final String mobile;
  final String aadhar;
  final String role;
  final String id;
  final List followers;
  final List connect;
  final String specialisation;
  final String totalCases;
  final String wonCases;
  final String pendingCases;
  final List services;
  final String photourl;
  final List rating;

  const Advocate({
    required this.uid,
    required this.firstname,
    required this.lastname,
    required this.email,
    required this.mobile,
    required this.aadhar,
    required this.role,
    required this.id,
    required this.connect,
    required this.followers,
    required this.specialisation,
    required this.totalCases,
    required this.wonCases,
    required this.pendingCases,
    required this.services,
    required this.photourl,
    required this.rating,
  });

  Map<String, dynamic> toJson() => {
        "uid": uid,       
        "firstname": firstname,
        "lastname": lastname,
        "email": email,
        "mobile": mobile,
        "aadhar": aadhar,
        "role": role,
        "id": id,
        "following": followers,
        "connect": connect,
        "specialisation": specialisation,
        "totalCases": totalCases,
        "wonCases": wonCases,
        "pendingCases": pendingCases,
        "services": services,
        "photourl": photourl,
        "rating" : rating,
      };



      static Advocate fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
    return Advocate(
        uid: snapshot['uid'],
        firstname: snapshot['firstname'],
        lastname: snapshot['lastname'],
        email: snapshot['email'],
        id: snapshot['id'],
        mobile: snapshot['mobile'],
        aadhar: snapshot['aadhar'],
        role: snapshot['role'],
        followers: snapshot['followers'],
        connect: snapshot['connect'],
        specialisation: snapshot['specialisation'],
        totalCases: snapshot['totalCases'],
        wonCases: snapshot['wonCases'],
        pendingCases: snapshot['pendingCases'],
        services: snapshot['services'],
        photourl: snapshot['photourl'],
        rating:  snapshot['rating'],
        );
  }
}
