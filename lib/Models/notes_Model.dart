import 'package:notes_cubic/DB_helper/mydbhelper.dart';

class NotesModel{
  String title;
  String notes;
  int? noteid;
  NotesModel({required this.title,required this.notes, this.noteid});
  factory NotesModel.FromMap(Map<String,dynamic>map){
    return NotesModel(
        title:map[Appdatabase.NOTE_TITLE_NAME] ,
        notes:map[Appdatabase.NOTE_DES_NAME],
        noteid: map[Appdatabase.NOTE_COLOM_ID]
    );
  }
  Map<String,dynamic>tomap( ){
    return {
         Appdatabase.NOTE_TITLE_NAME:title,
        Appdatabase.NOTE_DES_NAME:notes,
      Appdatabase.NOTE_COLOM_ID:noteid,
  };
}
}