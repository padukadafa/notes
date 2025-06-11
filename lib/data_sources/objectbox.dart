import 'package:notes/entities/note.dart';
import 'package:notes/objectbox.g.dart';

class ObjectBox {
  late final Store store;
  late final Box<Note> noteBox;
  ObjectBox._create(this.store) {
    noteBox = Box<Note>(store);
  }
  static Future<ObjectBox> create() async {
    final store = await openStore();
    return ObjectBox._create(store);
  }

  void deleteNote(int id) {
    noteBox.remove(id);
  }

  void addOrUpdateNote(Note note) {
    noteBox.put(note.copyWith(updatedAt: DateTime.now()));
  }

  Note? getNoteById(int id) {
    return noteBox.get(id);
  }

  Stream<List<Note>> getAllNotes() {
    final builder = noteBox.query()
      ..order(Note_.createdAt, flags: Order.descending);
    return builder.watch(triggerImmediately: true).map((query) {
      return query.find();
    });
  }
}
