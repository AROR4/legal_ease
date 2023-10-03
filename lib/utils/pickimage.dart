
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

pickImage(ImageSource source,BuildContext context) async{
  final ImagePicker _imagePicker =ImagePicker() ;

  XFile? _file = await _imagePicker.pickImage(source: source);

  if(_file!=null){
      return await _file.readAsBytes();
  }
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Image not selected")));
}