import 'dart:async';
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_database/model/note.dart';
import 'package:socket_io_client/socket_io_client.dart';

class DatabaseRemoteServer {
  ///
  ///Criando Singlton
  ///
  static DatabaseRemoteServer helper = DatabaseRemoteServer._createInstance();

  DatabaseRemoteServer._createInstance();

  String databaseUrl = "https://si700.herokuapp.com/notes/";

  Dio _dio = Dio();

  // GET NOTE LIST
  Future<List<dynamic>> getNoteList() async {
    Response response = await _dio.request(
      this.databaseUrl,
      options: Options(
        method: "GET",
        headers: {
          "Accept": "application/json",
        },
      ),
    );

    List<Note> noteList = [];
    List<int> idList = [];

    response.data.forEach(
      (element) {
        element["dataLocation"] = 2;
        Note note = Note.fromMap(element);
        noteList.add(note);
        idList.add(element["id"]);
      },
    );

    return [noteList, idList];
  }

  // INSERT NOTE
  Future<int> insertNote(Note note) async {
    await _dio.post(
      this.databaseUrl,
      options: Options(headers: {"Accept": "application/json"}),
      data: jsonEncode(
        {
          "title": note.title,
          "description": note.description,
        },
      ),
    );
    return 1;
  }

  // UPDATE NOTE
  Future<int> updateNote(int noteId, Note note) async {
    await _dio.put(
      this.databaseUrl + "$noteId",
      options: Options(headers: {"Accept": "application/json"}),
      data: jsonEncode(
        {
          "title": note.title,
          "description": note.description,
        },
      ),
    );
    return 1;
  }

  // DELETE NOTE
  Future<int> deleteNote(int noteId) async {
    await _dio.delete(
      this.databaseUrl + "$noteId",
      options: Options(
        method: "GET",
        headers: {
          "Accept": "application/json",
        },
      ),
    );
    return 1;
  }

  ///
  /// STREAM -> Notifica quem quiser ouvir
  ///

  notify() async {
    if (_controller != null) {
      var response = await getNoteList();
      _controller.sink.add(response);
    }
  }

  Stream get stream {
    if (_controller == null) {
      _controller = StreamController.broadcast();

      Socket socket = io(
        'https://si700.herokuapp.com/',
        OptionBuilder().setTransports(['websocket']).build(),
      );
      socket.on('invalidate', (_) => notify());
    }
    return _controller.stream.asBroadcastStream();
  }

  dispose() {
    if (!_controller.hasListener) {
      _controller.close();
      _controller = null;
    }
  }

  static StreamController _controller;
}

// TESTES
void main() async {
  DatabaseRemoteServer noteService = DatabaseRemoteServer.helper;
  // var response = await noteService.getNoteList();
  // Note note = response[0][1];
  // print(note.title);
  Note note = Note();
  note.title = "Matheus Bruder";
  note.description = "Aluno de BSI Unicamp";
  //noteService.insertNote(note);
  //noteService.updateNote(0, note);
  noteService.deleteNote(0);
}
