import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:legal_ease/Model/message.dart';
import 'package:velocity_x/velocity_x.dart';

class chatservice extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> sendMessage(String receiverId, String message) async {
    final String currentuser = _auth.currentUser!.uid;
    final String currentUserEmail = _auth.currentUser!.email.toString();
    final Timestamp timestamp = Timestamp.now();

    Message newmessage = Message(
        senderId: currentuser,
        message: message,
        receiverId: receiverId,
        senderEmail: currentUserEmail,
        timestamp: timestamp);

    List<String> ids = [currentuser, receiverId];
    ids.sort();
    String chatRoomId = ids.join("_");

    await _firestore
        .collection('chat_rooms')
        .doc(chatRoomId)
        .collection('message')
        .add(newmessage.toMap());
  }

  Stream<QuerySnapshot> getMessages(String userId, String otheruserid) {
    List<String> ids = [userId, otheruserid];
    ids.sort();
    String chatRoomId = ids.join("_");

    return _firestore
        .collection('chat_rooms')
        .doc(chatRoomId)
        .collection('message')
        .orderBy('timestamp')
        .snapshots();
  }
}
