
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes_cubic/Models/notes_Model.dart';
import 'package:notes_cubic/notes_cubic/note_state.dart';
import '../DB_helper/mydbhelper.dart';


class note_cubic extends Cubit<note_state>{
   Appdatabase db ;
   note_cubic({required this.db}):super(noteInitialstate());

    void addnote(NotesModel notemodel)async{
       emit(noteLoadingstate());
       bool check = await db.addnote(notemodel);
       if (check){
         var notes = await db.fetchdata();
         emit(noteLoadedstate(arrNotes: notes));
       }else{
         emit(noteErrorstate(error_msg: 'Note not added'));
       }
    }
    void getnotes()async{
      emit(noteLoadingstate());
      var notes = await db.fetchdata();
      emit(noteLoadedstate(arrNotes: notes));
    }
    void update(NotesModel model)async{
      emit(noteLoadingstate());
      var notes = await db.update(model);
      if(notes){
        var notes = await db.fetchdata();
        emit(noteLoadedstate(arrNotes: notes));
      }else{
        emit(noteLoadingstate());
      }
    }
    void delete(int index)async{
      emit(noteLoadingstate());
       var deleteted =   await db.delete(index);
       if(deleteted){
         var notes =await  db.fetchdata();
         emit(noteLoadedstate(arrNotes: notes));
       }else{
        // emit(noteErrorstate(error_msg: 'Note not deleted'));
       }

    }
}