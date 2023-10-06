import 'dart:io';

import 'package:notes_cubic/Models/notes_Model.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class Appdatabase {
  static final NOTE_TABLE_NAME = 'noteTable';
  static final NOTE_TITLE_NAME = 'noteTitle';
  static final NOTE_DES_NAME = 'noteDes';
  static final NOTE_COLOM_ID= 'noteId';
  Database? database;
  Future<Database>getDB()async {
    if (database!=null){
      return  database!;
    }else{
      return await  insertDB();
    }
  }
  Future <Database>insertDB()async{
    Directory documentdirectory = await  getApplicationDocumentsDirectory();
    var dbpath = join(documentdirectory.path,'NoteDB');
    return openDatabase(
        dbpath,
        version:  1, onCreate: (db,version){
          db.execute(
              'Create table $NOTE_TABLE_NAME '
                  '($NOTE_COLOM_ID integer primary key autoincrement, $NOTE_TITLE_NAME text, $NOTE_DES_NAME text )');
    }
    );
  }
  Future<bool>addnote(NotesModel notemodel)async{
    var db  = await getDB();
   var roweffect = await  db.insert(NOTE_TABLE_NAME,notemodel.tomap());
  if (roweffect>0){
    return true;
  }else {
    return false;
  }
  }
 Future<List<NotesModel>> fetchdata()async{
    var db = await getDB();
    List<Map<String , dynamic>>notes = await db.query(NOTE_TABLE_NAME);
    List<NotesModel> noteslist= [];
    for (Map<String , dynamic>note in notes){
      noteslist.add(NotesModel.FromMap(note));
    }return noteslist;
  }
  Future<bool>update(NotesModel model)async{
    var db  = await getDB();
    var count  = await db.update(NOTE_TABLE_NAME, model.tomap(),where: "$NOTE_COLOM_ID = ${model.noteid}");
    return count>0;
  }
  Future<bool>delete(int index)async{
    var db = await  getDB();
    var   count  = await db.delete(NOTE_TABLE_NAME,where:"$NOTE_COLOM_ID= ?",whereArgs:[index.toString()]);
     return  count>0;


  }

}