
   import '../Models/notes_Model.dart';

abstract  class note_state {

}
class noteInitialstate extends note_state{}
class noteLoadingstate extends note_state{}
class noteLoadedstate extends note_state{
  List<NotesModel> arrNotes;
  noteLoadedstate({required this.arrNotes});
}
class noteErrorstate extends note_state{
  String error_msg ;
  noteErrorstate({required this.error_msg});
}


