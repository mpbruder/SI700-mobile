import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_database/logic/manage_db/manage_db_event.dart';
import 'package:flutter_database/logic/manage_db/manage_db_state.dart';
import 'package:flutter_database/model/note.dart';
import 'package:flutter/material.dart';

class NotesEntry<T extends Bloc<ManageEvent, ManageState>> extends StatelessWidget {
  final GlobalKey<FormState> formKey = new GlobalKey();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<T, ManageState>(
      builder: (context, state) {
        Note note;
        if (state is UpdateState) {
          note = state.previousNote;
        } else {
          note = new Note();
        }
        return Form(
          key: formKey,
          child: Column(
            children: [
              tituloFormField(note),
              descriptionFormField(note),
              submitButton(note, state, context),
              cancelButton(state, context)
            ],
          ),
        );
      },
    );
  }

  Widget tituloFormField(Note note) {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: TextFormField(
        initialValue: note.title,
        decoration: InputDecoration(
            labelText: "Título",
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
        validator: (value) {
          if (value.length == 0) {
            return "Adicione algum título";
          }
          return null;
        },
        onSaved: (value) {
          note.title = value;
        },
      ),
    );
  }

  Widget descriptionFormField(Note note) {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: TextFormField(
        initialValue: note.description,
        decoration: InputDecoration(
            labelText: "Anotação",
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
        validator: (value) {
          if (value.length == 0) {
            return "Adicione alguma anotação";
          }
          return null;
        },
        onSaved: (value) {
          note.description = value;
        },
      ),
    );
  }

  Widget submitButton(Note note, state, context) {
    return ElevatedButton(
        child:
            (state is UpdateState ? Text("Update Data") : Text("Insert Data")),
        onPressed: () {
          if (formKey.currentState.validate()) {
            formKey.currentState.save();
            BlocProvider.of<T>(context)
                .add(SubmitEvent(note: note));
          }
        });
  }

  Widget cancelButton(state, context) {
    return (state is UpdateState
        ? ElevatedButton(
            onPressed: () {
              BlocProvider.of<T>(context).add(UpdateCancel());
            },
            child: Text("Cancel Update"))
        : Container());
  }
}
