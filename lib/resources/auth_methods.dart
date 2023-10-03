import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:legal_ease/Model/users.dart';

class Authmethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;


  Future<String> getrole() async {
    User currentUser =_auth.currentUser!;
    DocumentSnapshot snap=await _firestore.collection('users').doc(currentUser.uid).get();
  
    return (snap.data() as Map<String,dynamic>)['role'];
  }

  Future<dynamic> getUserDetails() async {
    String role =await getrole();
     User currentUser =_auth.currentUser!;
    DocumentSnapshot snap=await _firestore.collection('users').doc(currentUser.uid).get();
    if(role!="Client"){
      return Advocate.fromSnap(snap);
    }
    else {
      return Clientuser.fromSnap(snap);
    }
    // return Clientuser.fromSnap(snap);
  }


Future<Map<String,double>> getrating() async{
    final FirebaseFirestore _firestore= FirebaseFirestore.instance;
    final snapshot= await _firestore.collection('users').where('role',isEqualTo: "Advocate").get();
    final snap= snapshot.docs ;
    Map<String,double> advocateratings={};
    for(var doc in snap){
      double rating=0;
     final myarray=doc['rating'];
     for(var item in myarray){
       rating+=item;
     }
     advocateratings[doc['uid']]=rating/myarray.length;
     
    }

  return advocateratings;
  }
  Future<String> signUpUserclient({
    required String firstname,
    required String lastname,
    required String email,
    required String password,
    required String mobile,
    required String aadhar,
    required String role,
  }) async {
    String res = "Some error Occured";

    try {
      UserCredential cred = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      Clientuser clientuser = Clientuser(
          uid: _auth.currentUser!.uid.toString(),
          firstname: firstname,
          lastname: lastname,
          email: email,
          mobile: mobile,
          aadhar: aadhar,
          role: role,
          following: [],
          connect: []);
      _firestore.collection('users').doc(cred.user!.uid).set(
            clientuser.toJson(),
          );
      res = "success";
    } catch (err) {
      res = err.toString();
    }
    return res;
  }

  Future<String> signUpUseradv({
    required String email,
    required String password,
  }) async {
    String res = "Some error Occured";

    try {
      await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      res = "success";
    } catch (err) {
      res = err.toString();
    }
    return res;
  }

  Future<String> loginUser({
    required String email,
    required String password,
  }) async {
    String res = "Some error occured ";

    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      res = "success";
    } catch (err) {
      res = err.toString();
    }
    return res;
  }
}
