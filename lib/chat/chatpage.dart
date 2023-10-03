

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:legal_ease/Model/message.dart';
import 'package:legal_ease/chat/chatservice.dart';

class chatscreen extends StatefulWidget {
  final String userid;

  final String username;
  const chatscreen(
      {super.key,
      required this.userid,
      
      required this.username});

  @override
  State<chatscreen> createState() => _chatscreenState();
}

class _chatscreenState extends State<chatscreen> {
  TextEditingController _messagecontroller = TextEditingController();
  final chatservice _chatservice = chatservice();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  void sendMessage() async {
    if (_messagecontroller.text.isNotEmpty) {
      await _chatservice.sendMessage(
          widget.userid, _messagecontroller.text.toString());
      _messagecontroller.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.username),
      ),
      body: Column(children: [
        Expanded(child: _buildchatlist()),
        _buildchatinput(),
      ]),
    );
  }

  Widget _buildchatinput() {
    return Row(
      children: [
        Expanded(
          child: TextFormField(
            controller: _messagecontroller,
            decoration: InputDecoration(
              hintText: "Message",
            ),
          ),
        ),
        IconButton(
            onPressed: () {
              sendMessage();
            },
            icon: Icon(Icons.send)),
      ],
    );
  }

  Widget _buildchatitem(DocumentSnapshot snapshot) {
    Map<String, dynamic> snap = snapshot.data() as Map<String, dynamic>;
    var alignment = (snap['senderId'] == _auth.currentUser!.uid)
        ? Alignment.centerLeft
        : Alignment.centerRight;

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.green,
        ),
        alignment: alignment,
        child: Row(children: [
          Text(snap['message'],style: TextStyle(color: Colors.white),),
          // Text(snap['timestamp'].toString())
        ]),
      ),
    );
  }

  Widget _buildchatlist() {
    return StreamBuilder(
        stream: _chatservice.getMessages(widget.userid, _auth.currentUser!.uid),
        builder: ((context, snapshot) {
          if(!snapshot.hasData){
            return const Text('Loading');
          }
          if(snapshot.hasError){
            return Text("${snapshot.error}");
          }
          return ListView(
            children: snapshot.data!.docs.map((document)=>_buildchatitem(document)).toList(),
          );
        }));
  }
}
