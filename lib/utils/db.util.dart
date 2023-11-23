import 'dart:convert';

import 'package:projet/utils/note.model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DB {
  //Create default constructeur
  DB._();
  static DB get instance => DB._();

  //Preferences key
  final String key = 'notes';

  //Shared Preferences Instance
  SharedPreferences? _prefs;

  reset() async {
    _prefs = await SharedPreferences.getInstance();
  }

  //Get All Notes
  Future<List<Note>> get future async {
    await reset();
    if (_prefs?.getString(key) == null) {
      await _prefs?.setString(key, json.encode([]));
      await reset();
    }

    String? source = _prefs?.getString(key);
    List<Map<String, dynamic>> mapList = List.from(json.decode(source ?? '[]'));

    //Convert Map (Json) to Note List
    return mapList.map((e) => Note.ofJson(e)).toList();
  }

  //Update All notes
  _updateAll(List<Note> notes) async {
    await reset();
    await _prefs?.setString(
        key, json.encode(notes.map((e) => e.json).toList()));
  }

  //Insert
  insert(Note note) async {
    final notes = await future;
    notes.add(note);
    await _updateAll(notes);
  }

  //update
  update(Note note) async {
    final notes = await future;
    int ind = notes.indexWhere((e) => e.id == note.id);
    if (ind >= 0) {
      notes[ind] = note;
      await _updateAll(notes);
    }
  }

  //Delete
  delete(Note note) async {
    final notes = await future;
    int ind = notes.indexWhere((e) => e.id == note.id);
    if (ind >= 0) {
      notes.removeAt(ind);
      await _updateAll(notes);
    }
  }
}
