import 'package:flutter/material.dart';
import 'package:legal_ease/Model/users.dart';
import 'package:legal_ease/resources/auth_methods.dart';

class UserProvider with  ChangeNotifier {
  String? _role;
  Map<String,double>? _ratings;
  final Authmethods _authmethods=Authmethods();
  Clientuser? _clientuser;
  Clientuser get getClientUser => _clientuser!;

  Advocate? _advocate;
  Advocate get getAdvocate=> _advocate!;
  Map<String,double> get getratings =>_ratings!;
  String get getrole=> _role!;
   


  Future<void> refreshUser()async{
   String role=await _authmethods.getrole();
  _role=role;

   
   if(_role!="Client"){
    Advocate advocate=await _authmethods.getUserDetails();
    _advocate=advocate;
   }
   else{
    Clientuser clientuser=await _authmethods.getUserDetails();
    _clientuser=clientuser;
    Map<String,double> ratings=await _authmethods.getrating();
    _ratings=ratings;
   }
  
   notifyListeners();
   
  }

}