import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:notes_cubic/DB_helper/mydbhelper.dart';
import '../Models/notes_Model.dart';
import 'Home_page.dart';

class splash extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return splashscreen();
  }
}
class splashscreen extends State<splash>{
  List<NotesModel> notes = [];
  @override
  void initState() {
    // TODO: implement initState

    super.initState();
    Timer(Duration(seconds: 3),(){
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context)=>homepage()));
    });

  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
     body: Center(
      child: Container(
          height:200,
          width: 200,
          child:Image.asset('Assets/images/post-it.png')
      ),
    ),
    );
  }
}