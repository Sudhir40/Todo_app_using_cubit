import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes_cubic/DB_helper/mydbhelper.dart';
import 'package:notes_cubic/Models/notes_Model.dart';
import 'package:notes_cubic/notes_cubic/note_cubic.dart';
import 'package:notes_cubic/screens/Home_page.dart';
import 'package:notes_cubic/screens/splashScreen.dart';
void main() {

  runApp( BlocProvider(create: (contex)=>note_cubic(db: Appdatabase()),child: MyApp(),));
}
class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      home: splash()
    );
  }
}
class home extends StatefulWidget{
     @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return homestate();
  }
}
class homestate extends State<home>{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
       appBar: AppBar(
         title: Text('note'),
       ),
      body:homepage(),

    );
  }
}



