import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_database/data/firestore/firestore_database.dart';
import 'package:flutter_database/logic/manage_db/manage_db_event.dart';
import 'package:flutter_database/logic/manage_db/manage_db_state.dart';

class ManageFirestoreRemoteBloc extends Bloc<ManageEvent, ManageState> {
  ManageFirestoreRemoteBloc() : super(InsertState());

  @override
  Stream<ManageState> mapEventToState(ManageEvent event) async* {
    if (event is DeleteEvent) {
      FirestoreRemoteServer.helper.deleteNote(event.noteId);
    } else if (event is UpdateRequest) {
      yield UpdateState(noteId: event.noteId, previousNote: event.previousNote);
    } else if (event is UpdateCancel) {
      yield InsertState();
    } else if (event is SubmitEvent) {
      if (state is InsertState) {
        FirestoreRemoteServer.helper.insertNote(event.note);
      } else if (state is UpdateState) {
        UpdateState updateState = state;
        FirestoreRemoteServer.helper.updateNote(updateState.noteId, event.note);
        yield InsertState();
      }
    }
  }
}
