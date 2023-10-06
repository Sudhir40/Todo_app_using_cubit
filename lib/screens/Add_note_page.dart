import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes_cubic/Models/notes_Model.dart';
import 'package:notes_cubic/notes_cubic/note_cubic.dart';
import 'package:notes_cubic/notes_cubic/note_state.dart';

class add_note_page extends StatelessWidget{

/*  String? title;
  int ?note_id;
  String? subtitle;
  add_note_page({{this.title, this.note_id, this.subtitle})*/
  var titlecontroller = TextEditingController();
  var desccontroller = TextEditingController();
   int ?id;
   add_note_page({this. id }){
   }
   int index=0;
  @override
  Widget build(BuildContext context) {
    print('build${id}');
    // TODO: implement build
    return Scaffold(
      appBar:  AppBar(
        title: Text('Add notes'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: BlocBuilder<note_cubic,note_state>(
          builder: (_,state){
            if (state is noteLoadingstate){
              return Center(
                child: CircularProgressIndicator(),
              );
            }else if (state is noteLoadedstate){
              if(id!=null){
                desccontroller.text = state.arrNotes[id!].notes;
                titlecontroller.text = state.arrNotes[id!].title;
                index = int.parse(state.arrNotes[id!].noteid.toString());
              }
              return   Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Add here your notes',style: TextStyle(fontSize: 25,color: Colors.orange),),
                  SizedBox(
                    height: 40,
                  ),
                  /// title controller
                  TextField(
                    controller:  titlecontroller,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  /// subtitle controller
                  TextField(controller: desccontroller ,),
                  SizedBox(
                    height: 20,
                  ),
                ],
              );
            }return Container();
          },

        ),
      ),

      /// submit buttton
      floatingActionButton: FloatingActionButton.extended(
        label: Text('Save',style: TextStyle(
            color: Colors.green
        ),),
        icon: Icon(Icons.save,color: Colors.green,),
        backgroundColor: Color(0xFFECEFF5),
        onPressed: (){
          String  title= titlecontroller.text.toString();
          String notes=desccontroller.text.toString();
          if (id==null){  context.read<note_cubic>().addnote(NotesModel(
            title: title,
            notes: notes,

          ));}else{

            context.read<note_cubic>().update(NotesModel(title: title, notes: notes, noteid:index ));
          }

          Navigator.pop(context);
        },),
    );
  }
}