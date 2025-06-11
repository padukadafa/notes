import 'package:objectbox/objectbox.dart';

@Entity()
class Note {
  @Id()
  final String id;
  final String? title;
  final String? content;
  @Property(type: PropertyType.date)
  final DateTime createdAt;
  @Property(type: PropertyType.date)
  final DateTime updatedAt;

  Note({
    required this.id,
    required this.title,
    required this.content,
    required this.createdAt,
    required this.updatedAt,
  });
}
