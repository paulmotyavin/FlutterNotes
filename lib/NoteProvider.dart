import 'package:flutter/cupertino.dart';
import 'note.dart';

class NoteProvider with ChangeNotifier {
  List<Note> _notes = [];

  List<Note> get notes => _notes;

  void add(Note note) {
    _notes.add(note);
    notifyListeners();
  }

  void edit(int id, String newText) {
    final index = _notes.indexWhere((note) => note.id == id);
    if (index != -1) {
      _notes[index] = Note(id: id, text: newText, date: DateTime.now());
      notifyListeners();
    }
  }

  void delete(int id) {
    _notes.removeWhere((note) => note.id == id);
    notifyListeners();
  }
}