import 'package:notes/entities/note.dart';

class NoteRepository {
  Future<Note> addNote(Note note) async {
    throw UnimplementedError();
  }

  Future<Note?> getNoteById(String id) async {
    throw UnimplementedError();
  }

  Future<List<Note>> getAllNotes() async {
    throw UnimplementedError();
  }

  Future<void> updateNote(Note note) async {
    throw UnimplementedError();
  }

  Future<void> deleteNote(String id) async {
    throw UnimplementedError();
  }
}
