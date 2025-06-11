import 'package:objectbox/objectbox.dart';

@Entity()
class Note {
  @Id()
  int id;
  final String? title;
  final String? content;
  @Property(type: PropertyType.date)
  final DateTime createdAt;
  @Property(type: PropertyType.date)
  final DateTime updatedAt;

  Note({
    required this.id,
    this.title,
    this.content,
    required this.createdAt,
    required this.updatedAt,
  });
  Note copyWith({
    int? id,
    String? title,
    String? content,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Note(
      id: id ?? this.id,
      title: title ?? this.title,
      content: content ?? this.content,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
