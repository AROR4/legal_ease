import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class firestore_methods{
final FirebaseFirestore _firestore=FirebaseFirestore.instance;
Future<void> followuser(
  String uid,
  String tofollowid
) async{
  try{
    final snap=await _firestore.collection('users').doc(tofollowid).get();
    List followers= (snap.data!() as dynamic)['followers'];
   if(followers.contains(uid)){
    await _firestore.collection('users').doc(tofollowid).update(
     {
      'followers' : FieldValue.arrayRemove([uid]),
     }
    );
     await _firestore.collection('users').doc(uid).update(
     {
      'following' : FieldValue.arrayRemove([tofollowid]),
     }
    );
    
   }
   else{
    await _firestore.collection('users').doc(tofollowid).update(
     {
      'followers' : FieldValue.arrayUnion([uid]),
     }
    );

     await _firestore.collection('users').doc(uid).update(
     {
      'following' : FieldValue.arrayUnion([tofollowid]),
     }
    );
   }
  }
  catch(e){
   print(e.toString());
  }
}

Future<void> connectuser(
  String uid,
  String toconnectid
) async{
  try{
    final snap=await _firestore.collection('users').doc(toconnectid).get();
    List followers= (snap.data!() as dynamic)['connect'];
   if(!followers.contains(uid)){
    await _firestore.collection('users').doc(toconnectid).update(
     {
      'connect' : FieldValue.arrayUnion([uid]),
     }
    );
     await _firestore.collection('users').doc(uid).update(
     {
      'connect' : FieldValue.arrayRemove([toconnectid]),
     }
    );
    
   }
   else{
    
   }
  }
  catch(e){
   print(e.toString());
  }
}


}