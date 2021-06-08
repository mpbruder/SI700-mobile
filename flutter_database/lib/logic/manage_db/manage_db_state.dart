import 'package:flutter_database/model/note.dart';

abstract class ManageState {}

class UpdateState extends ManageState {
  var noteId;
  Note previousNote;
  UpdateState({this.noteId, this.previousNote});
}

class InsertState extends ManageState {}
