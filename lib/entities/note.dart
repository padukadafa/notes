import 'package:objectbox/objectbox.dart';

@Entity()
class Note {
  @Id()
  int id;
  final String? title;
  final String? content;
  final int colorCode;
  @Property(type: PropertyType.date)
  final DateTime createdAt;
  @Property(type: PropertyType.date)
  final DateTime updatedAt;

  Note({
    required this.id,
    this.title,
    this.content,
    required this.colorCode,
    required this.createdAt,
    required this.updatedAt,
  });
  Note copyWith({
    int? id,
    String? title,
    String? content,
    int? colorCode,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Note(
      id: id ?? this.id,
      title: title ?? this.title,
      content: content ?? this.content,
      colorCode: colorCode ?? this.colorCode,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
